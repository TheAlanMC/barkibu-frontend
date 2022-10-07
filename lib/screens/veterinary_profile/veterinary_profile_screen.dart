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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Card(child: _profileInfo()),
          ]),
        ),
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
          CustomCircleAvatar(
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
}
