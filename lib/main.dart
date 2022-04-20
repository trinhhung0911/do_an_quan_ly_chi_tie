import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/app.dart';
import 'package:quan_ly_chi_tieu/repositories/login_repository.dart';

import 'bloc/login_bloc/login_bloc.dart';
Future<void>main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => LoginBloc(
         loginRepository: LoginRepository(),
        ),
      ),
    ],
    child:  MyApp(),
  ),);

}

