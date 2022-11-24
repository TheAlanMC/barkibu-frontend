import 'package:barkibu/cubit/pet_treatment/pet_treatment_cubit.dart';
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
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: petTreatmentCubit.getPetTreatments(),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tratamientos'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (PetTreatmentDto petTreatment in petTreatmentCubit.state.petTreatments!)
                  CardContainer(
                    child: CustomTextButton(
                      text: petTreatment.treatment,
                      subtext: 'Última fecha :${DateUtil.dateTimeToString(petTreatment.treatmentLastDate)}',
                      subsubtext: 'Próxima fecha :${DateUtil.dateTimeToString(petTreatment.treatmentNextDate)}',
                      icon: Icons.vaccines,
                      size: 60,
                      color: petTreatment.treatmentNextDate.isBefore(DateTime.now()) ? Colors.red : Colors.green,
                      fontSize: 20,
                      onPressed: (() => {}),
                      // onPressed: () => (petTreatment.treatmentId == petTreatmentCubit.state.treatmentId)
                      //     ? Navigator.of(context).pushNamed('/pet_owner_pets_treatment_edit_screen')
                      //     : petTreatmentCubit.changeTreatmentId(petTreatment.treatmentId),
                    ),
                  ),
                const SizedBox(height: 20),
                CustomMaterialButton(
                  text: 'Añadir tratamiento',
                  onPressed: () => Navigator.of(context).pushNamed('/pet_owner_pet_treatment_add_screen'),
                ),
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
