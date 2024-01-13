Minim m;

final String LEVEL_ONE_MUSIC = "trackA.mp3";
final String LEVEL_TWO_MUSIC = "trackB.mp3";
final String LEVEL_THREE_MUSIC = "trackC.mp3";
final String LEVEL_FOUR_MUSIC = "trackD.mp3";

int currentIndex = -1; // The index of the currently playing music
boolean musicEnd = false;

String[] trackFilenames = {
  LEVEL_ONE_MUSIC,
  LEVEL_TWO_MUSIC,
  LEVEL_THREE_MUSIC,
  LEVEL_FOUR_MUSIC
};

AudioPlayer[] music = new AudioPlayer[trackFilenames.length + 1];

void setupAudio() {
  m = new Minim(this);

  music[0] = m.loadFile(LEVEL_ONE_MUSIC);
  music[1] = m.loadFile(LEVEL_TWO_MUSIC);
  music[2] = m.loadFile(LEVEL_THREE_MUSIC);
  music[3] = m.loadFile(LEVEL_FOUR_MUSIC);
  music[4] = m.loadFile(LEVEL_FOUR_MUSIC); // End title sting
  
  music[4].skip(214400);
}

void playMusic(int index) {
  // Find the index of the currently playing music, if any
  for (int i = 0; i < music.length; i++) {
    if (music[i].isPlaying()) {
      currentIndex = i;
      break;
    }
  }

  // If the selected track is already playing, return
  if (currentIndex == index) {
    return;
  }

  if (currentIndex >= 0) {
    // Stop the current track and reset it
    music[currentIndex].pause();
    music[currentIndex].rewind();
  }

  // Start the new track
  music[index].loop();
}

void handleWinMusic(){
  if (!musicEnd) {
    musicEnd = true;
    music[currentIndex].pause();    
    
    music[4].play();
  }
}
