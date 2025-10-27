import 'package:flutter/material.dart';
import 'package:todo_list/todo_item.dart';

void main() {
  runApp(MaterialApp(
    title: 'Simple Todo App',
    theme: ThemeData(primarySwatch: Colors.lightBlue),
    home: const TodoAppScreen(),
  ));
}

class TodoAppScreen extends StatefulWidget {
  const TodoAppScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoAppScreen> {
  List<TodoItem> tasks = [
    TodoItem(title: 'Test 1'),
    TodoItem(title: 'Test 2'),
    TodoItem(title: 'Test 3')
  ];

  void _toogleTaskDone(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void _saveNewTask(String taskTitle) {
    if (taskTitle.isNotEmpty) {
      setState(() {
        tasks.add(TodoItem(title: taskTitle));
      });
    }
  }

  final TextEditingController _taskController = TextEditingController();

  void _showAddTaskDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add New Task'),
              content: TextField(
                controller: _taskController,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Enter Task name'),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _taskController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _saveNewTask(_taskController.text);
                    _taskController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Todo List App'),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (bool? newValue) {
                    _toogleTaskDone(index);
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
