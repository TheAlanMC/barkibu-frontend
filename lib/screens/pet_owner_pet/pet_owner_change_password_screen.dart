// TODO: NOT NECESSARY FOR MVP
// import 'package:flutter/material.dart';
// import 'package:barkibu/widgets/widgets.dart';

// class PetOwnerChangePassword extends StatelessWidget {
//   const PetOwnerChangePassword({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cambio contraseña'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: CustomScrollView(
//           slivers: [
//             SliverFillRemaining(
//               hasScrollBody: false,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: CardContainer(
//                       child: Column(
//                         children: [
//                           Expanded(child: _userAccountForm(context)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   CustomMaterialButton(
//                     text: 'Guardar',
//                     onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/pet_owner_settings_screen')),
//                   ),
//                   const SizedBox(height: 40),
//                   CustomMaterialButton(
//                       cancel: true,
//                       text: 'Cancelar',
//                       onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/pet_owner_pet_info_screen', (Route<dynamic> route) => false)),
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _userAccountForm(BuildContext context) {
//     return Form(
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           TextFormField(
//             autocorrect: false,
//             decoration: const InputDecoration(labelText: 'Ingrese la contraseña actual*'),
//           ),
//           TextFormField(
//             autocorrect: false,
//             decoration: const InputDecoration(labelText: 'Ingrese la nueva contraseña*'),
//           ),
//           TextFormField(
//             autocorrect: false,
//             decoration: const InputDecoration(labelText: 'Re-ingrese la nueva contraseña*'),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
