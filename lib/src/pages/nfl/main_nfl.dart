import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:la_quiniela/src/pages/nfl/apuestas_page.dart';
import 'package:la_quiniela/src/pages/nfl/resultados_page.dart';

import '../login_page.dart';
import 'apuestas_partido.dart';
import 'mis_apuestas.dart';

class MainNFLPage extends StatefulWidget {
  MainNFLPage({Key key}) : super(key: key);

  @override
  _MainNFLPageState createState() => _MainNFLPageState();
}

class _MainNFLPageState extends State<MainNFLPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    //Center(child: ApuestasPage()),
    ApuestasPage(),
    MisApuestasPage(),
    ApuestasPorPartidoPage(),
    ResultadosPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NFL'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: 'Salir',
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Apuesta'),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_football_outlined),
                label: 'Mis Apuestas'),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_bar), label: 'Partidos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.gavel), label: 'Resultados'),
            // BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Partido'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF862633),
          onTap: _onItemTapped,
        ));
  }
}
