import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/logic/adapters/user_adapter.dart';
import 'package:to_do_app/logic/provider/auth.dart';
import 'package:to_do_app/model/user.dart';
import 'package:to_do_app/presentation/home_page.dart';
import 'package:to_do_app/presentation/login_page.dart';
import 'package:to_do_app/presentation/register_page.dart';

import 'logic/adapters/todo_adapter.dart';
import 'logic/provider/todos.dart';
import 'presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final appDocumentary = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentary.path);
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox("todos");
  await Hive.openBox("users");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: "/todo",
          builder: (context, state) => const TodoPage(),
        ),
      ],
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Todos>(
          create: (context) => Todos(),
        ),
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'To Do App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(244, 194, 127, 1),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
