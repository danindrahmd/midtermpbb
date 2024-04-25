import 'package:flutter/material.dart';
import 'database.dart';
import 'package:Midterm/model/model.dart';

class TaskManagerPage extends StatefulWidget {
  @override
  _TaskManagerPageState createState() => _TaskManagerPageState();
}

class _TaskManagerPageState extends State<TaskManagerPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    List<Task> loadedTasks = await DBProvider.getTasks();
    setState(() {
      tasks = loadedTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await DBProvider.insertTask(
                    Task(title: "Finish report", description: "Due next week"));
                _loadTasks();
              },
              child: Text('Add Task'),
            ),
            ElevatedButton(
              onPressed: () {
                // View tasks
              },
              child: Text('View Tasks'),
            ),
          ],
        ),
      ),
    );
  }
}
