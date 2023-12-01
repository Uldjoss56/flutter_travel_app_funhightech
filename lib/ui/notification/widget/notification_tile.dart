import 'package:flutter/material.dart';
import 'package:flutter_travel_app/data/reservation.dart';
import 'package:flutter_travel_app/data/user.dart';
import 'package:flutter_travel_app/ui/notification/payment_details.dart';
import 'package:flutter_travel_app/ui/shapes/notification_widget_clipper.dart';
import 'package:intl/intl.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.reservation,
    required this.user,
  });

  final VoyageReservation reservation;
  final VoyageClient user;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat("##,###", "fr");
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PaymentDetail(
              voyageReservation: reservation,
              user: user,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: ClipPath(
          clipper: NotificationClipper(),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Color(0xFFE7E7E8),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: const Color(0xFFF7941F),
                    ),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFF7941F),
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      "assets/images/bus_forward.png",
                      fit: BoxFit.cover,
                      height: width / 20,
                      width: width / 20,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            width / 40,
                            width / 40,
                            width / 40,
                          ),
                          child: Text(
                            "${reservation.dateVoyage}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF212121),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: width / 25,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(width / 40),
                          child: Text(
                            "XOF ${format.format(double.parse(reservation.prix!).toInt())}",
                            style: TextStyle(
                              color: const Color(0xFF212121),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: width / 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Text(
                              reservation.lieuDepart ?? "...",
                              style: TextStyle(
                                color: const Color(0xFF146CC2),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: width / 20,
                              ),
                            ),
                          ),
                          const WidgetSpan(
                            child: Icon(
                              Icons.arrow_right,
                              color: Color(0xFF146CC2),
                            ),
                          ),
                          WidgetSpan(
                            child: Text(
                              reservation.lieuArrivee ?? "...",
                              style: TextStyle(
                                color: const Color(0xFF146CC2),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: width / 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
