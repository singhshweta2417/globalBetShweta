import 'package:game_on/generated/assets.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/view/home/rummy/teen_patti/view_model/service/game_services.dart';
import 'package:provider/provider.dart';

import '../../../../../material_imports.dart';
import '../view_model/service/loader_overlay_service.dart';

class DashboardScreenActivity extends StatefulWidget {
  const DashboardScreenActivity({super.key});

  @override
  State<DashboardScreenActivity> createState() =>
      _DashboardScreenActivityState();
}

class _DashboardScreenActivityState extends State<DashboardScreenActivity>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // Provider.of<AuthService>(context, listen: false).getSessionUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ProfileViewModel>(context);
    return Consumer<TeenPattiGameController>(builder: (context, gameCon, _) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          leading: ContBox(
            margin: const EdgeInsets.only(top: 5, left: 8, bottom: 5),
            shape: BoxShape.circle,
            height: Sizes.screenWidth / 15,
            width: Sizes.screenWidth / 15,
            color: Colors.grey,
            border: Border.all(width: .5, color: Colors.black),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black,
              )
            ],
            image: const DecorationImage(
                image: AssetImage(Assets.teenPattiLadyImg), fit: BoxFit.cover),
          ),
          title: Text(
            userData.userName,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: false,
          actions: [
            ContBox(
              height: 30,
              margin: const EdgeInsets.only(right: 5),
              radius: 5,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color.fromRGBO(0, 5, 5, 0.3),
              child: Row(
                children: [
                  const Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                  Sizes.spaceW5,
                  const CText("History"),
                ],
              ),
            ),
            ContBox(
              height: 30,
              margin: const EdgeInsets.only(right: 5),
              radius: 5,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: const Color.fromRGBO(0, 5, 5, 0.3),
              child: Row(
                children: [
                  const Icon(
                    Icons.wallet,
                    color: Colors.white,
                  ),
                  Sizes.spaceW5,
                  CText("Balance: 🪙${userData.balance}"),
                ],
              ),
            )
          ],
        ),
        extendBody: true,
        body: ContBox(
          onTap: () {
            LoaderOverlay().show(context);
            gameCon.joinGame(context).then((v) {
              if (v) {
                gameCon.startListeningToGame(context, this);
              } else {
                debugPrint('something went wrong');
              }
            });
          },
          height: Sizes.screenHeight,
          width: Sizes.screenWidth,
          radius: 0,
          image: const DecorationImage(
              image: AssetImage(Assets.teenPattiLadyImg), fit: BoxFit.cover),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(gameCon.gameType.length, (i) {
              final images = gameCon.gameType[i];
              return ContBox(
                margin: const EdgeInsets.only(right: 15),
                height: Sizes.screenWidth / 5.5,
                width: Sizes.screenWidth / 6,
                radius: 10,
                padding: const EdgeInsets.all(0),
                image: DecorationImage(
                    image: AssetImage(images), fit: BoxFit.fitHeight),
              );
            }),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     showLogoutPopup(context);
        //   },
        //   backgroundColor: Colors.black,
        //   child: const Icon(
        //     Icons.logout,
        //     color: Colors.white,
        //   ),
        // ),
      );
    });
  }

  // void showLogoutPopup(BuildContext context) {
  //   showCupertinoDialog(
  //     context: context,
  //     builder: (context) => CupertinoAlertDialog(
  //       title: const Text("Logout"),
  //       content: const Text("Are you sure you want to logout?"),
  //       actions: [
  //         CupertinoDialogAction(
  //           child: const Text("Cancel"),
  //           onPressed: () => Navigator.of(context).pop(),
  //         ),
  //         Consumer<AuthService>(builder: (context, authCon, _) {
  //           return CupertinoDialogAction(
  //             isDestructiveAction: true,
  //             child: const Text("Logout"),
  //             onPressed: () {
  //               authCon.logout(context);
  //               // Navigator.of(context).pop();
  //             },
  //           );
  //         }),
  //       ],
  //     ),
  //   );
  // }
}
