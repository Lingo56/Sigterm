boolean NORTH, SOUTH, EAST, WEST, FIRE;

void keyPressed() {
  final int k = keyCode;

  if      (k == UP    | k == 'W')   NORTH = true;
  else if (k == DOWN  | k == 'S')   SOUTH = true;
  else if (k == LEFT  | k == 'A')   WEST  = true;
  else if (k == RIGHT | k == 'D')   EAST  = true;
  else if (k == 'P')                handlePause();

  if (DEBUG) {
    if      (k == '1')   state  = LEVEL_ONE;
    else if (k == '2')   state  = LEVEL_TWO;
    else if (k == '3')   state  = LEVEL_THREE;
    else if (k == '4')   state  = LEVEL_FINAL;
    else if (k == 'X')   player.xp = 100;
  }
}

void keyReleased() {
  final int k = keyCode;

  if      (k == UP    | k == 'W')   NORTH = false;
  else if (k == DOWN  | k == 'S')   SOUTH = false;
  else if (k == LEFT  | k == 'A')   WEST  = false;
  else if (k == RIGHT | k == 'D')   EAST  = false;
}
