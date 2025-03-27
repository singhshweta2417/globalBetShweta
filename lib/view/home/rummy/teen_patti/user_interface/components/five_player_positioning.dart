// import 'package:teen_patti/material_imports.dart';
// import 'package:teen_patti/user_interface/components/person_profile.dart';
// import 'package:teen_patti/user_interface/components/player_profile_with_card.dart';
//
// class FivePlayerPositioning extends StatelessWidget {
//   const FivePlayerPositioning({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.center,
//         children: [
//           Positioned(
//             bottom: Sizes.screenHeight / 2.8,
//             child: ContBox(
//               width: Sizes.screenWidth / 1.55,
//               height: Sizes.screenHeight / 5,
//               clipBehavior: Clip.none,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   PlayerProfileWithCard(),
//                   PlayerProfileWithCard(leftSide: false,),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: Sizes.screenHeight / 3.8,
//             child: ContBox(
//               width: Sizes.screenWidth / 1.25,
//               height: Sizes.screenHeight / 5,
//               clipBehavior: Clip.none,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   PlayerProfileWithCard(),
//                   PlayerProfileWithCard(leftSide: false,),
//                 ],
//               ),
//             ),
//           ),
//         ]);
//   }
// }
