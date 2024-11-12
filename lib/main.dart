import 'package:flutter/material.dart';
import 'package:food_app/repositories/menu_repository.dart';
import 'package:food_app/view_models/item_view_model.dart';
import 'package:food_app/view_models/menu_view_model.dart';
import 'package:food_app/views/menu_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MenuRepository menuRepository = MenuRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuViewModel(menuRepository)),
        ChangeNotifierProvider(create: (_) => ItemViewModel(menuRepository)),
      ],
      child: MaterialApp(
        title: 'Menu App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MenuScreen(),
      ),
    );
  }
}
