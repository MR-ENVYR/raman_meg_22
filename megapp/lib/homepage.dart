import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:megapp/newtrip.dart';
//import 'widgies.dart';
import 'package:permission_handler/permission_handler.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    _getTodoItems();
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


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: this._initDbFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'HomePage');
                      },
                      icon: const Icon(Icons.trip_origin)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.money_off_rounded)),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: ListView(
            children: this._todos.map(_itemToListTile).toList(),
          ),
        );
      },
    );
  }

  Future<void> _updateUI() async {
    await _getTodoItems();
    setState(() {});
  }

  ListTile _itemToListTile(TodoItem todo) => ListTile(
        title: Text(todo.tripname,
            style: GoogleFonts.playfairDisplay(color: Colors.white)),
      );
}
