// import 'package:barkibu/cubit/login/login_cubit.dart';
// import 'package:barkibu/screens/screens.dart';
// // import 'package:barkibu/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CheckVeterinarianScreen extends StatelessWidget {
//   const CheckVeterinarianScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: Center(
//         child: FutureBuilder(
//           future: loginCubit.readToken(),
//           builder: (BuildContext build, AsyncSnapshot<String> snapshot) {
//             if (!snapshot.hasData) return const CircularProgressIndicator();
//             if (snapshot.data == '') {
//               Future.microtask(() {
//                 Navigator.pushReplacement(
//                     context, PageRouteBuilder(pageBuilder: (_, __, ___) => LoginScreen(), transitionDuration: Duration.zero));
//               });
//             } else {
//               Future.microtask(() async {
//                 await loginCubit.loadToken();
//                 List<String> groups = await loginCubit.getGroups();
//                 if (groups.contains('ADMINISTRADOR') || (groups.contains('DUEÑO DE MASCOTA') && groups.contains('VETERINARIO'))) {
//                   // await customAuthShowDialog(context: context );
//                 } else {
//                   if (groups.contains('DUEÑO DE MASCOTA')) {
//                     // Navigator.pushReplacement(context,
//                     //     PageRouteBuilder(pageBuilder: (_, __, ___) => const PetOwnerPetsScreen(), transitionDuration: Duration.zero));
//                   } else {
//                     //   Navigator.pushReplacement(
//                     //       context,
//                     //       PageRouteBuilder(
//                     //           pageBuilder: (_, __, ___) => const VeterinaryProfileScreen(), transitionDuration: Duration.zero));
//                   }
//                 }
//               });
//             }

//             return Container();
//             // if (snapshot.data == '') {
//             //   return const Text('No hay token');
//             // } else {
//             //   return const Text('Token: ${snapshot.data}');
//             // }
//           },
//         ),
//       ),
//     );
//   }
// }
