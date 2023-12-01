import 'package:flutter/material.dart';
import 'package:flutter_travel_app/ui/model/app_model.dart';
import 'package:flutter_travel_app/ui/animations/propagation.dart';
import 'package:flutter_travel_app/ui/shapes/bottom_bar.dart';
import 'package:flutter_travel_app/ui/home/offers_page.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isPressedBack = false;
  bool isSearching = false;
  bool isRecordFounded = true;

  final _searchingDataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: width / 5,
                automaticallyImplyLeading: false,
                expandedHeight: width / 3,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  expandedTitleScale: 1,
                  title: Container(
                    padding: EdgeInsets.fromLTRB(width / 20, 0, width / 20, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            setState(() {
                              isPressedBack = true;
                            });
                          },
                          onTapUp: (TapUpDetails details) {
                            setState(() {
                              isPressedBack = false;
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              isPressedBack = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 142, 78, 0),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: isPressedBack
                                  ? const [
                                      BoxShadow(
                                        offset: Offset(0, 2),
                                        blurRadius: 0.50,
                                        spreadRadius: 0.05,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.keyboard_arrow_left_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            margin: EdgeInsets.fromLTRB(width / 30, 0, 0, 0),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 142, 78, 0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                isSearching = value.isNotEmpty;
                                setState(() {});
                              },
                              controller: _searchingDataController,
                              decoration: const InputDecoration(
                                hintText: 'Rechercher un voyage...',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      title: Container(
                        color: const Color(0xFFF7941F),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: height / 40,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xDFFFFFFF),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: ScopedModelDescendant<AppModel>(
                            builder: (context, child, model) {
                              if (model.isLoadingSortedPrograms) {
                                if (isSearching) {
                                  model.userSearching(
                                    _searchingDataController.text,
                                  );
                                } else {
                                }
                                return Center(
                                  child: Container(
                                    margin: EdgeInsets.all(width / 10),
                                    child: const WaveAnimation(
                                      color: Color(0xFFF7941F),
                                    ),
                                  ),
                                );
                              } else if (model.programmes!.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "No matches found...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF146CC2),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  padding: EdgeInsets.all(width / 50),
                                  itemCount: model.programmes!.length,
                                  itemBuilder: (context, index) {
                                    return OffersList(
                                      width: width,
                                      index: index,
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: 1,
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
              isTapedSearch: true,
            ),
          ),
        ],
      ),
    );
  }
}
