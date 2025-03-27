import 'package:globalbet/view/home/rummy/teen_patti/view_model/service/sound_controller.dart';

import '../../../../../../material_imports.dart';

class CardThrowAnimation extends ChangeNotifier {
  AnimationController? _controller;
  Animation<Offset>? _animation;
  Offset? center;
  AnimationController? get controller => _controller;
  Animation<Offset>? get animation => _animation;
  List<Offset> playerPositions = [];
  List<List<Offset>> distributedCards = [];
  int currentCardIndex = 0;
  int currentRound = 0;

  final int totalPlayers = 3;
  int cardsPerPlayer = 1;
  List<Offset> targetPositions = [];
  int currentTargetIndex = 0;

  late Offset startCenter;

  startAnimation(TickerProvider vsync, int cardPerPlayer) {
    distributedCards = [];
    cardsPerPlayer = cardPerPlayer;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));
    // setupPositions();
    animateCard();
    notifyListeners();
  }

  void throwNextCard() {
    if (currentRound < cardsPerPlayer) {
      if (currentCardIndex < totalPlayers) {
        _animation = Tween<Offset>(
          begin: center,
          end: targetPositions[currentCardIndex],
        ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));

        _controller!.forward(from: 0).then((_) {
          distributedCards[currentCardIndex]
              .add(targetPositions[currentCardIndex]);
          SoundController().playCardThrowSound();
          currentCardIndex++;

          // Move to the next round when all players receive a card
          if (currentCardIndex >= totalPlayers) {
            currentCardIndex = 0;
            currentRound++;
          }

          Future.delayed(const Duration(milliseconds: 300), () {
            throwNextCard();
          });
        });
        notifyListeners();
      } else {}
    } else {
      // _animation=null;
      // _controller= null;
      // notifyListeners();
    }
  }

  animateCard() async {
    print("function invoked");
    // Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
    //     ? Sizes.screenWidth / 2.2
    //     : Sizes.screenWidth / 2.2,
    center = Offset(Sizes.screenWidth / 2.2, 50);
    final width = Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
        ? Sizes.screenWidth / 1.05
        : Sizes.screenWidth / 1.6;
    // Sizes.screenWidth > 1000 || Sizes.screenWidth < 700
    //     ? Sizes.screenWidth
    //     : Sizes.screenWidth / 1.2;
    targetPositions = [
      Offset(Sizes.screenWidth / 2.21, width / 3.5),
      Offset(width / 3.3, width / 9),
      Offset(Sizes.screenWidth / 1.4, width / 9),
    ];

    // targetPositions = [
    //   Offset(Sizes.screenWidth / 2.25, width / 3),
    //   Offset(width / 20, width / 6),
    //   Offset(Sizes.screenWidth / 1.17, width / 6),
    // ];
    distributedCards = List.generate(totalPlayers, (_) => []);
    throwNextCard();
    notifyListeners();
  }

  void resetAnimation() {
    print("game ress");
    _controller?.stop();
    _controller?.dispose();
    _controller = null;
    _animation = null;

    currentCardIndex = 0;
    currentRound = 0;
    distributedCards.clear();
    notifyListeners();
  }
}
