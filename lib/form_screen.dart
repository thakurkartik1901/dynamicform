import 'package:dynamicform/model/fields.dart';
import 'package:dynamicform/model/validator.dart';
import 'package:dynamicform/provider/fields_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {};

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print(_authData.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Dynamic Form',
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Consumer<FieldsProvider>(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            builder: (ctx, data, _) {
              for (Fields field in data.items) {
                _authData.putIfAbsent(field.id, () => '');
              }
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: ListView.builder(
                      itemCount: data.items.length,
                      itemBuilder: (ctx, index) {
                        var field = data.items[index];
                        var validator = field.validator;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            key: Key(field.id),
                            decoration: InputDecoration(
                              labelText: field.label,
                              hintText: field.hintText,
                            ),
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (!field.required && value.isEmpty) {
                                return null;
                              }
                              if (value.isEmpty) {
                                return '${field.label} cannot be empty.';
                              }
                              for (Validator valid in validator) {
                                if (valid.type == 'Text') {
                                  if (valid.Value == 'Alphabetic' &&
                                      !isAlpha(value)) {
                                    return 'Only Alphabetic values allowed.';
                                  } else if (valid.Value == 'Alphanumeric' &&
                                      !isAlphanumeric(value)) {
                                    return 'Only Alphanumeric values allowed.';
                                  }
                                } else if (valid.type == 'Regex') {
                                  RegExp regExp = new RegExp(
                                    valid.Value,
                                    caseSensitive: false,
                                    multiLine: false,
                                  );
                                  if (!regExp.hasMatch(value)) {
                                    return 'Not a valid ${field.label}';
                                  }
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (_authData.containsKey(field.id))
                                _authData[field.id] = value;
                            },
                          ),
                        );
                      }),
                ),
              );
            }),
      ),
      bottomNavigationBar: RaisedButton(
        child: Text(
          'SUBMIT',
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.white),
        ),
        onPressed: _submit,
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryTextTheme.button.color,
      ),
    );
  }
}
