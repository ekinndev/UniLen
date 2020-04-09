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
  List<Universite> _universiteVeriler;

  Future<List<Universite>> unileriCek() async {
    final token = Provider.of<Auth>(context, listen: false).token;
    final uniJson = await http.get(
        'https://danisman-akademi-94376.firebaseio.com/universiteler.json?auth=$token');

    final List<dynamic> jsonUniJson = jsonDecode(uniJson.body);
    final List<Universite> uniler = jsonUniJson
        .map((f) => Universite(
            uniAd: f['uniad'],
            uniAdres: f['unimail'],
            uniMail: f['uniadres'],
            uniId: f['uniid']))
        .toList();
    return uniler;
  }

  @override
  void initState() {
    super.initState();
    unileriCek().then((veriler) {
      setState(() {
        _universiteVeriler = veriler;
      });
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
            child: _universiteVeriler == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              UniversiteDetail.universiteDetailRoute,
                              arguments: {
                                "kod":"1086",
                                "uniAdi":_universiteVeriler[i].uniAd.toString(),
                                "resimId":_universiteVeriler[i].uniId,
                              });
                        },
                        child: UniCard(
                          uni: _universiteVeriler[i],
                        ),
                      );
                    },
                    itemCount: 5,
                  ),
          ),
        ],
      ),
    );
  }
}
