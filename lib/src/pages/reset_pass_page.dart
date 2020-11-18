import 'package:flutter/material.dart';
import 'package:la_quiniela/src/services/auth.dart';
import 'package:la_quiniela/src/utils/ui_utils.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final AuthService _auth = AuthService();

  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Contraseña'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          ListTile(
            title: Text('Recuperacion de Contraseña'),
            subtitle: Text('Ingrese Email Registrado'),
          ),
          Divider(),
          _crearEmail(),
          Divider(),
          _crearRegistrationButton(_email),
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

  Widget _crearRegistrationButton(String email) {
    return RaisedButton(
        child: Text('Recuperar'),
        textColor: Theme.of(context).primaryColor,
        shape: StadiumBorder(),
        onPressed: () async {
          if (_email == null) {
            mostrarAlert(
              context: context,
              title: 'Error !!!',
              text: 'Ingrese correo válido',
              onPressedOk: () {
                Navigator.of(context).pop();
              },
            );
            return;
          }
          await _auth.resetPassword(email).then((value) {
            mostrarAlert(
              context: context,
              title: 'Exito !!!',
              text: 'Se ha enviado instrucciones de reseteo al correo $email',
              onPressedOk: () {
                Navigator.of(context).pop();
              },
            );
          }).catchError((e) {
            String errorMsg = e.message;

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
