import 'package:flutter/material.dart';
import 'package:sqflite_1/custom_widgets/text_widget.dart';

class DetailsPage extends StatefulWidget {
  final int idData;
  final String titleData;
  final String descData;
  const DetailsPage({Key? key,
    required this.idData,
    required this.titleData,
    required this.descData
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo Details', style: TextStyle(fontSize: 25),),
      ),
      body: ListView(
        children: [
          TextWidget(
            textTitle: 'Id',
            textDetails: ':${widget.idData}',
          ),
          TextWidget(
            textTitle: 'Title',
            textDetails: ':${widget.titleData}',
          ),
          TextWidget(
            textTitle: 'Description',
            textDetails: ':${widget.descData}',
          ),
        ],
      ),
    );
  }
}
