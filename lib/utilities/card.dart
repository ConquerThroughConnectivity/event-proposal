import 'package:flutter/material.dart';

class CardForm extends StatelessWidget {
  const CardForm({Key key, this.text}) : super(key: key);

  final text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: ListTile(
        leading: Icon(
          Icons.school,
          color: Colors.black,
        ),
        title: Text(text,
            style: TextStyle(
                color: Colors.black, fontFamily: "Mops", fontSize: 15)),
      ),
    );
  }
}
