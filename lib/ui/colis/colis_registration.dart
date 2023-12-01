import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/registration/user_registration.dart';

class ColisRegistration extends StatefulWidget {
  const ColisRegistration({super.key});

  @override
  State<ColisRegistration> createState() => _ColisRegistrationState();
}

class _ColisRegistrationState extends State<ColisRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inscription",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: UserRegistration(
          onRegistrationState: (bool? state) {},
        ),
      ),
    );
  }
}
