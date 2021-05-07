import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFields extends StatelessWidget {
  final TextEditingController textfield;
  final IconData icons;
  final String text;
  final int maxlines;
  const TextFields({Key key, this.textfield, this.icons, this.text, this.maxlines}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextFormField(
        maxLines: this.maxlines,
        textInputAction: TextInputAction.done,
        controller: this.textfield,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
          LengthLimitingTextInputFormatter(20),
        ],
        keyboardType: TextInputType.text,
        validator: (val) {
          if (val.isEmpty) {
            return 'This field cannot be Empty';
          }
          
        },
        onChanged: (val) {},
        decoration: InputDecoration(
          labelText: this.text,
          focusColor: Colors.white,
          border: OutlineInputBorder(
              borderSide: new BorderSide(color: Color(0xFF2d3447))),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: Colors.white,
          prefixIcon: Icon(this.icons),
        ),
      ),
    );
  }
}
