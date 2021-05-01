import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:challenges/widgets/SlidingPanel.dart';

import '../mainController.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double screenWidth;
  late double screenHeight;
  late SlidingPanel slidingPanel;
  final MainController c = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    this.screenWidth = MediaQuery.of(context).size.width;
    this.screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: _mainContent(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: slidingPanel = SlidingPanel(
        colorClosedContent: Color(0xFF5732ff),
        gradientOpenedContent: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7552ff),
              Color(0xFF4C65F6),
            ]),
        closedContent: _closedConent(),
        openendContent: _openendContent(),
      ),
    );
  }

  Widget _mainContent() {
    return ListView(
      children: [
        _mainCardsContainer(
            assetImage: 'assets/images/person1.png',
            title: 'YHLQMDLG',
            subtitle: 'Bad Bunny'),
        _mainCardsContainer(
            assetImage: 'assets/images/person3.png',
            title: 'After Hours',
            subtitle: 'The Weekend'),
        _mainCardsContainer(
            assetImage: 'assets/images/person4.png',
            title: 'Future Nostalgia',
            subtitle: 'Dua Lipa'),
        _mainCardsContainer(
            assetImage: 'assets/images/portada.png',
            title: 'Hybrid Theory',
            subtitle: 'Linkin Park'),
        SizedBox(
          height: screenHeight * .13,
        )
      ],
    );
  }

  Widget _mainCardsContainer(
      {required String assetImage,
      required String title,
      required String subtitle}) {
    return GestureDetector(
      onTap: () {
        c.changeAlbum(image: assetImage, subtitle: subtitle, title: title);
      },
      child: Container(
        width: screenWidth,
        height: screenHeight * .3,
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: screenWidth * .9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  assetImage,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Text(
                subtitle,
                style: TextStyle(color: Colors.grey[350]),
              ),
            )
          ],
        ),
      ),
    );
  }

  _closedConent() {
    return GetBuilder<MainController>(
      init: c,
      builder: (c) {
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.view_carousel_rounded,
                color: Colors.white,
              ),
              Hero(
                tag: 'image',
                child: Container(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        '${c.image}',
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Container(
                  width: 30,
                  height: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/person2.png',
                      fit: BoxFit.cover,
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  _openendContent() {
    return GetBuilder<MainController>(
        init: c,
        builder: (c) {
          return Container(
            child: Column(
              children: [
                Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(top: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        '${c.image}',
                        fit: BoxFit.cover,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    '${c.title}',
                    style: TextStyle(color: Colors.grey[200]?.withOpacity(.5)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    '${c.subtitle}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.shuffle,
                      color: Colors.white,
                      size: 34,
                    ),
                    Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 42,
                    ),
                    Icon(
                      Icons.album_outlined,
                      color: Colors.white,
                      size: 34,
                    ),
                  ],
                ))
              ],
            ),
          );
        });
  }
}
