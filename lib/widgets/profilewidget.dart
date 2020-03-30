import 'package:flutter/material.dart';
import 'package:uniapp/models/user.dart';

class ProfileWidget extends StatelessWidget {
  final User user;
  ProfileWidget(this.user);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
            minRadius: 25,
            backgroundImage:
                NetworkImage(user.photoUrl),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                user.name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                user.email,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
