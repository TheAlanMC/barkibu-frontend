import 'package:barkibu/cubit/veterinary/veterinary_cubit.dart';
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
        BlocProvider(create: (context) => PasswordRecoveryCubit()),
        BlocProvider(create: (context) => VeterinarianInfoCubit()),
        BlocProvider(create: (context) => VeterinaryCubit()),
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
