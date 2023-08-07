// import 'package:appsaodo/bloc/user/user_bloc.dart';
// import 'package:appsaodo/bloc/user/user_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ionicons/ionicons.dart';

// class ContainerAvatar extends StatelessWidget {
//   const ContainerAvatar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserBloc, UserState>(
//       builder: (context, state) {
//         return Stack(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.width / 3.5,
//               width: MediaQuery.of(context).size.width / 3.5,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 color: Colors.amber,
//                 image: state.user.data!.user!.anhdaidien! == ''
//                     ? null
//                     : DecorationImage(image: NetworkImage(state.user.data!.user!.anhdaidien!), fit: BoxFit.cover),
//               ),
//               child: state.user.data!.user!.anhdaidien! != ''
//                   ? null
//                   : const Icon(
//                       Ionicons.person_sharp,
//                       size: 40,
//                       color: Colors.white,
//                     ),
//             ),
//             Positioned(
//               right: 0,
//               bottom: 10,
//               child: GestureDetector(
//                 onTap: () {
//                   // showModalBottomSheet<void>(
//                   //   context: context,
//                   //   builder: (BuildContext context) {
//                   //     return SizedBox(
//                   //       height: MediaQuery.of(context).size.height / 5,
//                   //       child: Center(
//                   //         child: Column(
//                   //           mainAxisAlignment: MainAxisAlignment.center,
//                   //           mainAxisSize: MainAxisSize.min,
//                   //           children: [
//                   //             GestureDetector(
//                   //               onTap: () {},
//                   //               child: const Row(
//                   //                 mainAxisAlignment: MainAxisAlignment.center,
//                   //                 children: [
//                   //                   Icon(Ionicons.camera_outline),
//                   //                   SizedBox(width: 10),
//                   //                   TextCus(
//                   //                     title: 'Chụp ảnh',
//                   //                     typeWeight: TextCusType.header,
//                   //                     customSize: 16,
//                   //                   )
//                   //                 ],
//                   //               ),
//                   //             ),
//                   //             const SizedBox(height: 10),
//                   //             GestureDetector(
//                   //               onTap: () {},
//                   //               child: const Row(
//                   //                 mainAxisAlignment: MainAxisAlignment.center,
//                   //                 children: [
//                   //                   Icon(Ionicons.image_outline),
//                   //                   SizedBox(width: 10),
//                   //                   TextCus(
//                   //                     title: 'Chọn ảnh',
//                   //                     typeWeight: TextCusType.header,
//                   //                     customSize: 16,
//                   //                   )
//                   //                 ],
//                   //               ),
//                   //             )
//                   //           ],
//                   //         ),
//                   //       ),
//                   //     );
//                   //   },
//                   // );
//                 },
//                 child: Container(
//                   width: 30,
//                   height: 30,
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white, boxShadow: [
//                     BoxShadow(color: Colors.grey.shade400, spreadRadius: 0.5, blurRadius: 3, offset: const Offset(4, 4)),
//                   ]),
//                   child: const Icon(
//                     Ionicons.camera_outline,
//                     size: 20,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
