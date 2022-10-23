import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class NewTrip extends StatefulWidget {
  const NewTrip({super.key});

  @override
  State<NewTrip> createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  String? _tripname;
  String? _startloc;
  String? _endloc;
  String? _triptype;
  int? _travelnos;
  String? _startDate;
  String? _endDate;
  String? _emcontactname;
  int? _emcontactnum;

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
          'Plan a new trip',
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
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'HomePage');
                  },
                  icon: const Icon(Icons.trip_origin)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.money_off_rounded)),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade800,
        child: const Icon(
          Icons.check,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'NewTrip');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            //icon: Icon(Icons.person),
            fillColor: Colors.grey,
            hintText: 'What do you want to name the trip',
            labelText: 'Name of Trip',
          ),
          onSaved: (String? value) {
            this._tripname = value;
            //print('name=$_startloc');
          },
        ),
        const SizedBox(
          height: 40,
        ),
        TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            //icon: Icon(Icons.person),
            fillColor: Colors.grey,
            hintText: 'Where do you plan to start?',
            labelText: 'Start Location',
          ),
          onSaved: (String? value) {
            this._startloc = value;
            //print('name=$_startloc');
          },
        ),
        TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            fillColor: Colors.grey,
            //icon: Icon(Icons.person),
            hintText: 'What is your destination?',
            labelText: 'Destination',
          ),
          onSaved: (String? value) {
            this._endloc = value;
            print('name=$_endloc');
          },
        ),
        const SizedBox(
          height: 40,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          onPressed: () {
            showDateRangePicker(
              context: context,
              firstDate: DateTime(2018),
              lastDate: DateTime(2025),
            ).then((DateTimeRange? value) {
              if (value != null) {
                DateTimeRange _fromRange =
                    DateTimeRange(start: DateTime.now(), end: DateTime.now());
                _fromRange = value;
                this._startDate = DateFormat.yMMMd().format(_fromRange.start);
                this._endDate = DateFormat.yMMMd().format(_fromRange.end);
              }
            });
          },
          child: const Text('Dates of Trip'),
        ),
      ]),
    );
  }
}
