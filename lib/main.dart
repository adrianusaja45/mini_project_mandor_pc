import 'package:flutter/material.dart';
import 'package:mini_project_mandor_pc/themes/app_theme.dart';

import 'package:mini_project_mandor_pc/view/widget/custom_page_route.dart';
import 'package:mini_project_mandor_pc/view_model/auth_provider.dart';
import 'package:mini_project_mandor_pc/view_model/build_provider.dart';
import 'package:mini_project_mandor_pc/view_model/selector_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/user_model.dart';
import 'view/detail_page/case_detail_page.dart';
import 'view/detail_page/cpu_cooler_detail_page.dart';
import 'view/detail_page/cpu_detail_page.dart';
import 'view/detail_page/gpu_detail_page.dart';
import 'view/detail_page/motherboard_detail_page.dart';
import 'view/detail_page/psu_detail_page.dart';
import 'view/detail_page/ram_detail_page.dart';
import 'view/detail_page/storage_detail_page.dart';
import 'view/login_page.dart';
import 'view/selector_page.dart';
import 'view/wishlists_page.dart';
import 'view_model/ram_provider.dart';
import 'view/home_page.dart';
import 'view_model/gpu_provider.dart';
import 'view_model/storage_provider.dart';
import 'view_model/cpu_provider.dart';
import 'view_model/cpu_cooler_provider.dart';
import 'view_model/psu_provider.dart';
import 'view_model/motherboard_provider.dart';
import 'view_model/case_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString('name').toString();

  runApp(MainApp(
    name: name,
  ));
}

class MainApp extends StatelessWidget {
  final String? name;
  const MainApp({super.key, required this.name});

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
          ChangeNotifierProvider(create: (_) => CaseProvider()),
          ChangeNotifierProvider(create: (_) => BuildProvider()),
          ChangeNotifierProvider(create: (_) => SelectorProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            initialRoute: name != null && name != 'null' ? '/home' : '/login',
            onGenerateRoute: (route) => onGenerateRoute(route)));
  }

  static Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/wishlists') {
      return CustomPageRoute(child: const WishListPage(), settings: settings);
    } else if (settings.name == '/psuDetail') {
      return CustomPageRoute(child: const PsuDetailPage(), settings: settings);
    } else if (settings.name == '/cpuDetail') {
      return CustomPageRoute(child: const CpuDetailPage(), settings: settings);
    } else if (settings.name == '/casingDetail') {
      return CustomPageRoute(child: const CaseDetailPage(), settings: settings);
    } else if (settings.name == '/coolerDetail') {
      return CustomPageRoute(
          child: const CoolerDetailPage(), settings: settings);
    } else if (settings.name == '/gpuDetail') {
      return CustomPageRoute(child: const GpuDetailPage(), settings: settings);
    } else if (settings.name == '/moboDetail') {
      return CustomPageRoute(child: const MoboDetailPage(), settings: settings);
    } else if (settings.name == '/ramDetail') {
      return CustomPageRoute(child: const RamDetailPage(), settings: settings);
    } else if (settings.name == '/home') {
      return CustomPageRoute(child: const Home(), settings: settings);
    } else if (settings.name == '/selectorPage') {
      return CustomPageRoute(child: const SelectorPage(), settings: settings);
    } else if (settings.name == '/login') {
      return CustomPageRoute(child: const LoginPage(), settings: settings);
    } else if (settings.name == '/storageDetail') {
      return CustomPageRoute(
          child: const StorageDetailPage(), settings: settings);
    }

    return null;
  }
}
