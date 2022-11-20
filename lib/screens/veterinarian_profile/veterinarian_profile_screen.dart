import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VeterinarianProfileScreen extends StatelessWidget {
  const VeterinarianProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;
    final bottomPadding = MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight;
    final heigth = MediaQuery.of(context).size.height - topPadding - bottomPadding - 10;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/veterinary_profile_settings_screen'),
            icon: const Icon(Icons.settings),
          ),
          //TODO: DELETE THIS ICON AFTER TESTING
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              TokenSecureStorage.deleteTokens();
              SkipAnimation.pushReplacement(context, '/login_screen');
            },
          )
        ],
      ),
      body: BlocConsumer<VeterinarianInfoCubit, VeterinarianInfoState>(listener: (context, state) {
        // TODO: implement listener
      }, builder: (context, state) {
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
                          Card(child: _profileInfo(state.veterinarianInfo!)),
                          Card(child: _veterinarianRanking(state.veterinarianRanking!)),
                          Card(child: _aboutMe(state.veterinarianInfo!.description)),
                          Card(child: _reputation(state.veterinarianReputation!)),
                          Card(child: _contribution(state.veterinarianContributions!))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heigth,
                      child: Column(
                        children: [
                          Card(child: _veterinaryInfo()),
                          Card(child: _veterinaryLocation()),
                          Card(child: _aboutVeterinary()),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomMaterialButton(
                              text: 'Respuestas publicadas',
                              onPressed: () {},
                              horizontalPadding: 50,
                            ),
                          ),
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
      bottomNavigationBar: const CustomBottomNavigationVeterinary(
        currentIndex: 0,
      ),
    );
  }

  Widget _profileInfo(VeterinarianInfoDto veterinarianInfo) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomCircleAvatar(
            photoPath: veterinarianInfo.photoPath ?? 'assets/default_veterinarian_profile.png',
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    veterinarianInfo.firstName,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    veterinarianInfo.lastName,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                if (veterinarianInfo.city != null && veterinarianInfo.state != null && veterinarianInfo.country != null)
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        Text('${veterinarianInfo.city}, ${veterinarianInfo.state} (${veterinarianInfo.country})',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _veterinarianRanking(VeterinarianRankingDto veterinarianRanking) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${veterinarianRanking.monthlyRanking}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text('RANKING MENSUAL', style: TextStyle(fontSize: 16)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${veterinarianRanking.generalRanking}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text('RANKING GENERAL', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aboutMe(String? description) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(child: Text('Acerca de mi:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                if (description != null && description.isNotEmpty)
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    maxLines: 10,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reputation(VeterinarianReputationDto veterinarianReputation) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reputación:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Text('${veterinarianReputation.totalAnswers}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Expanded(child: Text('Respuestas', style: TextStyle(fontSize: 16))),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Text('${veterinarianReputation.totalVeterinarianLike}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Expanded(
                  child: Text('Dueños de mascotas han apoyado mis respuestas', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16))),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Text('${veterinarianReputation.totalVeterinarianLike}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Expanded(
                  child: Text('Colegas veterinarios han apoyado mis respuestas', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contribution(List<VeterinarianContributionDto> veterinarianContributions) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mascotas ayudadas:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ...veterinarianContributions.map(
            (e) => Row(
              children: [
                SizedBox(width: 50, child: Text('${e.totalAnswers}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text(
                  e.totalAnswers == 1 ? '${e.specie}' : '${e.specie}s',
                  style: const TextStyle(fontSize: 16),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _veterinaryInfo() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Image(image: AssetImage('assets/veterinary_icon.png'), width: 50, height: 50),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Mundo Animal',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: const [
                    Icon(Icons.location_on),
                    Expanded(child: Text('Avenida Bush #123, entre calle 1 y 2, La Paz, Bolivia', style: TextStyle(fontSize: 16))),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _veterinaryLocation() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ubicación:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.secondary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(child: Text('MAPA')),
          ),
        ],
      ),
    );
  }

  Widget _aboutVeterinary() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Acerca de la veterinaria:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt lacinia, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Sed euismod, nunc vel tincidunt lacinia, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
