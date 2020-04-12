import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:uniapp/widgets/drawer.dart';
import '../providers/auth.dart';
import '../models/universite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../widgets/ust_ana_kart.dart';
import '../widgets/uni_cart.dart';
import 'package:http/http.dart' as http;
import './universite_detail_screen.dart';

class UniScreen extends StatefulWidget {
  static const uniScreenRoute = '/uniscreen';

  @override
  _UniScreenState createState() => _UniScreenState();
}

class _UniScreenState extends State<UniScreen> {
  ScrollController _scrollController = ScrollController();
  List<Universite> _universiteVeriler = [];
  bool isLoading = false;
  bool isLocked=false;
  final int uniSayisiLimit = 10;
  int _basIndex = 1;
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> unileriCek() async {
    setState(() {
      isLoading = true;
    });
    List<Universite> uniCekilen = [];
    final token = Provider.of<Auth>(context, listen: false).token;
    final uniJson = await http.get(
        'https://danisman-akademi-94376.firebaseio.com/universiteler.json?auth=$token&orderBy="uniId"&startAt=$_basIndex&limitToFirst=$uniSayisiLimit');
    final Map<String, dynamic> veri = jsonDecode(uniJson.body);
    veri.forEach((f, s) {
      final Universite uni = Universite(
          uniAd: s['uniAd'],
          uniAdres: s['uniAdres'],
          uniId: s['uniId'].toString(),
          uniKod: s['uniKodu'].toString(),
          uniMail: s['uniMail']);
      uniCekilen.add(uni);
    });

    setState(() {
      _universiteVeriler.addAll(uniCekilen);
      isLoading = false;
      isLocked=false;
    });
  }

  @override
  void initState() {
    super.initState();
    unileriCek();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent && !isLocked) {
          isLocked=true;
        _basIndex += uniSayisiLimit;
        unileriCek();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AnaDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: <Widget>[
          UstAnaKart(
            subtitle: 'Üniversitelere hızlı ulaşım.',
            title: 'Üniversiteler',
            icon: SimpleLineIcons.graduation,
          ),
          Expanded(
            child: isLoading == true && _basIndex == 1
                ? Center(
                    child: CircularProgressIndicator(),
                  )
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
                                "uniAdi":
                                    _universiteVeriler[i].uniAd,
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
          ),
          if (isLoading && _basIndex>1) CircularProgressIndicator(),
        ],
      ),
    );
  }
}
