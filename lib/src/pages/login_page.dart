import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:la_quiniela/src/pages/home_page.dart';
import 'package:la_quiniela/src/pages/reset_pass_page.dart';
import 'package:la_quiniela/src/services/auth.dart';
import 'package:la_quiniela/src/style/app_theme.dart';
import 'package:la_quiniela/src/utils/ui_utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  String _email;

  String _password;

  @override
  Widget build(BuildContext context) {
    User us = FirebaseAuth.instance.currentUser;
    if (us == null) {
      return _crearLogin();
    } else {
      return _crearHome();
    }
  }

  Widget _crearHome() {
    return HomePage();
  }

  Widget _crearLogin() {
    return Scaffold(
      backgroundColor: Color(0xFF862633),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/logo.png'),
            height: 300.0,
            fit: BoxFit.fitHeight,
          ),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearLoginButton(),
          //Divider(),
          _crearRegistrationButton(),
          Divider(),
          FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPasswordPage()));
              },
              child: Text(
                'Olvidaste tu contraseña?',
                style: TextStyle(color: Colors.white),
              )),
          Divider(),
          SignInButton(
            Buttons.Google,
            text: 'Login con cuenta Google',
            shape: StadiumBorder(),
            onPressed: () {
              setState(() async {
                await _auth.signInWithGoogle();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              });
            },
          ),
          // Divider(),
          // SignInButton(
          //   Buttons.FacebookNew,
          //   shape: StadiumBorder(),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }

  Widget _crearRegistrationButton() {
    return RaisedButton(
        child: Text('Registro'),
        textColor: Theme.of(context).primaryColor,
        shape: StadiumBorder(),
        onPressed: () async {
          Navigator.pushNamed(context, '/registration');
        });
  }

  Widget _crearLoginButton() {
    return RaisedButton(
        child: Text('Login'),
        textColor: Theme.of(context).primaryColor,
        shape: StadiumBorder(),
        onPressed: () async {
          if (_email != null && _password != null) {
            await _auth.singInEmail(_email, _password).then((value) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            }).catchError((e) {
              String errorMsg = e.message;
              if (e.code == 'user-not-found') {
                errorMsg = 'Usuario o Contraseña incorrectos';
              } else if (e.code == 'wrong-password') {
                errorMsg = 'Usuario o Contraseña incorrectos';
              }
              mostrarAlert(
                context: context,
                title: 'Error !!!',
                text: '$errorMsg',
                onPressedOk: () {
                  Navigator.of(context).pop();
                },
              );
            });
          } else {
            mostrarAlert(
              context: context,
              title: 'Error !!!',
              text: 'Usuario y Contraseña son obligatorios',
              onPressedOk: () {
                Navigator.of(context).pop();
              },
            );
          }
        });
  }

  Widget _crearEmail() {
    return Theme(
      data: getLoginTheme(),
      child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              labelText: 'Email',
              suffixIcon: Icon(Icons.alternate_email),
              icon: Icon(Icons.email)),
          onChanged: (valor) => setState(() {
                _email = valor;
              })),
    );
  }

  Widget _crearPassword() {
    return Theme(
      data: getLoginTheme(),
      child: TextField(
          obscureText: true,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              labelText: 'Contraseña',
              suffixIcon: Icon(Icons.lock_open),
              icon: Icon(Icons.lock)),
          onChanged: (valor) => setState(() {
                _password = valor;
              })),
    );
  }
}
