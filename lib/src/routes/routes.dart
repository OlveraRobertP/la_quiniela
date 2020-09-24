import 'package:flutter/material.dart';
import 'package:la_quiniela/src/pages/login_page.dart';

getApplicationsRouts() => <String, WidgetBuilder>{
      '/': (BuildContext context) => LoginPage(),
      // '/alert': (BuildContext context) => AlertPage(),
      // '/avatar': (BuildContext context) => AvatarPage(),
      // '/card': (BuildContext context) => CardPage(),
    };
