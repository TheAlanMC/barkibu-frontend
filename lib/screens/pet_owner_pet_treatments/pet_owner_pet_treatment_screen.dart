import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/dto/pet_treatment_dto.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PetOwnerPetTreatmentScreen extends StatelessWidget {
  const PetOwnerPetTreatmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final petTreatmentCubit = BlocProvider.of<PetTreatmentCubit>(context);
    final petInfoCubit = BlocProvider.of<PetInfoCubit>(context);
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: petTreatmentCubit.getPetTreatments(petInfoCubit.state.petId!),
          builder: (BuildContext build, AsyncSnapshot<void> snapshot) {
            switch (petTreatmentCubit.state.status) {
              case ScreenStatus.initial:
                return const CircularProgressIndicator();
              case ScreenStatus.loading:
                return const CircularProgressIndicator();
              case ScreenStatus.success:
                return _PetOwnerPetTreatment();
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

class _PetOwnerPetTreatment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final petTreatmentCubit = BlocProvider.of<PetTreatmentCubit>(context);
    final petInfoCubit = BlocProvider.of<PetInfoCubit>(context);
    final String? petName = petInfoCubit.state.pets?.firstWhere((element) => element.petId == petInfoCubit.state.petId).name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tratamientos de $petName'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (petTreatmentCubit.state.petTreatments!.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text('No hay tratamientos registrados'),
                    ),
                  ),
                for (PetTreatmentDto petTreatment in petTreatmentCubit.state.petTreatments!)
                  CardContainer(
                    child: CustomTextButton(
                        text: petTreatmentCubit.state.treatments!.firstWhere((element) => element.treatmentId == petTreatment.treatmentId).treatment,
                        subtext: 'Próxima fecha :${DateUtil.dateTimeToString(petTreatment.treatmentNextDate)}',
                        subsubtext: 'Última fecha :${DateUtil.dateTimeToString(petTreatment.treatmentLastDate)}',
                        icon: Icons.vaccines,
                        size: 60,
                        color: petTreatment.treatmentNextDate.isBefore(DateTime.now()) ? Colors.red : Colors.green,
                        fontSize: 20,
                        onPressed: () {
                          if (petTreatment.treatmentId == petTreatmentCubit.state.treatmentId) {
                            Navigator.of(context).pushNamed('/pet_owner_pet_treatment_edit_screen');
                          } else {
                            petTreatmentCubit.changePetTreatmentId(petTreatment.petTreatmentId);
                            Navigator.of(context).pushNamed('/pet_owner_pet_treatment_edit_screen');
                          }
                        }),
                  ),
                const SizedBox(height: 20),
                CustomMaterialButton(
                    text: 'Añadir tratamiento',
                    onPressed: () {
                      petTreatmentCubit.resetTreatmentDescription();
                      Navigator.of(context).pushNamed('/pet_owner_pet_treatment_add_screen');
                    }),
                const SizedBox(height: 40),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 1,
      ),
    );
  }
}
