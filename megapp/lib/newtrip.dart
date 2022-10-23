import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TodoItem {
  final int? id;
  String? tripname;
  String? startloc;
  String? endloc;
  String? triptype;
  //int? _travelnos;
  String? startDate;
  String? endDate;
  bool? isDone;
  //String? _emcontactname;
  //int? _emcontactnum;

  TodoItem({
    this.id,
    required this.tripname,
    required this.startloc,
    required this.endloc,
    required this.triptype,
    required this.startDate,
    required this.endDate,
    this.isDone = false,
  });

  TodoItem.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        tripname = map['tripname'] as String,
        startloc = map['startloc'] as String,
        endloc = map['endloc'] as String,
        triptype = map['triptype'] as String,
        startDate = map['startDate'] as String,
        endDate = map['endDate'] as String,
        isDone = map['isDone'] as bool;


  Map<String, dynamic> toJsonMap() => {
        'id': id,
        'tripname': tripname,
        'startloc' : startloc,
        'endloc':endloc,
        'triptype' :triptype,
        'startDate' :startDate,
        'endDate':endDate,
        'isDone': isDone,

      };
}

class NewTrip extends StatefulWidget {
  const NewTrip({super.key});

  @override
  State<NewTrip> createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  static const kDbFileName = 'sembast_ex.db';
  static const kDbStoreName = 'example_store';

  late Future<bool> _initDbFuture;
  late Database _db;
  late StoreRef<int, Map<String, dynamic>> _store;
  List<TodoItem> _todos = [];
  
  @override
  void initState() {
    super.initState();
    this._initDbFuture = _initDb();
  }

  // Opens a db local file. Creates the db table if it's not yet created.
  Future<bool> _initDb() async {
    final dbFolder = await path_provider.getApplicationDocumentsDirectory();
    final dbPath = join(dbFolder.path, kDbFileName);
    this._db = await databaseFactoryIo.openDatabase(dbPath);
    print('Db created at $dbPath');
    this._store = intMapStoreFactory.store(kDbStoreName);
    //_getTodoItems();
    return true;
  }

  // Retrieves records from the db store.
  Future<void> _getTodoItems() async {
    final finder = Finder();
    final recordSnapshots = await this._store.find(this._db, finder: finder);
    this._todos = recordSnapshots
        .map(
          (snapshot) => TodoItem.fromJsonMap({
            ...snapshot.value,
            'id': snapshot.key,
          }),
        )
        .toList();
  }

  // Inserts records to the db store.
  // Note we don't need to explicitly set the primary key (id), it'll auto
  // increment.
  Future<void> _addTodoItem(TodoItem todo) async {
    final int id = await this._store.add(this._db, todo.toJsonMap());
    print('Inserted todo item with id=$id.');
  }

  // Updates records in the db table.
  Future<void> _toggleTodoItem(TodoItem todo) async {
    todo.isDone = todo.isDone;
    final int count = await this._store.update(
          this._db,
          todo.toJsonMap(),
          finder: Finder(filter: Filter.byKey(todo.id)),
        );
    print('Updated $count records in db.');
  }

  // Deletes records in the db table.
  Future<void> _deleteTodoItem(TodoItem todo) async {
    final int count = await this._store.delete(
          this._db,
          finder: Finder(filter: Filter.byKey(todo.id)),
        );
    print('Updated $count records in db.');
  }


  String? tripname;
  String? startloc;
  String? endloc;
  String? triptype;
  //int? _travelnos;
  String? startDate;
  String? endDate;
  bool? isDone = false;

  //String? _emcontactname;
  //int? _emcontactnum;

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
            this.tripname = value;
            //print('name=$startloc');
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
            this.startloc = value;
            //print('name=$startloc');
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
            this.endloc = value;
            print('name=$endloc');
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
                this.startDate = DateFormat.yMMMd().format(_fromRange.start);
                this.endDate = DateFormat.yMMMd().format(_fromRange.end);
              }
            });
          },
          child: const Text('Dates of Trip'),
        ),
      ]),
    );
  }
}
