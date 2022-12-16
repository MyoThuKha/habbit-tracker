import 'package:habit_tracker/dateTime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _box = Hive.box('HABITS_DB');

class HabitDB {
  List tasks = [];
  Map<DateTime, int> heatMapDataSet = {};
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
    _box.put(todayDate(), tasks);
    _box.put('CURRENT_HABITS_LIST', tasks);
    calculatePercent();
    loadHeatMap();
  }

  //Heat Map
  void calculatePercent() {
    int completed = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i]['finished']) {
        completed++;
      }
    }

    String result = (completed / tasks.length).toStringAsFixed(1);
    _box.put("SUMMARY_${todayDate()}", result);
  }

  void loadHeatMap() {
    DateTime start = changeToDateTime(_box.get('START_DATE'));
    int daysbetween = DateTime.now().difference(start).inDays;

    // go from start date to today and add each percentage to the dataset
    for (int i = 0; i < daysbetween + 1; i++) {
      String yyyymmdd = changeToString(
        start.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _box.get("SUMMARY_$yyyymmdd") ?? "0.0",
      );

      int year = start.add(Duration(days: i)).year;
      int month = start.add(Duration(days: i)).month;
      int day = start.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
