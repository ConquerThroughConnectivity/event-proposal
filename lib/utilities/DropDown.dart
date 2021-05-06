library dropdown_formfield;

import 'package:eventproposal/Controllers/login.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class DropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;

  
  DropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      this.titleText = 'Title',
      this.hintText = 'Select one option',
      this.required = false,
      this.errorText = 'Please select one option',
      this.value,
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (FormFieldState<dynamic> state) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: titleText,
                      labelStyle: TextStyle(fontSize: 23),
                      filled: true,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        hint: Center(
                          child: GetBuilder<LoginContrller>(
                            init: LoginContrller(),
                            builder: (snapshot){
                              return Text(
                              snapshot.val.value,
                              style: TextStyle(color: Colors.grey.shade100),
                            );
                            },
                          ),
                        ),
                        value: value == '' ? null : value,
                        onChanged: (dynamic newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items: dataSource.map((item) {
                          return DropdownMenuItem<dynamic>(
                            value: item[valueField],
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Center(
                                child: Text(item[textField], style: TextStyle(
                                  fontSize: 15.0
                                ),),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: state.hasError ? 5.0 : 0.0),
                  Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(color: Colors.redAccent.shade700, fontSize: state.hasError ? 12.0 : 0.0),
                  ),
                ],
              ),
            );
          },
        );
}
