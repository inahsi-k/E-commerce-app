import 'package:e_commerce_admin_panel/core/data/data_provider.dart';
import 'package:e_commerce_admin_panel/screens/category/category_screen.dart';
import 'package:e_commerce_admin_panel/screens/category/provider/category_provider.dart';
import 'package:e_commerce_admin_panel/screens/sub_category/provider/sub_category_provider.dart';
import 'package:e_commerce_admin_panel/screens/sub_category/sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=> DataProvider()),
    ChangeNotifierProvider(create: (context)=>CategoryProvider(Provider.of<DataProvider>(context,listen:false))),
    ChangeNotifierProvider(create: (context)=>SubCategoryProvider(Provider.of<DataProvider>(context,listen:false)))
  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 24, 12, 59)),
      ),
      home: SubCategoryScreen()
    );
  }
}

