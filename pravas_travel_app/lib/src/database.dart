import 'requiredClasses.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// import 'dart:io';

dynamic   database;

// create database
Future<dynamic> createMyDatabase() async {
  
  return openDatabase(
    path.join(await getDatabasesPath(), "UsersDatabase2.db"),
    version: 1,
    onCreate: (db, version) {
      db.execute(''' CREATE TABLE UserData (
    id INTEGER PRIMARY KEY,
    name TEXT,
    phone TEXT,
    username TEXT,
    password TEXT
  )
''');
      db.execute(''' CREATE TABLE ReviewData (
    reviewId INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    stars REAL
  )
''');
      db.execute(''' CREATE TABLE AppData (
    dataId INTEGER PRIMARY KEY,
    img TEXT,
    title TEXT,
    description TEXT,
    prize INTEGER,
    stars REAL
  )
''');
      print("Database Created Sucessfully");
    },
  );

}

//insert data into database

Future<void> insertUserData(SingleChildModalUsersData obj) async {
  final localDB = await database;

  localDB.insert(
    "UserData",
    obj.getUserMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// get data from database

Future<List<SingleChildModalUsersData>> fetchUserData() async {
  final localDB = await database;

  List<Map<String, dynamic>> mapEntry = await localDB.query(
    "UserData",
  );
  print("INSIDE MAPENTRY DATA: $mapEntry");
  return List.generate(mapEntry.length, (i) {
    return SingleChildModalUsersData(
        id: mapEntry[i]["id"],
        name: mapEntry[i]["name"],
        phone: mapEntry[i]["phone"],
        username: mapEntry[i]["username"],
        password: mapEntry[i]["password"]);
  });
}

class AppDataModel {
  final int? dataId;
  String? img;
  String? title;
  String? description;
  int? prize;
  double? stars;

  AppDataModel(
      {this.dataId,
      this.img,
      this.title,
      this.description,
      this.prize,
      this.stars});

  Map<String, dynamic> todoMap() {
    return {
      "dataId": dataId,
      "img": img,
      "title": title,
      "description": description,
      "prize": prize,
      "stars": stars,
    };
  }

  @override
  String toString() {
    return """{dataId : $dataId, img : $img, title : $title, description : $description, prize : $prize, stars : $stars}""";
  }
}

List<AppDataModel> dataList = [
  AppDataModel(
    dataId: 0,
    img: 'assets/images/place1.jpg',
    title: 'Paradise Palms Resort',
    description: 'Luxury',
    prize: 20,
    stars: 4.5,
  ),
  AppDataModel(
    dataId: 1,
    img: 'assets/images/place2.jpg',
    title: 'Serenity Suites',
    description: 'Boutique',
    prize: 25,
    stars: 5.0,
  ),
  AppDataModel(
    dataId: 2,
    img: 'assets/images/place3.jpg',
    title: 'Tranquil Haven Hotel',
    description: 'Seaside',
    prize: 30,
    stars: 3.6,
  ),
  AppDataModel(
    dataId: 3,
    img: 'assets/images/place4.jpg',
    title: 'Blissful Retreat Lodge',
    description: 'Mountain',
    prize: 48,
    stars: 3.0,
  ),
  AppDataModel(
    dataId: 4,
    img: 'assets/images/place5.jpg',
    title: 'Urban Oasis Hotel',
    description: 'City',
    prize: 35,
    stars: 3.5,
  ),
  AppDataModel(
    dataId: 5,
    img: 'assets/images/place6.jpg',
    title: 'Lakeside Lodge',
    description: 'Lakeside',
    prize: 42,
    stars: 4.8,
  ),
];

// insert
Future<void> insertAppData(AppDataModel obj) async {
  final localDB = await database;

  await localDB.insert("AppData", obj.todoMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

// fetch data
Future<List<AppDataModel>> getAppData() async {
  final localDB = await database;
  // for(int i=0; i<dataList.length;  i++) {
  //   insertAppData(dataList[i]);
  // }
  List<Map<String, dynamic>> dataMap = await localDB.query("AppData");
  print("INSIDE MAP: $dataMap");
  return List.generate(dataMap.length, (i) {
    return AppDataModel(
      dataId: dataMap[i]['dataId'],
      img: dataMap[i]['img'],
      title: dataMap[i]['title'],
      description: dataMap[i]['description'],
      prize: dataMap[i]['prize'],
      stars: dataMap[i]['stars'],
      // date: dataMap[i]['date'],
    );
  });
}
