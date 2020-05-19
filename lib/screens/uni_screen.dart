import 'package:provider/provider.dart';
import 'package:uniapp/providers/uni.dart';
import 'package:uniapp/settings/constants.dart';
import 'package:uniapp/widgets/drawer.dart';
import '../models/universite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../widgets/ust_ana_kart.dart';
import './universite_detail_screen.dart';

class UniScreen extends StatefulWidget {
  static const uniScreenRoute = '/uniscreen';

  @override
  _UniScreenState createState() => _UniScreenState();
}

class _UniScreenState extends State<UniScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Universite> _universiteVeriler = [];
  Future<void> _future;
  bool isSearch = false;
  bool isLocked = false;
  String hataMesaji;
  var listener;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  final TextEditingController textCtrl = TextEditingController();
  final FocusNode textFocus = FocusNode();
  /////////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    _future = Provider.of<Uni>(context, listen: false).universiteleriCek();
    listener = () {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLocked) {
        setStateIfMounted(() {
          isLocked = true;
        });
        Provider.of<Uni>(context, listen: false)
            .universiteleriCek()
            .then((value) {
          setStateIfMounted(() {
            isLocked = false;
          });
        });
      }
    };
    _scrollController.addListener(listener);
  }

  void setStateIfMounted(f) {
    if (mounted) {
      setState(f);
    }
  }

  Future<void> aramaYap() async {
    textFocus.unfocus();
    _scrollController.removeListener(listener);

    setStateIfMounted(() {
      isSearch = true;
      _future =
          Provider.of<Uni>(context, listen: false).aramaYap(textCtrl.text);
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
          lottie: 'assets/lottie/university.json',
        ),
        buildExpandedUniList(context),
        if (isLocked) LinearProgressIndicator(),
      ],
    );
  }

  Widget buildExpandedUniList(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Constants.progressIndicator;
          }
          return Consumer<Uni>(
            builder: (__, prov, child) {
              _universiteVeriler =
                  isSearch ? prov.searchResult : prov.universiteler;
              return ListView.builder(
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
              );
            },
          );
        },
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
