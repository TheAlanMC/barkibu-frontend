import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_widget/barcode_widget.dart';

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
                return const _PetOwnerPetInfo();
              case ScreenStatus.failure:
                Future.microtask(() {
                  if (petInfoCubit.state.statusCode == 'SCTY-4008') {
                    Future.microtask(() => SkipAnimation.pushReplacement(context, '/pet_owner_register_pet_screen'));
                  }
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
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;
    final bottomPadding = MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight;
    final heigth = MediaQuery.of(context).size.height - topPadding - bottomPadding - 10;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarjeta Veterinaria'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => Navigator.of(context).pushNamed('/pet_owner_settings_screen'), icon: const Icon(Icons.settings)),
        ],
      ),
      body: BlocBuilder<PetInfoCubit, PetInfoState>(builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: heigth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (state.pets!.length > 1) _petTag(context, state.pets!, state.petId!),
                          Card(child: _petMainInfo(state.pets!.firstWhere((element) => element.petId == state.petId))),
                          Card(child: _petExtraInfo(state.pets!.firstWhere((element) => element.petId == state.petId))),
                          Card(child: _petSignDecoration(state.pets!.firstWhere((element) => element.petId == state.petId))),
                          Card(child: _chipNumber(state.pets!.firstWhere((element) => element.petId == state.petId))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
      bottomNavigationBar: const CustomBottomNavigationPetOwner(
        currentIndex: 0,
      ),
    );
  }

  Widget _petTag(BuildContext context, List<PetInfoDto> pets, int petId) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pets.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => BlocProvider.of<PetInfoCubit>(context).changePetId((pets[index].petId)),
            child: Container(
              width: width / 4,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: pets[index].petId == petId ? AppTheme.primary : AppTheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  pets[index].name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _petMainInfo(PetInfoDto pet) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomCircleAvatar(
            photoPath: pet.photoPath ?? 'assets/default_pet.jpg',
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    pet.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Nacio el ${DateUtil.dateTimeToString(pet.bornDate)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Tiene ${DateUtil.getPetAge(pet.bornDate)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _petExtraInfo(PetInfoDto pet) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Acerca de mi:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(
                width: 100,
                child: Text('Especie:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Text(pet.specie, textAlign: TextAlign.justify, style: const TextStyle(fontSize: 18))),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 100,
                child: Text('Raza:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Text(pet.breed, textAlign: TextAlign.justify, style: const TextStyle(fontSize: 18))),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 100,
                child: Text('Género:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Text(TextUtil.toUpperCaseFirstLetter(pet.gender), textAlign: TextAlign.justify, style: const TextStyle(fontSize: 18))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _petSignDecoration(PetInfoDto pet) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Firma:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: pet.specie == 'Perro'
                  ? Image.asset('assets/dog_signature.png')
                  : pet.specie == 'Gato'
                      ? Image.asset('assets/cat_signature.png')
                      : const Text('No hay firma'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chipNumber(PetInfoDto pet) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Número de chip:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (pet.chipNumber != null)
                Expanded(
                  child: BarcodeWidget(
                    barcode: Barcode.codabar(),
                    data: pet.chipNumber!,
                    height: 50,
                  ),
                )
              else
                const Center(child: Text('No tiene registrado un número de chip', style: TextStyle(fontSize: 18))),
            ],
          ),
        ],
      ),
    );
  }
}
