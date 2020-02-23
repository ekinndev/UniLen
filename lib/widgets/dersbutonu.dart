import 'package:flutter/material.dart';

class DersButonu extends StatelessWidget {
  final Icon icon;
  final String text;
  final Color renk;
  DersButonu(this.icon, this.text, this.renk);
  @override
  Widget build(
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                minRadius: 25,
                child: icon,
                backgroundColor: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [renk, renk.withOpacity(0.7)],
            ),
            boxShadow: [
              BoxShadow(color: Colors.black),
            ]),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.46, maxHeight: 70),
      ),
    );
  }
}
