import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/utils/utils.dart';
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
      body: BlocConsumer<PetInfoCubit, PetInfoState>(
        listener: (context, state) async {
          switch (state.status) {
            case ScreenStatus.initial:
              break;
            case ScreenStatus.loading:
              break;
            case ScreenStatus.success:
              Navigator.of(context).pushNamed('/pet_owner_pets_data_screen');
              break;
            case ScreenStatus.failure:
              if (state.statusCode == 'SCTY-2002') Logout.logout(context);
              customShowDialog(context: context, title: 'ERROR ${state.statusCode}', message: state.errorDetail ?? 'Error desconocido');
              break;
            default:
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (PetInfoDto pet in state.pets!)
                      CardContainer(
                        child: CustomTextButton(
                          text: pet.name,
                          icon: Icons.pets,
                          size: 60,
                          fontSize: 20,
                          onPressed: () => (pet.petId == state.petId)
                              ? Navigator.of(context).pushNamed('/pet_owner_pets_data_screen')
                              : petInfoCubit.changePetId(pet.petId),
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
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 0,
      ),
    );
  }
}
