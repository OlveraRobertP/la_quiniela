import 'package:flutter/material.dart';
import 'package:la_quiniela/src/services/auth.dart';
import 'package:la_quiniela/src/utils/ui_utils.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final AuthService _auth = AuthService();

  String _email;

  String _password;

  String _passwordConfirm;

  @override
  Widget build(BuildContext context) {
    return _crearRegistrationPage();
  }

  Widget _crearRegistrationPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          ListTile(
            title: Text('Registro de Usuario'),
            subtitle: Text('Ingrese Email y Contraseña'),
          ),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearPassword(),
          Divider(),
          _crearPasswordConfirm(),
          Divider(),
          _crearRegistrationButton(_email, _password),
          Divider(),
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            labelText: 'Email',
            suffixIcon: Icon(Icons.alternate_email),
            icon: Icon(Icons.email)),
        onChanged: (valor) => setState(() {
              _email = valor;
            }));
  }

  Widget _crearPassword() {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            labelText: 'Contraseña',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
        onChanged: (valor) => setState(() {
              _password = valor;
            }));
  }

  Widget _crearPasswordConfirm() {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            labelText: 'Confirmar Contraseña',
            suffixIcon: Icon(Icons.lock_open),
            icon: Icon(Icons.lock)),
        onChanged: (valor) => setState(() {
              _passwordConfirm = valor;
            }));
  }

  Widget _crearRegistrationButton(String email, String password) {
    return RaisedButton(
        child: Text('Registro'),
        textColor: Theme.of(context).primaryColor,
        shape: StadiumBorder(),
        onPressed: () async {
          if (_password != _passwordConfirm) {
            mostrarAlert(
              context: context,
              title: 'Error !!!',
              text: 'Las contraseñas deben ser iguales',
              onPressedOk: () {
                Navigator.of(context).pop();
              },
            );
            return;
          }
          await _auth.registration(email, password).then((value) {
            mostrarAlert(
              context: context,
              title: 'Exito !!!',
              text: 'Usuario registrado correctamente',
              onPressedOk: () {
                Navigator.of(context).pop();
              },
            );
          }).catchError((e) {
            String errorMsg = e.message;
            if (e.code == 'invalid-email') {
              errorMsg = 'Correo electronico no valido';
            } else if (e.code == 'email-already-in-use') {
              errorMsg = 'Correo electronico ya se encuentra registrado';
            } else if (e.code == 'user-disabled') {
              errorMsg = 'El usuario ha sido inhabilitado';
            } else if (e.code == 'user-not-found') {
              errorMsg = 'Correo no encontrado';
            } else if (e.code == 'wrong-password' ||
                e.code == 'weak-password') {
              errorMsg = 'La contraseña debe tener al menos 6 caracteres';
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
        });
  }
}
