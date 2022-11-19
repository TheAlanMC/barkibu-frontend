import 'package:barkibu/cubit/cubit.dart';
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
                  SkipAnimation.pushReplacement(context, '/veterinarian_profile_screen');
                });
                break;
              case ScreenStatus.failure:
                if (veterianInfoCubit.state.statusCode == 'SCTY-4004') {
                  Future.microtask(() {
                    print('Error: ${veterianInfoCubit.state.statusCode}');
                    SkipAnimation.pushReplacement(context, '/login_screen');
                  });
                }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
