import 'package:flutter/material.dart';
import 'package:sqflite_1/database/sql_helper.dart';
import 'package:sqflite_1/forms/add_page.dart';
import 'package:sqflite_1/forms/update_form.dart';
import 'package:sqflite_1/pages/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _todosTask = [];

  //Method to update the List and UI
  void _refreshTodosTask() async {
    final data = await SqlHelper.getTodosTask();
    setState(() {
      _todosTask = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshTodosTask();
    // print('..number of task ${_todosTask.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Todos Task')
      ),
      body: ListView.builder(
        itemCount: _todosTask.length,
          itemBuilder: (context, index) => Card(
            elevation: 10,
            margin: const EdgeInsets.all(15),
            child: Dismissible(
              direction: DismissDirection.endToStart,
                key: UniqueKey(),
                child: ListTile(
                  title: Text(_todosTask[index]['title']),
                  subtitle: Text(_todosTask[index]['desc']),
                  trailing: IconButton(
                      onPressed: () async {
                       await Navigator.push(context,
                            MaterialPageRoute(
                            builder: (context) => UpdateForm(
                                idData: _todosTask[index]['id'],
                                titleData: _todosTask[index]['title'],
                                descData: _todosTask[index]['desc']
                            )));
                       _refreshTodosTask();
                       // print('..number of task ${_todosTask.length}');
                      },
                      icon: const Icon(Icons.edit)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DetailsPage(
                            idData: _todosTask[index]['id'],
                            titleData: _todosTask[index]['title'],
                            descData: _todosTask[index]['desc']
                        )));
                  },
                ),
              onDismissed: (direction) async {
                await SqlHelper.deleteTodoTask(_todosTask[index]['id']);
                _refreshTodosTask();
                // print('..number of task ${_todosTask.length}');
              },
            ),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddForm()));
          _refreshTodosTask();
          // print('..number of task ${_todosTask.length}');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}