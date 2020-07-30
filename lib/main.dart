import 'package:dynamicform/form_screen.dart';
import 'package:dynamicform/provider/fields_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<FieldsProvider>(
            create: (context) => FieldsProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Dynamic Form',
          home: Consumer<FieldsProvider>(builder: (ctx, providerRef, _) {
            if (providerRef.items == null) {
              return CircularProgressIndicator();
            }
            return FormScreen();
          }),
        ));
  }
}
