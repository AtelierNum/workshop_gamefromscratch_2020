/** Skurf the little Alien!
 *
 * Author: ILIAN GOUDET
 * Date: 18/09/2020
 */

//Importation des pistes sonores
import processing.sound.*;
SoundFile music;
SoundFile win;
SoundFile lose;
SoundFile lvlup;
SoundFile col;
SoundFile eat;

//Importation de mes images: Fond, agent, meteor, player
PImage back, green, red, blue;

//Listes de mes objets
ArrayList<Agent> agent = new ArrayList <Agent>();
ArrayList<Meteor> meteor = new ArrayList <Meteor>();
ArrayList<Level> level = new ArrayList <Level>();

//Variables
int score, life, currentLevelID;

boolean endGame = false;
boolean lecture = false;
boolean isDefeat = false;
boolean isVictory = false;
boolean restart = false;

int agentEaten;
int nPoppedAgent = 0;
int nPoppedMeteor = 0;


//Noms de mes objets
Agent a;
Meteor m;
Player p;
Level currentLevel;

//Première phase de ma boucle
void setup() {


  //Ajout des images (Sprites)
  back = loadImage("Background1920.png");
  red = loadImage("Meteor.png");
  green = loadImage("Agent.png");
  blue = loadImage("Alien.png");

  //Ajout de la musique
  music = new SoundFile(this, "music4.wav");
  eat = new SoundFile(this, "eat3.wav");
  lvlup = new SoundFile(this, "level1.wav");
  col = new SoundFile (this, "collision3.wav");
  win = new SoundFile(this, "win3.wav");
  lose = new SoundFile(this, "game_over2.wav");

  fullScreen();
  frameRate(60);

  //Correspondance : aNb, mNb, aRP, mRP, aEtn, mSpd
  level.add(new Level(5, 8, 40, 35, 5, 15));


  level.add(new Level(15, 21, 45, 30, 15, 20));
  level.add(new Level(25, 27, 50, 25, 25, 35));
  level.add(new Level(30, 33, 45, 20, 30, 45));
  level.add(new Level(25, 33, 55, 20, 25, 25));



  println(level.size());

  initialize();
}

void initialize() {

  currentLevelID = 0;
  currentLevel = level.get(currentLevelID);
  nPoppedMeteor = 0;
  nPoppedAgent = 0;

  endGame = false;
  isDefeat = false;
  isVictory = false;
  restart = false;

  agent.clear();
  meteor.clear();
  //  level.clear();

  score = 0;
  life = 5;
  music.loop();

  // meteor.clear();
  //agent.clear();

  p = new Player();

  //Je donne les conditions d'apparitions de mes objets
  /*
  for (int e=0; e<currentLevel.meteorNumber; e++) {
   meteor.add(new Meteor(e));
   }
   
   for (int i=0; i<currentLevel.agentNumber; i++) {
   agent.add(new Agent(i));
   }*/
}
//Début de ma boucle qui se répète à toutes les frames
void draw() {

  tint(255, 90);
  image(back, 0, 0);
  tint(255, 255);

  if (lecture == false) {
    music.loop();
    lecture = true;
  }

  if (agentEaten >= currentLevel.agentEaten) {
    lvlup.play();
    nextLevel();
    agent.clear();
    meteor.clear();
  }

  motionBlur (30);
  p.movePlayer();
  p.displayPlayer();

  //Condition de défaite
  if (life <= 0 && isDefeat == false) {
    music.stop();
    lose.play();
    isDefeat = true;
  }
  if (isDefeat == true) {
    gameOver();
  }
  //Condition de victoire
  if (currentLevelID == 4 && isVictory == false) {
    music.stop();
    lvlup.stop();
    win.play();
    isVictory = true;
  } 
  if (isVictory == true) {
    victory();
  }
  //Configuration de l'implantation de mon objet "meteor"
  for (int e = 0; e< meteor.size(); e++) {
    Meteor m = meteor.get(e);
    m.moveMeteor(currentLevel.meteorSpeed);
    m.display();

    //Défintion de la Hitbox de mon objet "meteor"
    if (dist(p.x, p.y, m.xpos, m.ypos) <30) {
      meteor.remove(e);
      col.play();
      //Effets de la collision du "player" et de "meteor"
      //Càd: perte de points, perte de vie
      changeScore(-25);
      changeLife(-1);
    }
  }

  //Taux de réappartition de mon objet "meteor" 
  if (frameCount%currentLevel.meteorRatePop == 0 && nPoppedMeteor < currentLevel.meteorNumber) {
    meteor.add(new Meteor(random(1000)));
    nPoppedMeteor += 1;
  }

  //Configuration de l'implantation de mon objet "agent"
  for (int i = 0; i< agent.size(); i++) {
    Agent a = agent.get(i);
    a.moveAgent();
    a.display();

    //Définition de la Hitbox de mon objet "agent"
    if (dist(p.x, p.y, a.xpos, a.ypos) <30) {
      agent.remove(i);
      eat.play();
      //Effet de la collision du "player" et de "agent"
      //Càd: gain de score
      agentEaten++;
      changeScore(10);
    }
  }

  //Taux de réapparition de mon objet "agent"
  if (frameCount%currentLevel.agentRatePop == 0 && nPoppedAgent < currentLevel.agentNumber) {
    agent.add(new Agent(random(1000)));
    nPoppedAgent += 1;
  }

  //Ecriture de mes points de vie et de mon score ainsi que du niveau actuel
  displayLife();
  displayScore();
  displayLvl();
}

//Fonction permettant l'arrêt du "score" après une victoire ou une défaite
void changeScore(int i) {
  if (endGame)
    return;
  score+=i;
}

//Fonction permettant l'arrêt de la "life" après une victoire ou une défaite
void changeLife(int i) {
  if (endGame)
    return;
  life+=i;
}

//Fonction permettant l'affichage du score
void displayScore() {
  fill(255);
  textSize(50);
  text("SCORE : "+score, 160, 50);
}

//Fonction permettant l'affichage de la vie
void displayLife() {
  fill(255);
  textSize(50);
  text("LIFE : "+life, 1800, 50);
  textAlign(CENTER);
}

//Fonction permettant l'affichage du "level" en cours
void displayLvl() {
  fill(255);
  textSize(50);
  text("LEVEL : "+currentLevelID, width/2, 50);
  textAlign(CENTER);
}

//Fonction permettant l'affichage du "game over" en cas de défaite
void gameOver() {
  endGame = true;
  fill(255);
  textSize(80);
  p.stop();
  text("GAME OVER", width/2, height/2);
  textAlign(CENTER);
  text("PRESS SPACE TO TRY AGAIN", width/2, height/2+100);
  if (restart == true) {
    initialize();
  }
}

//Fonction permettant l'affichage du "you win" en cas de victoire
void victory() {
  endGame = true;
  fill(255);
  textSize(80);
  p.stop();
  text("YOU WIN", width/2, height/2);
  textAlign(CENTER);
  text("PLAY AGAIN ?", width/2, height/2+100);
  textAlign(CENTER);
  if (restart == true) {
    initialize();
  }
}

//Fonction permettant le redémarrage du jeu en fin de partie, que ce soit une victoire ou une défaite
void keyPressed() {
  if (keyCode == 32) {
    restart = true;
    music.stop();
    // level.clear();
    initialize();
  }
}

//Fonction permettant le passage des niveaux quand les conditions sont remplies
void nextLevel() {

  println(level);
  currentLevelID += 1;
  currentLevel = level.get(currentLevelID);
  agentEaten = 0;
  nPoppedAgent = 0;
  nPoppedMeteor = 0;

  //Je donne les conditions d'apparitions de mes objets
  for (int e=0; e<currentLevel.meteorNumber; e++) {
    meteor.add(new Meteor(e));
  }

  for (int i=0; i<currentLevel.agentNumber; i++) {
    agent.add(new Agent(i));
  }
}

void motionBlur (int transparency) {
  noStroke();
  fill(0, transparency);
  rect (0, 0, width, height);
}
