import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_binding.dart';
import 'presentation/pages/home_screen.dart';
void main() { WidgetsFlutterBinding.ensureInitialized(); runApp(const MyApp()); }
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => GetMaterialApp(
    title: 'Data Barang', debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
    initialBinding: AppBinding(), home: const HomeScreen(),
  );
}
