import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/ram_provider.dart';

import 'view/home_page.dart';
import 'view_model/gpu_provider.dart';
import 'view_model/storage_provider.dart';
import 'view_model/cpu_provider.dart';
import 'view_model/cpu_cooler_provider.dart';
import 'view_model/psu_provider.dart';
import 'view_model/motherboard_provider.dart';
import 'view_model/case_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GpuProvider()),
          ChangeNotifierProvider(create: (_) => StorageProvider()),
          ChangeNotifierProvider(create: (_) => CpuProvider()),
          ChangeNotifierProvider(create: (_) => CpuCoolerProvider()),
          ChangeNotifierProvider(create: (_) => RamProvider()),
          ChangeNotifierProvider(create: (_) => PsuProvider()),
          ChangeNotifierProvider(create: (_) => MoboProvider()),
          ChangeNotifierProvider(create: (_) => CaseProvider())
        ],
        child:
            const MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
  }
}
