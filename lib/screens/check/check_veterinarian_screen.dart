import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/screens/screens.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckVeterinarianScreen extends StatelessWidget {
  const CheckVeterinarianScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final veterianInfoCubit = BlocProvider.of<VeterinarianInfoCubit>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: veterianInfoCubit.getVeterinarianInfo(),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (veterianInfoCubit.state.status) {
              case ScreenStatus.initial:
                return const CircularProgressIndicator();
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                Future.microtask(() {
                  Navigator.pushReplacement(
                      context, PageRouteBuilder(pageBuilder: (_, __, ___) => const VeterinarianProfileScreen(), transitionDuration: Duration.zero));
                });
                break;
              case ScreenStatus.failure:
                if (veterianInfoCubit.state.statusCode == 'SCTY-4004') {
                  Future.microtask(() {
                    Navigator.pushReplacement(
                        context, PageRouteBuilder(pageBuilder: (_, __, ___) => const AlertScreen(), transitionDuration: Duration.zero));
                  });
                } else {
                  // customShowDialog(
                  //     context: context,
                  //     title: 'ERROR ${veterianInfoCubit.state.statusCode}',
                  //     message: veterianInfoCubit.state.errorDetail ?? 'Error desconocido',
                  //     isDismissible: false);
                  print('ERROR ${veterianInfoCubit.state.statusCode}');
                }

                break;
              default:
            }
            return Container();
          },
        ),
      ),
    );
  }
}
