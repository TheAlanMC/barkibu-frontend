import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetOwnerPetInfoScreen extends StatelessWidget {
  const PetOwnerPetInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final petInfoCubit = BlocProvider.of<PetInfoCubit>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: petInfoCubit.getPetInfo(),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (petInfoCubit.state.status) {
              case ScreenStatus.initial:
                return const CircularProgressIndicator();
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                if (petInfoCubit.state.pets != null) {
                  return const _PetOwnerPetInfo();
                } else {
                  Future.microtask(() => SkipAnimation.pushReplacement(context, '/pet_owner_register_pet_screen'));
                }
                break;
              case ScreenStatus.failure:
                Future.microtask(() {
                  Logout.logout(context);
                });
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class _PetOwnerPetInfo extends StatelessWidget {
  const _PetOwnerPetInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final petInfoCubit = BlocProvider.of<PetInfoCubit>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tarjeta Veterinaria'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () => Navigator.of(context).pushNamed('/pet_owner_settings_screen'), icon: const Icon(Icons.settings)),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => Logout.logout(context),
            )
          ],
        ),
        body: const Center(
          child: Text('PetScreen'),
        ),
        bottomNavigationBar: const CustomBottomNavigationPetOwner(
          currentIndex: 0,
        ));
  }
}
