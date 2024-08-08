import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'airplane_dao.dart';
import '../models/airplane.dart';

part 'airplane_database_service.g.dart';

@Database(version: 1, entities: [Airplane])
abstract class AirplaneDatabase extends FloorDatabase {
  AirplaneDao get airplaneDao;
}
