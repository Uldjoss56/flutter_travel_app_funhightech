import 'package:flutter/material.dart';
import 'package:flutter_travel_app/data/user.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/profile/profile_page.dart';
import 'package:flutter_travel_app/ui/registration/user_registration.dart';
import 'package:scoped_model/scoped_model.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({
    super.key,
    this.user,
  });
  final VoyageClient? user;

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modification du profil",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: width / 10,
            ),
            UserRegistration(
              onRegistrationState: (state) {
                if (state == true) {
                  final model = ScopedModel.of<AppModel>(context);
                  model.deconnectUser();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const ProfilePage(),
                    ),
                  );
                }
              },
              user: widget.user,
            ),
          ],
        ),
      ),
    );
  }
}
