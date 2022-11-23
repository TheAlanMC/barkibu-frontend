import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/router/app_routes.dart';
import 'package:barkibu/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterUserCubit()),
        BlocProvider(create: (context) => RegisterPetCubit()),
        BlocProvider(create: (context) => PasswordManagementCubit()),
        BlocProvider(create: (context) => VeterinarianInfoCubit()),
        BlocProvider(create: (context) => VeterinaryCubit()),
        BlocProvider(create: (context) => UserVeterinarianCubit()),
        BlocProvider(create: (context) => VeterinarianOwnAnswerCubit()),
        BlocProvider(create: (context) => QuestionFilterCubit()),
        BlocProvider(create: (context) => OwnerOwnQuestionCubit()),
        BlocProvider(create: (context) => QuestionDetailCubit()),
        BlocProvider(create: (context) => PetInfoCubit()),
      ],
      child: MaterialApp(
        title: 'Barkibu',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.intialRoute,
        routes: AppRoutes.getAppRoutes(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
