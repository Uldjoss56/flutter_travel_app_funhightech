import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/home/home_page.dart';

class ReservatingColisStatus extends StatefulWidget {
  const ReservatingColisStatus({super.key});

  @override
  State<ReservatingColisStatus> createState() => _ReservatingColisStatusState();
}

class _ReservatingColisStatusState extends State<ReservatingColisStatus>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    // _animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {}
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(
          width / 20,
          width / 8,
          width / 20,
          width / 8,
        ),
        child: Card(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/LogoFUN.png",
                      width: width / 3,
                      height: width / 3,
                    ),
                    SizedBox(
                      height: width / 20,
                    ),
                    Column(
                      children: [
                        const Text(
                          "Succès de l'opération",
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                          ),
                        ),
                        const Text(
                          "Un retour vous sera fait par l'agence, pour confirmation",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Color(0xFF146CC2),
                          ),
                        ),
                        SizedBox(
                          height: width / 40,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => const HomePage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              "Compris",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ScaleTransition(
                  scale: _animation,
                  child: Image.asset(
                    "assets/images/passengers.jpg",
                    height: width / 2,
                    width: width / 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
