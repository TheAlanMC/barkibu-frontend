import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserPetOwnerCubit>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: user.getUserPetOwner(),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (user.state.status) {
              case ScreenStatus.initial:
                return const CircularProgressIndicator();
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                return const _AdminHomeScreen();
              case ScreenStatus.failure:
                Future.microtask(() => Logout.logout(context));
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class _AdminHomeScreen extends StatelessWidget {
  const _AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserPetOwnerCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
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
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardContainer(
                  child: Column(
                    children: [
                      const Image(image: AssetImage('assets/barkibu_logo.png'), height: 120),
                      const SizedBox(height: 20),
                      const Text(
                        'Bienvenido Administrador',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text('${user.state.userPetOwnerDto!.firstName} ${user.state.userPetOwnerDto!.lastName}',
                          style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationAdmin(
        currentIndex: 0,
      ),
    );
  }
}
