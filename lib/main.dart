import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'To-Do List', home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('To-Do List \nArbi Syarifudin (12181630)')),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  void _addTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  void _editTodoItem(String oldTitle, String newTitle) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    int index = _todoList.indexOf(oldTitle);
    setState(() {
      _todoList[index] = newTitle;
    });
    _textFieldController.clear();
  }

  void _deleteTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      _todoList.removeWhere((item) => item == title);
    });
    _textFieldController.clear();
  }

  // Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return ListTile(
      title: Text(title),
      onTap: () => _displayEditDialog(context, title),
    );
  }

  // Generate a single item widget
  Future<AlertDialog> _displayDialog(BuildContext context) async {
    _textFieldController.clear();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Tambahkan rencana tugas'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Masukan tugas'),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('BATAL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text('TAMBAH'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
            ],
          );
        }).then((value) => value ?? false);
  }

  Future<AlertDialog> _displayEditDialog(
      BuildContext context, currentValue) async {
    _textFieldController.text = currentValue;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit rencana tugas'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Masukan tugas'),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('HAPUS'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteTodoItem(currentValue);
                },
              ),
              FlatButton(
                child: const Text('BATAL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text('SIMPAN PERUBAHAN'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _editTodoItem(currentValue, _textFieldController.text);
                },
              ),
            ],
          );
        }).then((value) => value ?? false);
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}
