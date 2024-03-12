import 'package:hive/hive.dart';

import '../constants.dart';
import 'game_logic.dart';

part 'menu_state.g.dart';

@HiveType(typeId: 4)
class MenuState {
  // TODO -- Create Accomplishments
  // @HiveField(1)
  // List<Accomplishments> = []
  @HiveField(0)
  GameLogic game = GameLogic();

  MenuState();

  startNewGame() {
    game = GameLogic();
    Hive.box(greenZoneData).put(0, game);
    // in function
    print("IN new function");
    game.buildPowerUpState();
  }

  loadGame() {}
}
