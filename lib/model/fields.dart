import 'package:dynamicform/model/validator.dart';

class Fields {
  String id;
  String type;
  String label;
  String hintText;
  bool required;
  List<Validator> validator;

  Fields({
    this.id,
    this.type,
    this.label,
    this.hintText,
    this.required,
    this.validator,
  });
}
