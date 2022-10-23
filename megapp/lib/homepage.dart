import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
//import 'widgies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(3, 9, 23, 1),
      //drawer: theDrawer(context),
      //drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 9, 23, 1),
        centerTitle: true,
        title: Text(
          'Homepage',
          style: GoogleFonts.playfairDisplay(color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(onPressed: () {Navigator.pushNamed(context, 'HomePage');}, icon: const Icon(Icons.trip_origin)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.money_off_rounded)),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade800,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'NewTrip');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.90,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            ]),
      ),
    );
  }
}
