import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quan_ly_chi_tieu/app.dart';
import 'package:quan_ly_chi_tieu/bloc/cost_spend_bloc/cost_spend_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/forgot_bloc/forgot_bloc.dart';
import 'package:quan_ly_chi_tieu/bloc/user_bloc/user_bloc.dart';
import 'package:quan_ly_chi_tieu/repositories/category_spend_repository.dart';
import 'package:quan_ly_chi_tieu/repositories/cost_spend_repository.dart';
import 'package:quan_ly_chi_tieu/repositories/forgot_repository.dart';
import 'package:quan_ly_chi_tieu/repositories/login_repository.dart';
import 'package:quan_ly_chi_tieu/repositories/user_repository.dart';
import 'bloc/category_spend_bloc/category_spend_bloc.dart';
import 'bloc/login_bloc/login_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            loginRepository: LoginRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => ForgotBloc(
            forgotRepository: ForgotRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => UserBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider(
          create: (context) =>CategorySpendBloc(
           categorySpendRepository: CategorySpendRepository()
          ),
        ),
        BlocProvider(
          create: (context) =>CostSpendBloc(
            costSpendRepository: CostSpendRepository()
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}
