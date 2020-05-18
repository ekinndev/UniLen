import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UstAnaKart extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String lottie;

  UstAnaKart({this.title, this.subtitle, this.icon, this.lottie});

  @override
  _UstAnaKartState createState() => _UstAnaKartState();
}

class _UstAnaKartState extends State<UstAnaKart> with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: MediaQuery.of(context).size.height * 0.32,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: widget.lottie == null
                      ? Icon(
                          widget.icon,
                          size: 100,
                          color: Colors.white12,
                        )
                      : Container(
                          height: 110,
                          width: 110,
                          child: Lottie.asset(
                            widget.lottie,
                            repeat: false,
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                            controller: _controller,
                            onLoaded: (composition) {
                              _controller
                                ..duration = Duration(seconds: 2)
                                ..forward();
                            },
                          ),
                        ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
