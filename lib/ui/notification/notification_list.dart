import 'package:flutter/material.dart';
import 'package:flutter_travel_app/data/reservation.dart';
import 'package:flutter_travel_app/data/user.dart';
import 'package:flutter_travel_app/services/reservation_service.dart';
import 'package:flutter_travel_app/ui/animations/propagation.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/shapes/bottom_bar.dart';
import 'package:flutter_travel_app/ui/notification/widget/notification_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  List<VoyageReservation>? _listReservations;
  final _reservationService = ReservationService();
  bool isUserConnected = false;
  VoyageClient? user;
  @override
  void initState() {
    super.initState();
    final model = ScopedModel.of<AppModel>(context);
    if (model.isUserConnected && model.connexionMessage == "Success") {
      isUserConnected = true;
      user = model.user;
      final userID = user!.contact;
      _loadHistory(userID);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          isUserConnected
              ? Column(
                  children: [
                    Material(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          width / 20,
                          width / 6,
                          width / 20,
                          width / 20,
                        ),
                        child: SizedBox(
                          width: width,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Text(
                                      "Activités   ",
                                      style: TextStyle(
                                        color: const Color(0xFF146CC2),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: width / 15,
                                      ),
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Text(
                                      "récentes ",
                                      style: TextStyle(
                                        color: const Color(0xFFF7941F),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: width / 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: width / 5,
                        ),
                        child: (_listReservations == null ||
                                _listReservations!.isEmpty)
                            ? const Center(
                                child: Text(
                                  "Aucune activité",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF146CC2),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _listReservations == null
                                    ? 0
                                    : _listReservations!.length,
                                itemBuilder: (context, index) {
                                  return NotificationTile(
                                    reservation: _listReservations![index],
                                    user: user!,
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(width / 10),
                        child: const WaveAnimation(
                          color: Color(0xFFF7941F),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/profile");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Connectez-vous",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
          const Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: BottomBar(
              height: 100,
              isTapedNotification: true,
            ),
          ),
        ],
      ),
    );
  }

  void _loadHistory(String userID) async {
    _listReservations = await _reservationService.getAll(userID);
    setState(() {});
  }
}
