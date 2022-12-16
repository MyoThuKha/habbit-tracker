import 'dart:convert';

import 'package:habit_tracker/dateTime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _box = Hive.box('HABITS_DB');

class HabitDB {
  List tasks = [];
  //init
  void createInitData() {
    tasks = [
      {"text": "Meditate for 10 min", "finished": false},
      {"text": "Drink 8 glasses of water", "finished": false},
      {"text": "Walk for 30 min", "finished": false},
    ];

    _box.put('START_DATE', todayDate());
  }

  //load
  void loadData() {
    if (_box.get(todayDate()) == null) {
      tasks = _box.get("_CURRENT_HABITS_LIST");
      for (int i = 0; i < tasks.length; i++) {
        tasks[i]['finished'] = false;
      }
    } else {
      tasks = _box.get(todayDate());
    }
  }

  //update
  void update() {
    print("processing...");
    _box.put(todayDate(), tasks);
    _box.put('CURRENT_HABITS_LIST', tasks);
    print("success");
  }
}
