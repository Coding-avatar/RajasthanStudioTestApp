import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pexel/view/favouritesScreen.dart';
import 'package:pexel/view/imageScreen.dart';
import 'package:pexel/view/videoScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: Text("Rajasthan Studio"),
                centerTitle: true,
                floating: true,
                pinned: true,
                snap: true,
                bottom: new TabBar(
                  tabs: <Tab>[
                    Tab(
                      text: 'Images',
                    ),
                    Tab(
                      text: 'Videos',
                    ),
                    Tab(
                      text: 'Favorite',
                    )
                  ], // <-- total of 2 tabs
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              ImageScreen(),
              VideoScreen(),
              FutureBuilder(
                future: Hive.openBox('favourites'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                        ),
                      );
                    } else {
                      return FavouritesScreen();
                    }
                  } else
                    return Scaffold();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
