import 'package:cat_trivia_app/business_logic/blocs/cat_fact_bloc.dart';
import 'package:cat_trivia_app/data/local_service/local_service.dart';
import 'package:cat_trivia_app/data/services/cat_fact_service.dart';
import 'package:cat_trivia_app/presentations/screens/main_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CatFactService catFactService = CatFactService();
  LocalService localService = LocalService();
  await localService.initializeHive();

  runApp(MyApp(
    catFactService: catFactService,
    localService: localService,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.catFactService,
    required this.localService,
  });

  final CatFactService catFactService;

  final LocalService localService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatFactBloc>(
            create: (context) =>
                CatFactBloc(catFactService, localService)..add(FetchCatFactEvent())),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
