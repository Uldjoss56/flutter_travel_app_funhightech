import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/home/home_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: height / 800,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/LogoFUN.png",
                height: width / 2,
                width: width / 2,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: const Text(
                "Plateforme de gestion des agences de voyages",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color(0xFF146CC2),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            RichText(
              text: const TextSpan(
                children: [
                  WidgetSpan(
                    child: Text(
                      "Gérer tous vos ",
                      style: TextStyle(
                        color: Color(0xFF146CC2),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    child: Text(
                      "voyages ",
                      style: TextStyle(
                        color: Color(0xFFF7941F),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        //fontSize: 20,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    child: Text(
                      "nationaux, ",
                      style: TextStyle(
                        color: Color(0xFF146CC2),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    child: Text(
                      "réservez ",
                      style: TextStyle(
                        color: Color(0xFFF7941F),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        //fontSize: 20,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    child: Text(
                      "vos places, et surtout, soyez à l'heure ! ",
                      style: TextStyle(
                        color: Color(0xFF146CC2),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.asset(
                "assets/images/bus_blue.jpg",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF7941F),
                foregroundColor: Colors.white,
                minimumSize: const Size(300, 50),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
              child: const Text(
                'Commencer',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
