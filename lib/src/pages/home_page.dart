import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:la_quiniela/src/pages/nfl/apuestas_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser;
    return ApuestasPage();
  }
}
