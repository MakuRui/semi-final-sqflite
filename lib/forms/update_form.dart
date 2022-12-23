import 'package:flutter/material.dart';
import 'package:sqflite_1/database/sql_helper.dart';

class UpdateForm extends StatefulWidget {
  final int idData;
  final String titleData;
  final String descData;
  const UpdateForm({Key? key,
    required this.idData,
    required this.titleData,
    required this.descData
  }) : super(key: key);

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {

  @override
  void initState() {
    super.initState();
    idVal = widget.idData;
    titleCon.text = widget.titleData;
    descCon.text = widget.descData;
  }

  TextEditingController titleCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  int idVal = 0;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update todo task'),
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
                        var data = SqlHelper.editTodoTask(
                            idVal,
                            titleCon.text,
                            descCon.text
                        );
                        Navigator.pop(context, data);
                      }
                    },
                    child: const Text('Update todo task')
                )
              ],
            )
        ),

      ),
    );
  }
}
