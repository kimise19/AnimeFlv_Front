import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 114, 114, 114)
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(65),
          children: [
            ListTile(
              leading: Icon(Icons.my_library_music_sharp, color: Colors.white),
              title: Text('Inicio', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Definir la acción al hacer clic en "Inicio"
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.search, color: Colors.white),
              title: Text('Explorar', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Definir la acción al hacer clic en "Explorar"
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.playlist_play, color: Colors.white),
              title: Text('Listas', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Definir la acción al hacer clic en "Listas"
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: Colors.white),
              title: Text('Historial', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Definir la acción al hacer clic en "Historial"
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('Ajustes', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Definir la acción al hacer clic en "Ajustes"
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
