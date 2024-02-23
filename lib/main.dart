import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:roadmate/app/home/data/data_sources/home_data_source.dart';
import 'package:roadmate/app/home/data/repository/repository.dart';
import 'package:roadmate/app/home/presentation/home_screen.dart';
import 'package:roadmate/app/home/presentation/view_modal.dart';
import 'package:roadmate/app/products/data/data_source/products_data_source.dart';
import 'package:roadmate/app/products/data/repository/repository.dart';
import 'package:roadmate/app/products/domain/repos/repository.dart';
import 'package:roadmate/app/products/presentation/view_modal.dart';
import 'package:roadmate/core/data/dio.dart';

Future<void> dep() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton(Api());
  getIt.registerSingleton(HomeDataSource(GetIt.instance<Api>()));
  getIt.registerSingleton(HomeRepository(GetIt.instance<HomeDataSource>()));
  getIt.registerSingleton(ProductsDataSource(GetIt.instance<Api>()));
  getIt.registerSingleton(
      ProductsRepository(GetIt.instance<ProductsDataSource>()));
}

void main() async {
  await dep();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModal>(
            create: (_) => HomeViewModal(GetIt.instance<HomeRepository>())),
        ChangeNotifierProvider<ProductsViewModal>(
            create: (_) =>
                ProductsViewModal(GetIt.instance<ProductsRepository>()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Color.fromRGBO(245, 245, 245, 1),
            ),
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,),
            useMaterial3: true,
            textTheme: const TextTheme(
                bodySmall: TextStyle(fontSize: 12),
                headlineMedium: TextStyle(fontSize: 16),
                headlineLarge: TextStyle(fontSize: 20))),
        home: const ScreenHome(),
      ),
    );
  }
}
