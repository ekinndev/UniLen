import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniapp/widgets/ustanakart.dart';
import '../widgets/unicard.dart';

class UniScreen extends StatelessWidget {
  static const uniScreenRoute = '/uniscreen';
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
          UstAnaKart(subtitle: 'Üniversitelere hızlı ulaşım.',title: 'Üniversiteler',icon: SimpleLineIcons.graduation,),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, i) {
                return UniCard();
              },
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
