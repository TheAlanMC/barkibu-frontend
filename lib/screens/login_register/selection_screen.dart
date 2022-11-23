import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);

    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: loginCubit.getGroups(),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (loginCubit.state.status) {
              case ScreenStatus.initial:
                return const CircularProgressIndicator();
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                Future.microtask(() {
                  if (loginCubit.state.groups!.length > 1) {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const _Selection(),
                        transitionDuration: Duration.zero,
                      ),
                    );
                    return const _Selection();
                  } else {
                    switch (loginCubit.state.groups![0]) {
                      case 'ADMINISTRADOR':
                        SkipAnimation.pushReplacement(context, '/admin_screen');
                        break;
                      case 'DUEÑO DE MASCOTA':
                        SkipAnimation.pushReplacement(context, '/pet_owner_pet_info_screen');
                        break;
                      case 'VETERINARIO':
                        SkipAnimation.pushReplacement(context, '/veterinarian_profile_screen');
                        break;
                    }
                  }
                });
                break;
              case ScreenStatus.failure:
                Logout.logout(context);
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class _Selection extends StatelessWidget {
  const _Selection();
  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Usuario'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Logout.logout(context),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardContainer(
                  child: Column(
                    children: [
                      const Image(image: AssetImage('assets/barkibu_logo.png'), height: 120),
                      const SizedBox(height: 40),
                      if (loginCubit.state.groups!.contains('ADMINISTRADOR'))
                        CustomMaterialButton(
                          text: 'ADMINISTRADOR',
                          onPressed: () => Navigator.of(context).popAndPushNamed('/admin_screen'),
                          horizontalPadding: 55,
                        ),
                      const SizedBox(height: 40),
                      if (loginCubit.state.groups!.contains('DUEÑO DE MASCOTA'))
                        CustomMaterialButton(
                          text: 'DUEÑO DE MASCOTA',
                          onPressed: () => Navigator.of(context).popAndPushNamed('/pet_owner_pet_info_screen'),
                          horizontalPadding: 38,
                        ),
                      const SizedBox(height: 40),
                      if (loginCubit.state.groups!.contains('VETERINARIO'))
                        CustomMaterialButton(
                          text: 'VETERINARIO',
                          onPressed: () => Navigator.of(context).popAndPushNamed('/veterinarian_profile_screen'),
                          horizontalPadding: 70,
                        ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
