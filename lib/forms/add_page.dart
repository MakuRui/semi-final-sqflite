
import 'package:flutter/material.dart';
import 'package:sqflite_1/database/sql_helper.dart';

class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {

  TextEditingController titleCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add todo task'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleCon,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Please input a title',
                  ),
                  validator: (value){
                    return value == null
                        || value.isEmpty ? 'title is required' : null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: descCon,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Please input a description',
                  ),
                  validator: (value){
                    return value == null
                        || value.isEmpty ? 'description is required' : null;
                  },
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        var data = SqlHelper.addTodoTask(
                            titleCon.text,
                            descCon.text
                        );
                        Navigator.pop(context, data);
                      }
                    },
                    child: const Text('Add todo task')
                )
              ],
            )
        ),

      ),
    );
  }
}
