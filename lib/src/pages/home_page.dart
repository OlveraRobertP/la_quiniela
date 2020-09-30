import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'nfl/main_nfl.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser;
    return MainNFLPage();
  }
}
