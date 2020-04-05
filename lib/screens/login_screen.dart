import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

enum AuthMode { Login, SignUp }
enum LoginStatus { None, Working }

class LoginScreen extends StatefulWidget {
  static const authRoute = '/auth';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _LoginScreenState extends State<LoginScreen> {
  AuthMode _authMode = AuthMode.Login;
  LoginStatus _logStatus = LoginStatus.None;
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
            key: _scaffoldKey,
            backgroundColor: Colors.transparent,
            body: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: _logStatus == LoginStatus.None
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                            'https://seeklogo.com/images/S/school-education-inspiration-logo-A8AD603C93-seeklogo.com.png',
                            height: 180,
                          ),
                          buildTextField(
                              SimpleLineIcons.envelope, 'Email', false),
                          SizedBox(height: 20),
                          buildTextField(SimpleLineIcons.lock, 'Şifre', true),
                          SizedBox(height: 20),
                          if (_authMode == AuthMode.SignUp)
                            buildTextField(SimpleLineIcons.lock, 'Şifre', true),
                          if (_authMode == AuthMode.SignUp)
                            SizedBox(height: 20),
                          loginButton(
                              context,
                              _authMode == AuthMode.Login
                                  ? 'Giriş Yap'
                                  : 'Kayıt Ol',
                              () {}),
                          SizedBox(height: 10),
                          loginButton(
                              context,
                              _authMode == AuthMode.Login
                                  ? 'Email ile Kayıt Ol'
                                  : 'Email ile Giriş Yap',
                              authDegistir),
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
                                      .handleSignInGoogle),
                              sosyalMedyaButton(FontAwesome5Brands.facebook_f,
                                  Color(0xFF4064AD), () {}),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void authDegistir() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
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

  Material loginButton(BuildContext context, String text, Function fnk) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff009cc2),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: fnk,
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
        setState(() {
          _logStatus = LoginStatus.Working;
        });
        try {
          await fnk();
        } catch (e) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
              ),
              duration: Duration(seconds: 2),
            ),
          );
          setState(() {
            _logStatus = LoginStatus.None;
          });
        }
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
