import 'package:provider/provider.dart';
import '../../../../../../material_imports.dart';
import '../../view_model/service/room_timer_service.dart';

class WaitingScreenActivity extends StatelessWidget {
  final int playersJoined;
  const WaitingScreenActivity({super.key, required this.playersJoined});

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomTimerProvider>(
      builder: (context, timerCon,_) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const CText("Waiting for other players to join the game"),
            backgroundColor: Colors.black,
          ),
          body: ContBox(
            height: Sizes.screenHeight,
            width: Sizes.screenWidth,
            color: Colors.black,
            child: Image.asset('assets/waiting.gif'),
          ),
          bottomSheet: ContBox(
            height: 50,
            color: Colors.black,
            child: Row(
              children: [
                CText('Time left: ${timerCon.timeLeft}'),
                Sizes.spaceW10,
                Expanded(
                  child: LinearProgressIndicator(
                    value: timerCon.progress,
                    backgroundColor: Colors.grey[800],
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                    minHeight: 10,
                  ),
                ),
                Sizes.spaceW10,
                CText('Players joined: $playersJoined'),
              ],
            ),
          ),
        );
      }
    );
  }
}
