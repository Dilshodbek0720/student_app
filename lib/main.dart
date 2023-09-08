import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_app/blocs/student_bloc.dart';
import 'package:student_app/blocs/student_event.dart';
import 'package:student_app/ui/student/student_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => StudentsBloc())
    ], child: const MainApp());
  }
}


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  void initState() {
    BlocProvider.of<StudentsBloc>(context).add(GetStudents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentsScreen()
    );
  }
}
