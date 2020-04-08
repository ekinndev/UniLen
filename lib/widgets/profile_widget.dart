import 'package:flutter/material.dart';
import 'package:uniapp/models/user.dart';

class ProfileWidget extends StatelessWidget {
  final User _user;
  ProfileWidget(this._user);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
            minRadius: 25,
            backgroundImage:
                NetworkImage(_user.photoUrl),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                _user.name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(
                _user.email,
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
