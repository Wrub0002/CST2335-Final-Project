import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'airplane_dao.dart';
import '../models/airplane_entity.dart';

part 'database.g.dart';

@Database(version: 1, entities: [AirplaneEntity])
abstract class AppDatabase extends FloorDatabase {
  AirplaneDao get airplaneDao;
}
