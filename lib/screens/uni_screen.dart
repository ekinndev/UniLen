import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:uniapp/settings/constants.dart';
import 'package:uniapp/widgets/drawer.dart';
import '../providers/auth.dart';
import '../models/universite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../widgets/ust_ana_kart.dart';
import 'package:http/http.dart' as http;
import './universite_detail_screen.dart';

class UniScreen extends StatefulWidget {
  static const uniScreenRoute = '/uniscreen';

  @override
  _UniScreenState createState() => _UniScreenState();
}

class _UniScreenState extends State<UniScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Universite> _universiteVeriler = [];
  List<Universite> _searchUniler = [];

  bool isLoading = false;
  bool isLocked = false;
  String hataMesaji;
  var listener;
  final int uniSayisiLimit = 10;
  int _basIndex = 1;
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  final TextEditingController textCtrl = TextEditingController();
  final FocusNode textFocus = FocusNode();
  /////////////////////////////////////////////////////////////////////////////
  Future<void> unileriCek([bool arama = false]) async {
    try {
      setState(() {
        isLoading = true;
      });
      List<Universite> uniCekilen = [];
      final token = Provider.of<Auth>(context, listen: false).token;
      http.Response uniJson;
      if (arama) {
        uniJson = await http.get(
            'https://danisman-akademi-94376.firebaseio.com/universiteler.json?orderBy="uniId"&startAt=1');
      } else {
        uniJson = await http.get(
            'https://danisman-akademi-94376.firebaseio.com/universiteler.json?auth=$token&orderBy="uniId"&startAt=$_basIndex&limitToFirst=$uniSayisiLimit');
      }

      final Map<String, dynamic> veri = jsonDecode(uniJson.body);
      veri.forEach((f, s) {
        final Universite uni = Universite(
            uniAd: s['uniAd'].toString(),
            uniAdres: s['uniAdres'].toString(),
            uniId: s['uniId'].toString(),
            uniKod: s['uniKodu'].toString(),
            uniMail: s['uniMail'].toString());
        uniCekilen.add(uni);
      });

      setState(() {
        if (arama) {
          _searchUniler.addAll(uniCekilen);
        } else {
          _universiteVeriler.addAll(uniCekilen);
        }

        isLoading = false;
        isLocked = false;
      });
    } on SocketException {
      setState(() {
        hataMesaji = 'İnternet bağlantısı ya da veri yok.';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        hataMesaji = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    unileriCek();
    listener = () {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLocked) {
        isLocked = true;
        _basIndex += uniSayisiLimit;
        unileriCek();
      }
    };
    _scrollController.addListener(listener);
  }

  Future<void> aramaYap() async {
    textFocus.unfocus();
    _scrollController.removeListener(listener);
    if (_searchUniler.length <= 0) {
      await unileriCek(true);
    }
    setState(() {
      _universiteVeriler = _searchUniler.where((uni) {
        RegExp regex =
            RegExp(textCtrl.text.toLowerCase(), caseSensitive: false);

        return regex.hasMatch(uni.uniAd.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AnaDrawer(),
      appBar: buildAppBar(),
      extendBodyBehindAppBar: true,
      body: buildColumnUniAna(context),
    );
  }

  Column buildColumnUniAna(BuildContext context) {
    return Column(
      children: <Widget>[
        UstAnaKart(
          subtitle: 'Üniversitelere hızlı ulaşım.',
          title: 'Üniversiteler',
          icon: SimpleLineIcons.graduation,
        ),
        buildExpandedUniList(context),
        if (isLoading && _basIndex > 1) Constants.progressIndicator,
      ],
    );
  }

  Expanded buildExpandedUniList(BuildContext context) {
    return Expanded(
      child: isLoading == true && _basIndex == 1
          ? Center(
              child: Constants.progressIndicator,
            )
          : _universiteVeriler.isEmpty
              ? Center(child: Text('İnternet bağlantısı ya da veri yok.'))
              : ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            UniversiteDetail.universiteDetailRoute,
                            arguments: {
                              "kod": _universiteVeriler[i].uniKod,
                              "uniAdi": _universiteVeriler[i].uniAd,
                              "resimId": _universiteVeriler[i].uniId,
                            });
                      },
                      child: UniCard(
                        uni: _universiteVeriler[i],
                      ),
                    );
                  },
                  itemCount: _universiteVeriler.length,
                ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: TextField(
        onSubmitted: (val) {
          aramaYap();
        },
        focusNode: textFocus,
        controller: textCtrl,
        style: TextStyle(color: Colors.white, fontSize: 14, height: 1.3),
        decoration: InputDecoration(
          hintText: 'Üniversite Ara',
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: aramaYap,
        )
      ],
    );
  }
}

class UniCard extends StatelessWidget {
  final Universite uni;

  const UniCard({this.uni});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 8, right: 8),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.37,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/unicardBg.jpg',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.37,
              width: double.infinity,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.37,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Hero(
                      tag: "uniLogo${uni.uniId}",
                      child: Image.asset('assets/logolar/${uni.uniId}.png',
                          fit: BoxFit.cover),
                    ),
                    radius: 40,
                  ),
                ),
                Text(
                  uni.uniAd,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  uni.uniMail,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  uni.uniAdres,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
