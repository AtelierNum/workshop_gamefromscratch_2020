import processing.sound.*;

  
SoundFile homerburger;       //importation pistes sonores
SoundFile homerbadguy;
SoundFile homerbadguy2;
SoundFile homerduff;
SoundFile victory;
SoundFile levelcomplete;
SoundFile gameover;
SoundFile maintheme;



ArrayList<Agent> agents = new ArrayList<Agent>();   // définitions des arraylists
ArrayList<Badguy> badguys = new ArrayList<Badguy>(); 
ArrayList<Badguy2> badguys2 = new ArrayList<Badguy2>(); 
ArrayList<Duff> duffs = new ArrayList<Duff>(); 
ArrayList<Level> levels = new ArrayList<Level>(); 

Eater ball;
Level curentLevel;

int displayNiveauTimeTarget = 0;       // variable necessaire a l'affichage des niveaux
float difficultySpeedA;                // variables vitesses des ennemies en fonctions des niveaux
float difficultySpeedBG;
float difficultySpeedBG2;

PImage homer;                    // déclaration des sprites
PImage burger;
PImage burns;
PImage bob;
PImage duff;

PImage Homer_Workplace;          // déclaration des fonds d'ecran
PImage Krusty_Burger;
PImage Moes_Tavern;
PImage Simpsons_House;
PImage Springfield_City;
PImage Springfield_School;
PImage loseimage;
PImage winimage;

boolean gamewin = false;        //booléens evitant le lancement des musiques de fin a chaque frame
boolean gamelose = false;
boolean lecture = false;



void setup() {

  homerburger = new SoundFile(this, "sound/mburger.wav");        // chemin vers audio
  homerbadguy = new SoundFile(this, "sound/doh.wav");
  homerbadguy2 = new SoundFile(this, "sound/doh2.wav");
  homerduff = new SoundFile(this, "sound/woohoo.WAV");
  victory = new SoundFile(this, "sound/smart.wav");
  levelcomplete = new SoundFile(this, "sound/excellnt.wav");
  maintheme = new SoundFile(this, "sound/maintheme.wav");
  gameover = new SoundFile(this, "sound/smb_gameover.wav");



  homer = loadImage("sprites/homer.png");        //chemin vers png
  burger = loadImage("sprites/burger.png");
  burns = loadImage("sprites/burns.png");
  bob = loadImage("sprites/bob.png");
  duff = loadImage("sprites/duff.png");

  Krusty_Burger = loadImage("background/Krusty_Burger.png");
  Moes_Tavern = loadImage("background/Moes_Tavern.png");
  Springfield_School = loadImage("background/Springfield_School.png");
  loseimage = loadImage("background/lose.png");
  winimage = loadImage("background/win.png");


  size(1280, 720);         //taille de la fenetre
  textAlign(CENTER);
  frameRate(60);
  difficultySpeedA = 10;             //valeurs de bases
  difficultySpeedBG = 10;
  difficultySpeedBG2 = 5;
  ellipseSize =100;

  ball = new Eater(width/2, height/2);

  levels.add(new Level(10, 30, 1, 400, 8, 70, 1, 240, 10, Springfield_School)); // definitions des parametres pour chaque niveaux
  curentLevel = levels.get(curentLevelID);
  levels.add(new Level(20, 30, 1, 400, 12, 70, 1, 240, 15, Springfield_School));
  levels.add(new Level(30, 30, 1, 400, 16, 70, 2, 240, 20, Krusty_Burger));
  levels.add(new Level(35, 30, 1, 400, 20, 70, 4, 240, 25, Krusty_Burger));
  levels.add(new Level(40, 30, 2, 400, 25, 70, 6, 240, 31, Moes_Tavern));

  displayNiveauTimeTarget = millis()+3000; 
  levelcomplete.play();
  agents.clear();            // clear les entités a hauqe début de niveau
  badguys.clear();
  badguys2.clear();
  duffs.clear();
}



void draw() {
  if (lecture == false) {
    maintheme.loop();
    lecture = true;
  }

  background(curentLevel.backgroundimage);

  if (agentEaten >= curentLevel.agentEaten && curentLevelID < 4) {     //passage de niveau

    displayNiveauTimeTarget = millis()+3000; 
    agentEaten = 0;
    nPoppedAgent = 0;
    nPoppedBadGuy = 0;
    nPoppedBadGuy2 = 0;
    nPoppedDuff = 0;
    difficultySpeedA += 4;
    difficultySpeedBG += 7;
    difficultySpeedBG2 += 4;
    curentLevelID++;
    curentLevel = levels.get(curentLevelID);


    agents.clear();
    badguys.clear();
    badguys2.clear();
    duffs.clear();
  } /*else if (curentLevelID == 4  && agentEaten > 5 && score > 0) {
   
   //permet de jouer une petite musique une fois quand la condition est validée
   if (gamewin == false) {
   gamewin = true;
   maintheme.stop();
   victory.play();
   gamewin = true;
   victory();
   }
   }*/

  DisplaySize();
  DisplayScore();
  ball.display();
  ball.move(mouseX, mouseY, sensitivity);
  ball.circleTail();


  for (int j = 0; j< badguys.size(); j++) {      // fonctions de deplacement
    Badguy b = badguys.get(j); 
    b.display();
    b.move();

    if (dist(ball.posCercleX-20, ball.posCercleY, b.xpos, b.ypos) < ellipseSize/2) {   //"manger" les entités et conséquences
      badguys.remove(j);
      score -= 2;
      ellipseSize -= 5;
      sensitivity += 0.004;
      homerbadguy.play();
    }
  }

  for (int i = 0; i< badguys2.size(); i++) {    // fonctions de deplacement
    Badguy2 c = badguys2.get(i); 
    c.display();
    c.move();

    if (dist(ball.posCercleX, ball.posCercleY, c.xpos, c.ypos) < ellipseSize+30) {    //"manger" les entités et conséquences
      badguys2.remove(i);
      score -= 5;
      ellipseSize -= 10;
      sensitivity += 0.008;
      homerbadguy2.play();
    }
  }

  for (int i = 0; i< agents.size(); i++) {     // fonctions de deplacement
    Agent a = agents.get(i); 
    a.display();
    a.move();

    if (dist(ball.posCercleX, ball.posCercleY, a.xpos, a.ypos) < ellipseSize/2) {    //"manger" les entités et conséquences
      agents.remove(i);
      score += 1;
      ellipseSize += 2;
      sensitivity -= 0.0008;
      homerburger.play();
      agentEaten += 1;
    }
  }
  for (int i = 0; i< duffs.size(); i++) {     // fonctions de deplacement
    Duff d = duffs.get(i); 
    d.display();
    d.move();


    if (dist(ball.posCercleX, ball.posCercleY, d.xpos, d.ypos) < ellipseSize/2) {    //"manger" les entités et conséquences
      duffs.remove(i);
      sensitivity += 0.008;
      ellipseSize -= 10;
      homerduff.play();
      score += 10;
    }
  }

  if (frameCount % curentLevel.agentRatePop == 0 && nPoppedAgent < curentLevel.agentNumber) {   // faire popper jusque à nombre cible
    for (int i = 0; i < 1; i++) {
      agents.add (new Agent(i));
      nPoppedAgent += 1;
    }
  }

  if (frameCount % curentLevel.badGuyRatePop == 0 && nPoppedBadGuy < curentLevel.badGuyNumber) {   // faire popper jusque à nombre cible
    for (int i = 0; i < 1; i++) {
      badguys.add(new Badguy(i));
      nPoppedBadGuy += 1;
    }
  }

  if (frameCount % curentLevel.badGuy2RatePop == 0 && nPoppedBadGuy2 < curentLevel.badGuy2Number) {   // faire popper jusque à nombre cible
    for (int i = 0; i < 1; i++) {
      badguys2.add(new Badguy2(i));
      nPoppedBadGuy2 += 1;
    }
  }

  if (frameCount % curentLevel.duffRatePop == 0 && nPoppedDuff < curentLevel.duffNumber) {   // faire popper jusque à nombre cible
    for (int i = 0; i < 1; i++) {
      duffs.add(new Duff(i));
      nPoppedDuff += 1;
    }
  }
  if (displayNiveauTimeTarget > millis()) {    // afficher le niveau
    displayNiveau();
  }

  if (score < 0 || ellipseSize < 80) {     //conditions de gameover
    gameOver();
    maintheme.stop();

    if (steplose==0) { 
      gamelose = true; 
      gameover.play();
    }
    steplose++;
  }
  if (curentLevelID == 4  && agentEaten > 30) {
    victory();
    maintheme.stop();
    agents.clear();            
    badguys.clear();
    badguys2.clear();
    duffs.clear();

    if (stepwin==0) {
      gamewin = true;
      victory.play();
    }
    stepwin++;
  }
  println(ellipseSize);
}
