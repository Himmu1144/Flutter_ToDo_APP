import 'package:hive_flutter/hive_flutter.dart';

class ToDODatabase {
  List ToDOList = [];

  // refrencing the box
  final _mybox = Hive.box('myBox');

  // first ever opening the app
  void createInitialData() {
    ToDOList = [
      ['Demo Task', false],
    ];
  }

  void loadData() {
    ToDOList = _mybox.get('TODOLIST');
  }

  void updateDatabase() {
    _mybox.put('TODOLIST', ToDOList);
  }
}
