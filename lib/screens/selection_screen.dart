import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionScreen extends StatelessWidget {
  SelectionScreen({Key? key}) : super(key: key);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Usuario'),
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
                    children: const [
                      Image(image: AssetImage('assets/barkibu_logo.png'), height: 120),
                    ],
                  ),
                ),
                CustomMaterialButton(
                  text: 'Dueño de mascota',
                  onPressed: () => Navigator.of(context).popAndPushNamed('/check_pet_owner_screen'),
                ),
                const SizedBox(height: 40),
                CustomMaterialButton(
                  text: 'Veterinario',
                  onPressed: () => Navigator.of(context).pushNamed('/check_veterinarian_screen'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
