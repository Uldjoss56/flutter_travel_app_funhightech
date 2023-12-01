import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/shapes/bottom_clipper.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.height,
    this.isTapedHome,
    this.isTapedNotification,
    this.isTapedProfile,
    this.isTapedSearch,
  }) : super(key: key);

  final double height;
  final bool? isTapedHome;
  final bool? isTapedNotification;
  final bool? isTapedProfile;
  final bool? isTapedSearch;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomBarCustomedPart2(),
      child: Container(
        color: const Color(0xFF146CC2),
        child: ClipPath(
          clipper: BottomBarCustomed(),
          child: BottomAppBar(
            elevation: 10,
            color: const Color(0xFFF7941F),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: isTapedHome ?? false
                            ? const Color(0x44FFFFFF)
                            : null,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.home),
                        color: const Color(0xFFFFFFFF),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            "/home",
                            (route) => false,
                          );
                        },
                      ),
                    ),
                    isTapedHome ?? false
                        ? Container(
                            color: Colors.white,
                            height: 4,
                            width: 20,
                          )
                        : const SizedBox(),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: isTapedSearch ?? false
                            ? const Color(0x44FFFFFF)
                            : null,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        color: const Color(0xFFFFFFFF),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            "/search",
                          );
                        },
                      ),
                    ),
                    isTapedSearch ?? false
                        ? Container(
                            color: Colors.white,
                            height: 4,
                            width: 20,
                          )
                        : const SizedBox(),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: isTapedNotification ?? false
                            ? const Color(0x44FFFFFF)
                            : null,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.notifications),
                        color: const Color(0xFFFFFFFF),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                            "/notifications",
                          );
                        },
                      ),
                    ),
                    isTapedNotification ?? false
                        ? Container(
                            color: Colors.white,
                            height: 4,
                            width: 20,
                          )
                        : const SizedBox(),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: isTapedProfile ?? false
                            ? const Color(0x44FFFFFF)
                            : null,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.person),
                        color: const Color(0xFFFFFFFF),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                            "/profile",
                          );
                        },
                      ),
                    ),
                    isTapedProfile ?? false
                        ? Container(
                            color: Colors.white,
                            height: 4,
                            width: 20,
                          )
                        : const SizedBox(),
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
