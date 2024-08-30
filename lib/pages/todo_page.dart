import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/database/database.dart';
import 'package:todo/utils/dialogBox.dart';
import 'package:todo/utils/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _mybox = Hive.box('myBox');
  ToDODatabase db = ToDODatabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //if first ever time opening the app
    if (_mybox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  final _controller = TextEditingController();

  // final List ToDoList = [
  //   ['Task 1', false],
  //   ['Task 2', false],
  // ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.ToDOList[index][1] = !db.ToDOList[index][1];
    });
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialogbox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: Navigator.of(context).pop,
        );
      },
    );
  }

  void saveNewTask() {
    setState(() {
      db.ToDOList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void deleteTask(int index) {
    setState(() {
      db.ToDOList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
            child: Text(
          'APY',
          style: TextStyle(color: Colors.white, fontSize: 19),
        )),
        backgroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.black87,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      // body: ListView.builder(
      //   itemCount: ToDOList.length,
      //   itemBuilder: (context,index)=>{
      //     return TodoTile(
      //       taskName: ToDOList[index][0], taskCompleted: ToDOList[index][1], onChanged: (value) => checkBoxChanged(value,index) ,)
      //   }),
      body: ListView.builder(
          itemCount: db.ToDOList.length,
          itemBuilder: (context, index) => TodoTile(
                taskName: db.ToDOList[index][0],
                taskCompleted: db.ToDOList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              )),
    );
  }
}

// class TodoPage extends StatefulWidget {
//   const TodoPage({super.key});

//   @override
//   State<TodoPage> createState() => _TodoPageState();
// }

// class _TodoPageState extends State<TodoPage> {
//   // text editing controller to get access to what the user has typed
//   TextEditingController mycontroller = TextEditingController();

//   String greetingMessage = "";

//   void greetUser() {
//     // print(mycontroller.text);
//     setState(() {
//       String userName = mycontroller.text;
//       greetingMessage = 'Hello, ' + userName;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black87,
//         title: Center(
//             child: Text(
//           'HomePage',
//           style: TextStyle(color: Colors.white, fontSize: 19),
//         )),
//       ),
//       body: Center(
//           child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(greetingMessage),
//             TextField(
//               controller: mycontroller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Namaeyva..',
//               ),
//             ),
//             ElevatedButton(
//               onPressed: greetUser,
//               child: Text('Tap'),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }
