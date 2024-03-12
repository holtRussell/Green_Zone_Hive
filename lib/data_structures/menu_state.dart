import 'package:hive/hive.dart';

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
}
