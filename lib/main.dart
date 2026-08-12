import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/lugares_provider.dart';
import 'screens/lista_lugares_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LugaresProvider(),
      child: MaterialApp(
        title: 'Lugares UIDE',
        theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
        home: const ListaLugaresScreen(),
      ),
    );
  }
}
