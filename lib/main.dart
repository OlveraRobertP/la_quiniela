import 'package:flutter/material.dart';
import 'package:la_quiniela/src/pages/commons/not_found_page.dart';
import 'package:la_quiniela/src/routes/routes.dart';
import 'package:la_quiniela/src/style/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initilization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.error);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Text('Errros '),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return initMainPage(context);
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Text('Loagind'),
        );
      },
    );
  }
}

Widget initMainPage(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'La Quiniela',
    theme: getAppTheme(),
    initialRoute: '/',
    routes: getApplicationsRouts(),
    onGenerateRoute: (RouteSettings settings) {
      //Ruta cuando no encuentra
      return MaterialPageRoute(builder: (context) => NotFoundPage());
    },
  );
}
