import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/dto/dto.dart';
import 'package:barkibu/screens/screens.dart';
import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VeterinarianProfileScreen extends StatelessWidget {
  const VeterinarianProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;
    final bottomPadding = MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight;
    final heigth = MediaQuery.of(context).size.height - topPadding - bottomPadding - 10;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/veterinarian_profile_settings_screen'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: BlocBuilder<VeterinarianInfoCubit, VeterinarianInfoState>(builder: (context, state) {
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
                          Card(child: _veterinaryInfo(state.veterinary!)),
                          Card(child: _veterinaryLocation(context, state.veterinary!)),
                          Card(child: _aboutVeterinary(state.veterinary!)),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CustomMaterialButton(
                              text: 'Respuestas publicadas',
                              onPressed: () => Navigator.of(context).pushNamed('/veterinarian_profile_last_answer_screen'),
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
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      if (veterinarianInfo.city != null && veterinarianInfo.state != null && veterinarianInfo.country != null)
                        Text('${veterinarianInfo.city}, ${veterinarianInfo.state} (${veterinarianInfo.country})',
                            style: const TextStyle(fontSize: 16))
                      else
                        const Text('No hay información disponible', style: TextStyle(fontSize: 16, color: AppTheme.secondary)),
                    ],
                  ),
                )
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
                else
                  const Text('No hay información disponible', style: TextStyle(fontSize: 20, color: AppTheme.secondary)),
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
          const SizedBox(height: 10),
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
                child: Text('${veterinarianReputation.totalPetOwnerLike}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          const SizedBox(height: 10),
          ...veterinarianContributions.map(
            (e) => Row(
              children: [
                SizedBox(width: 50, child: Text('${e.totalAnswers}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text(
                  e.totalAnswers == 1 ? e.specie : '${e.specie}s',
                  style: const TextStyle(fontSize: 16),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _veterinaryInfo(VeterinaryDto veterinaryInfo) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Image(image: AssetImage('assets/veterinary_icon.png'), width: 50, height: 50),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Text(
                  veterinaryInfo.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    Expanded(child: Text(veterinaryInfo.address, style: const TextStyle(fontSize: 16))),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _veterinaryLocation(BuildContext context, VeterinaryDto veterinaryDto) {
    final CameraPosition kVeterinary = CameraPosition(
      target: LatLng(veterinaryDto.latitude, veterinaryDto.longitude),
      zoom: 16,
    );
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: kVeterinary,
                mapToolbarEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers: {
                  Marker(
                    markerId: const MarkerId('veterinary'),
                    position: LatLng(veterinaryDto.latitude, veterinaryDto.longitude),
                  ),
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const VeterinaryProfileDisplayLocationScreen()),
                      ),
                  text: 'Ver Mapa',
                  icon: Icons.map),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aboutVeterinary(VeterinaryDto veterinaryInfo) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(child: Text('Acerca de la veterinaria:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                Text(
                  veterinaryInfo.description,
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
}
