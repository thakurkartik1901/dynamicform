import 'package:dynamicform/model/fields.dart';
import 'package:dynamicform/model/validator.dart';
import 'package:flutter/material.dart';

class FieldsProvider with ChangeNotifier {
  var DUMMY_FORM_DATA = {
    "data": [
      {
        "id": "customer_name",
        "type": "EditText",
        "label": "Name",
        "hintText": "Name",
        "required": "False",
        "validator": [
          {"type": "Text", "Value": "Alphabetic"},
          {"type": "Regex", "Value": "/^\\w+/"}
        ]
      },
      {
        "id": "customer_email",
        "type": "EditText",
        "label": "Email",
        "hintText": "Email",
        "required": "True",
        "validator": [
          {"type": "Text", "Value": "Alphanumeric"},
          {"type": "Regex", "Value": "^\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,3}\$"}
        ]
      },
      {
        "id": "customer_password",
        "type": "EditText",
        "label": "Password",
        "hintText": "Password",
        "required": "True",
        "validator": [
          {"type": "Text", "Value": "Alphanumeric"},
          {
            "type": "Regex",
            "Value": "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}\$"
          }
        ]
      }
    ]
  };

  List<Fields> _items = [];

  FieldsProvider() {
    fetchAndSetFields();
  }

  List<Fields> get items {
    return [..._items];
  }

  Future<void> fetchAndSetFields() async {
    try {
      List<Fields> etractedFieldsData = [];
      var fieldsData = DUMMY_FORM_DATA['data'];
      etractedFieldsData = fieldsData
          .map(
            (fields) => Fields(
              id: fields['id'],
              type: fields['type'],
              label: fields['label'],
              hintText: fields['hintText'],
              required: fields['required'] == 'True' ? true : false,
              validator: (fields['validator'] as List<dynamic>)
                  .map(
                    (validator) => Validator(
                      type: validator['type'],
                      Value: validator['Value'],
                    ),
                  )
                  .toList(),
            ),
          )
          .toList();
      _items = etractedFieldsData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
