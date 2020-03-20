import 'dart:convert';
import '../models/universite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniapp/widgets/ustanakart.dart';
import '../widgets/unicard.dart';
import 'package:http/http.dart' as http;

class UniScreen extends StatelessWidget {
  static const uniScreenRoute = '/uniscreen';

  Future<List<Universite>> unileriCek() async {
    final uniJson = await http.get(
        'https://danisman-akademi-94376.firebaseio.com/universiteler.json');

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
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: FutureBuilder<List<dynamic>>(
                future: unileriCek(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx, i) {
                      return UniCard(
                        uni: snapshot.data[i],
                      );
                    },
                    itemCount: 5,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
