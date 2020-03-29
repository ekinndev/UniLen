import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class LoginScreen extends StatelessWidget {
  static const authRoute = '/auth';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login/duvar.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      'https://seeklogo.com/images/S/school-education-inspiration-logo-A8AD603C93-seeklogo.com.png',
                      height: 180,
                    ),
                    buildTextField(SimpleLineIcons.envelope, 'Email', false),
                    SizedBox(height: 20),
                    buildTextField(SimpleLineIcons.lock, 'Şifre', true),
                    SizedBox(height: 20),
                    loginButton(context, 'Giriş Yap'),
                    SizedBox(height: 10),
                    loginButton(context, 'Email ile Kayıt Ol'),
                    SizedBox(height: 20),
                    dividerliBaslik(),
                    SizedBox(height: 20),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        sosyalMedyaButton(
                            FontAwesome5Brands.google,
                            Color(0xFFDD4B39),
                            Provider.of<Auth>(context, listen: false)
                                .handleSignIn),
                        sosyalMedyaButton(FontAwesome5Brands.facebook_f,
                            Color(0xFF4064AD), () {}),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row dividerliBaslik() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Sosyal Medya ile Giriş',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Material loginButton(BuildContext context, String text) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009cc2),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  RawMaterialButton sosyalMedyaButton(
      IconData iconData, Color color, Function fnk) {
    return RawMaterialButton(
      onPressed: () async {
        await fnk();
      },
      child: Icon(
        iconData,
        color: Colors.white,
        size: 35.0,
      ),
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor: color,
      padding: const EdgeInsets.all(15.0),
    );
  }

  TextField buildTextField(IconData iconData, String text, bool secure) {
    return TextField(
      obscureText: secure,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        labelText: text,
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
        hintText: text,
        contentPadding: EdgeInsets.all(12),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
