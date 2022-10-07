import 'package:barkibu/theme/app_theme.dart';
import 'package:barkibu/widgets/widgets.dart';
import 'package:flutter/material.dart';

class VeterinaryProfileScreen extends StatelessWidget {
  const VeterinaryProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/veterinary_profile_settings_screen'),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Card(child: _profileInfo()),
              Card(child: _veterinarianRanking()),
              Card(child: _aboutMe()),
              Card(child: _reputation(context)),
              Card(child: _profileInfo()),
              Card(child: _veterinarianRanking()),
              Card(child: _aboutMe()),
              Card(child: _reputation(context)),
            ]),
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationVeterinary(
        currentIndex: 0,
      ),
    );
  }

  Widget _profileInfo() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomCircleAvatar(
            border: AppTheme.secondary,
            path: 'assets/veterinary_profile.jpg',
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Juan Perez', style: TextStyle(fontSize: 20)),
              Row(
                children: const [
                  Icon(Icons.location_on),
                  Text('La Paz, Bolivia', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _veterinarianRanking() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('#10', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('RANKING MENSUAL', style: TextStyle(fontSize: 16)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('#20', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('RANKING GENERAL', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aboutMe() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(child: Text('Acerca de mi:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Text(
            //TODO: MAX 200 CHARACTERS
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc vel tincidunt lacinia, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Sed euismod, nunc vel tincidunt lacinia, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  Widget _reputation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reputación:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: const [
              SizedBox(width: 50, child: Text('50', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              Expanded(child: Text('Respuestas', style: TextStyle(fontSize: 16))),
            ],
          ),
          Row(
            children: const [
              SizedBox(width: 50, child: Text('100', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text('Dueños de mascotas han apoyado mis respuestas',
                      textAlign: TextAlign.justify, style: TextStyle(fontSize: 16))),
            ],
          ),
          Row(
            children: const [
              SizedBox(width: 50, child: Text('50', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              Expanded(
                  child: Text('Colegas veterinarios han apoyado mis respuestas',
                      textAlign: TextAlign.justify, style: TextStyle(fontSize: 16))),
            ],
          ),
          const Text(
            'Mascotas ayudadas:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: const [
              SizedBox(width: 50, child: Text('50', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              Expanded(child: Text('Perros', style: TextStyle(fontSize: 16))),
            ],
          ),
          Row(
            children: const [
              SizedBox(width: 50, child: Text('100', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              Expanded(child: Text('Gatos', style: TextStyle(fontSize: 16))),
            ],
          ),
        ],
      ),
    );
  }
}
