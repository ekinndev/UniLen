import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:uniapp/settings/colors.dart';
import '../models/firebase_error.dart';
import '../providers/auth.dart';

enum AuthMode { Login, SignUp }
enum LoginStatus { None, Working }

class LoginScreen extends StatefulWidget {
  static const authRoute = '/auth';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _email = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final TextEditingController _pass = TextEditingController();
  final FocusNode _passFocus = FocusNode();

  final TextEditingController _confPass = TextEditingController();
  final FocusNode _confPassFocus = FocusNode();

  AuthMode _authMode = AuthMode.Login;
  LoginStatus _logStatus = LoginStatus.None;

  Future<void> girisYaDaKayitOl() async {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    final authProv = Provider.of<Auth>(context, listen: false);
    if (_pass.text.trim().length < 6 || !regex.hasMatch(_email.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Email ya da şifre geçersiz.'),
          duration: Duration(seconds: 2),
        ),
      );

      return;
    }
    if (_authMode == AuthMode.SignUp) {
      if (_pass.text.trim() != _confPass.text.trim()) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Şifreleriniz birbiriyle uyuşmuyor.'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }
    }

    setState(() {
      _logStatus = LoginStatus.Working;
    });
    try {
      if (_authMode == AuthMode.SignUp) {
        final response =
            await authProv.signUp(email: _email.text, password: _pass.text);
        if (response) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("Başarılı bir şekilde oluştu"),
              duration: Duration(seconds: 2),
            ),
          );
        }
        setState(() {
          _logStatus = LoginStatus.None;
        });
      } else {
        await authProv.logIn(email: _email.text, password: _pass.text);
      }
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        _logStatus = LoginStatus.None;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<Auth>(context, listen: false);

    return SafeArea(
      child: Stack(
        children: <Widget>[
          buildContainerArkaPlan(),
          buildContainerArkaPlanSiyahlik(),
          buildScaffoldLoginAna(context, authProv),
        ],
      ),
    );
  }

  Container buildContainerArkaPlan() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/login/duvar.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container buildContainerArkaPlanSiyahlik() {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
    );
  }

  Scaffold buildScaffoldLoginAna(BuildContext context, Auth authProv) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: _logStatus == LoginStatus.Working
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                        height: 180),
                    emailLogin(context),
                    socialMediaLogin(authProv),
                  ],
                ),
              ),
            ),
    );
  }

  Column socialMediaLogin(Auth authProv) {
    return Column(
      children: <Widget>[
        dividerliBaslik(),
        SizedBox(height: 20),
        sosyalMedyaButonlar(authProv),
        SizedBox(height: 20),
      ],
    );
  }

  Column emailLogin(BuildContext context) {
    return Column(
      children: <Widget>[
        buildTextField(
            'Email', false, _email, _emailFocus, TextInputAction.next, () {
          _emailFocus.unfocus();
          FocusScope.of(context).requestFocus(_passFocus);
        }),
        SizedBox(height: 20),
        buildTextField(
            'Şifre',
            true,
            _pass,
            _passFocus,
            _authMode == AuthMode.Login
                ? TextInputAction.done
                : TextInputAction.next, () {
          if (_authMode == AuthMode.Login) {
            _passFocus.unfocus();
            girisYaDaKayitOl();
          } else {
            _passFocus.unfocus();
            FocusScope.of(context).requestFocus(_confPassFocus);
          }
        }),
        SizedBox(height: 20),
        if (_authMode == AuthMode.SignUp)
          buildTextField(
              'Şifre', true, _confPass, _confPassFocus, TextInputAction.done,
              () {
            _confPassFocus.unfocus();
            girisYaDaKayitOl();
          }),
        if (_authMode == AuthMode.SignUp) SizedBox(height: 20),
        loginButton(
            context,
            _authMode == AuthMode.Login ? 'Giriş Yap' : 'Kayıt Ol',
            girisYaDaKayitOl),
        SizedBox(height: 20),
        authDegistirButton(
            context,
            _authMode == AuthMode.Login
                ? 'Hesabınız yok mu ?'
                : 'Zaten kayıtlı mısın ?',
            authDegistir),
        SizedBox(height: 20),
      ],
    );
  }

  ButtonBar sosyalMedyaButonlar(Auth authProv) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        sosyalMedyaButton(FontAwesome5Brands.google, Color(0xFFDD4B39), () {}),
        sosyalMedyaButton(
            FontAwesome5Brands.facebook_f, Color(0xFF4064AD), () {}),
      ],
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

  Widget authDegistirButton(BuildContext context, String text, Function fnk) {
    final kayitText = ' Şimdi kayıt olun.';
    final girisText = ' Giriş yap.';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(text, style: TextStyle(color: Colors.white)),
        InkWell(
          onTap: fnk,
          child: Text(_authMode == AuthMode.Login ? kayitText : girisText,
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
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

  Material loginButton(BuildContext context, String text, Function fnk) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: DanColor.anaRenk,
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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

  TextField buildTextField(
      String text,
      bool secure,
      TextEditingController textedit,
      FocusNode fNode,
      TextInputAction txtInputAction,
      Function fnk) {
    return TextField(
      textInputAction: txtInputAction,
      focusNode: fNode,
      onSubmitted: (val) {
        fnk();
      },
      controller: textedit,
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
