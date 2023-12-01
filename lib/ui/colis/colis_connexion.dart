import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/connexion/user_connexion.dart';

class ColisConnexion extends StatefulWidget {
  const ColisConnexion({super.key});

  @override
  State<ColisConnexion> createState() => _ColisConnexionState();
}

class _ColisConnexionState extends State<ColisConnexion> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Connexion",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(width / 20),
        child: UserConnexion(
          width: width,
          onConnexionState: (status) {},
        ),
      ),
    );
  }
}
