import 'package:flutter/material.dart';
import 'package:la_quiniela/src/pages/home_page.dart';
import 'package:la_quiniela/src/pages/login_page.dart';
import 'package:la_quiniela/src/pages/registration_page.dart';

getApplicationsRouts() => <String, WidgetBuilder>{
      '/': (BuildContext context) => LoginPage(),
      '/home': (BuildContext context) => HomePage(),
      '/registration': (BuildContext context) => RegistrationPage(),
      // '/avatar': (BuildContext context) => AvatarPage(),
      // '/card': (BuildContext context) => CardPage(),
    };
