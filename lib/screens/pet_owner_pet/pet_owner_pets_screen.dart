import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetOwnerPetsScreen extends StatelessWidget {
  const PetOwnerPetsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final petInfoCubit = BlocProvider.of<PetInfoCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (PetInfoDto pet in petInfoCubit.state.pets!)
                  CardContainer(
                    child: CustomTextButton(
                      text: pet.name,
                      icon: Icons.pets,
                      size: 60,
                      fontSize: 20,
                      onPressed: () => Navigator.of(context).pushNamed('/pet_owner_pets_data_screen', arguments: pet.petId),
                    ),
                  ),
                CardContainer(
                  child: CustomTextButton(
                    text: 'Añadir mascota',
                    icon: Icons.add,
                    size: 60,
                    fontSize: 20,
                    onPressed: () => Navigator.of(context).pushNamed('/pet_owner_register_pet_screen'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 0,
      ),
    );
  }
}
