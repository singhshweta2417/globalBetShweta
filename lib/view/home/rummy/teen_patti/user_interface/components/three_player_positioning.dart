// import 'package:teen_patti/material_imports.dart';
// import 'package:teen_patti/user_interface/components/person_profile.dart';
// import 'package:teen_patti/user_interface/components/player_profile_with_card.dart';
//
// class ThreePlayerPositioning extends StatelessWidget {
//   const ThreePlayerPositioning({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.center,
//         children: [
//           ContBox(
//             width: Sizes.screenWidth,
//             height: Sizes.screenHeight / 5,
//             clipBehavior: Clip.none,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 PlayerProfileWithCard(),
//                 PlayerProfileWithCard(
//                   leftSide: false,
//                 ),
//               ],
//             ),
//           ),
//         ]);
//   }
// }



// child: Stack(
//   clipBehavior: Clip.none,
//   children: List.generate(3, (i) {
//     return Positioned(
//       left:leftSide? 10.0 * i:-10.0 * i,
//       top:leftSide? 8.0 * i:8.0 * i,
//       child: Transform.rotate(
//         angle:leftSide? 0.5*i:-0.5*i,
//         child: ContBox(
//           height: Sizes.screenWidth / 16,
//           width: Sizes.screenWidth / 25,
//           borderRadius: BorderRadius.circular(5),
//           image: DecorationImage(
//               image: AssetImage(Assets.diamondsBack)),
//         ),
//       ),
//     );
//   }),
// ),