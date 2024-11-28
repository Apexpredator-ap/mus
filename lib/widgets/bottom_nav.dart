import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../views/homepage.dart';
import '../views/library.dart';
import '../views/playlist.dart';
import '../views/search.dart';
import '../views/settings.dart';


class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int currentTabPage = 0;
  late List<Widget> pages;
  late HomePage home;
  late SearchPage search;
  late LibraryPage library;
  late PlayList playlist;
  late ProfilePage profile;

  List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,

    Icons.library_music_sharp,

    Icons.account_circle,
  ];

  @override
  void initState() {
    home = HomePage(); // Pass userId to HomePage
    search =
        SearchPage(); // Modify these pages as needed if they require userId
    library = LibraryPage();
    playlist = PlayList();
    profile = ProfilePage();
    pages = [home, search, library,playlist, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      bottomNavigationBar: CurvedNavigationBar(

       color: Colors.black,
       animationDuration: const Duration(milliseconds: 500),
       backgroundColor: Colors.blue,
       height: 65,
       onTap: (int index) {
         setState(() {
           currentTabPage = index;
         });
       },
       items: const [
         Icon(
           Icons.home_outlined,
           color: Colors.red,
         ),
         Icon(
           Icons.search,
           color: Colors.blue,
         ),
         Icon(
           Icons.favorite,
           color: Colors.blue,
         ),
         Icon(Icons.library_music_sharp,color: Colors.blue,),
         Icon(
           Icons.person_outline,
           color: Colors.blue,
         ),
       ],
                ),
      body: pages[currentTabPage],
    );
  }
}



