import 'package:flutter/material.dart';
import 'package:uniapp/settings/colors.dart';
import '../widgets/ustanakart.dart';
import '../settings/icons.dart';

class GrafikScreen extends StatelessWidget {
  static const grafikScreenRoute = '/grafik_screen';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Durumunuz'),
          actions: <Widget>[
            Icon(Icons.search),
            SizedBox(
              width: 15,
            ),
            Icon(Icons.notifications_none),
            SizedBox(
              width: 5,
            ),
          ],
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: <Widget>[
            UstAnaKart(
              subtitle: '',
              title: 'Grafikleriniz',
              icon: DanIcons.grafikIcon.icon,
            ),
            Container(
              color: DanColor.anaRenk,
              child: TabBar(
                indicator: UnderlineTabIndicator(insets: EdgeInsets.all(1)),
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
              ),
            ),
            
          ],
          
        ),
      ),
    );
  }
}
