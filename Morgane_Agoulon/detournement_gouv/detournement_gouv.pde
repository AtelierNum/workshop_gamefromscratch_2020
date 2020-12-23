//détournement-de-fonds.gouv


//Importer les sons
import processing.sound.*;
SoundFile GameOver_bande_son;
SoundFile GameWin_bande_son;
SoundFile punchsound;
SoundFile coin;


//créer les Arraylistes, contiennent les éléments à dessiner
ArrayList<Agent> fondsPublics = new ArrayList<Agent>();
ArrayList<Enemy> fisc = new ArrayList<Enemy>();
ArrayList<Level> niveaux = new ArrayList<Level>();

//chargement des images
PImage balkany;
PImage fisci;
PImage fondsPublicsi;
PImage ecranGameOver;
PImage ecranGameWin;

Level currentLevel;
int currentLevelID;

//définition des valeurs booléenes 
boolean gameOver = false;
boolean gameWin = false;
boolean restart = false;
boolean lecture = false;

Player ball;


void setup() {

  GameWin_bande_son = new SoundFile(this, "GameWin_bande_son.mp3");
  GameOver_bande_son = new SoundFile(this, "GameOver_bande_son.mp3");
  punchsound = new SoundFile(this, "punchsound.mp3");
  coin = new SoundFile(this, "coin.mp3");

  //fullScreen();
  size(1200, 800);    
  //on appelle les images
  balkany = loadImage("balkany.png");
  fisci = loadImage("fisci.png");
  fondsPublicsi = loadImage("fondsPublicsi.png");
  ecranGameOver = loadImage("ecranGameOver.png");
  ecranGameWin = loadImage("ecranGameWin.png");


  background(255);

  //on appelle l'item joueur
  ball = new Player(color(20, 255, 150), width/2, height/2);

  //création niveaux 
  niveaux.add(new Level(90, 15, 90, 30, 5));
  niveaux.add(new Level(90, 25, 90, 50, 6));
  niveaux.add(new Level(120, 35, 120, 120, 10));
  niveaux.add(new Level(0, 0, 0, 0, 0));
  currentLevelID = 0;
  currentLevel = niveaux.get(currentLevelID);

  //on remplit la scène
  for (int i = 0; i<35; i++) {

    fondsPublics.add(new Agent());
    fisc.add(new Enemy());
  }
}

void draw() {
  //on appelle les fonctions du joueur
  ball.displayPlayer();
  ball.movePlayer(mouseX, mouseY, 0.5);
  ball.circleTail();
  ball.displayScore();
  ball.displayLevel();

  println(ball.score, currentLevelID);

  //condition de passage de niveau 
  if (ball.score > 700) {

    nextLevel();
  }

  //condition de victoire 
  if (currentLevelID == 4) {
    gameIsWon();

    ecranGameWin.resize(1200, 800);
    background(ecranGameWin);
  }


  //condition de défaite
  if (ball.score < 0) {
    gameIsOver();

    ecranGameOver.resize(1200, 800);
    background(ecranGameOver);
  }

  if (frameCount % currentLevel.agentPop == 0) {
    //rajoute des agents
  }

  //définition de la hitbox
  for (int i = 0; i< fondsPublics.size(); i++) {

    Agent a = fondsPublics.get(i); 
    a.display();
    a.move();
    if (dist(ball.posCercleX, ball.posCercleY, a.xpos, a.ypos) < 80) {

      fondsPublics.remove(i);
      coin.play(); //effet sonore
      ball.score += 100;
    }
  }
  for (int o = 0; o< fisc.size(); o++) {

    Enemy e = fisc.get(o); 
    e.display();
    e.move();
    if (dist(ball.posCercleX, ball.posCercleY, e.xposO, e.yposO) < 20) {

      fisc.remove(o);
      punchsound.play();
      ball.score -= 150;
    }
  }
}

//passer au niveau suppérieur
void nextLevel() {

  // currentLevel = niveaux.get(currentLevelID);
  currentLevelID += 1;
  ball.score = 0;

  if (currentLevelID < niveaux.size()-1) {

    currentLevel = niveaux.get(currentLevelID);
    //paramètres des items en fonction des niveaux
    for (int i = 0; i< fondsPublics.size(); i++) {
      Agent a = fondsPublics.get(i);
      a.speed = currentLevel.speed;
    }
    for (int o = 0; o< fisc.size(); o++) {

      Enemy e = fisc.get(o); 
      e.speed = currentLevel.speed;
    }
  }
}
//fonction de défaite
void gameIsOver() {
  if (gameOver == false) {

    gameOver = true;

    GameOver_bande_son.play(); //jouer le jingle de victoire 

    ecranGameOver.resize(1200, 800);
    background(ecranGameOver);

    println(); //débug

    //fill(255, 0, 0);
    fondsPublics.clear();
    fisc.clear();
  }
}
//fonction de victoire
void gameIsWon() {
  if (gameWin == false) {
    gameWin = true;

    GameWin_bande_son.play();//jouer le jingle de défaite

    //clear permet de supprimer tous les éléments après l'exécution d'une fonction particulière
    fondsPublics.clear();
    fisc.clear();
  }
}

//création de la classe joueur
class Player {
  //paramètres du player
  float posCercleX;
  float posCercleY;
  color cPlayer;
  int score = 0;

  Player(color tempcPlayer, float tempPosCercleX, float tempPosCercleY) {

    tempcPlayer = cPlayer;
    tempPosCercleX = posCercleX;
    tempPosCercleY = posCercleY;
  }
  void displayPlayer() { //créé le cercle qui suit la souris

    image(balkany, posCercleX, posCercleY, 80, 80);
  }

  void movePlayer(float posSourisX, float posSourisY, float sensitivity) {

    posCercleX = lerp(posSourisX, posCercleX, 0.5);
    posCercleY = lerp(posSourisY, posCercleY, 0.5);
  }

  void circleTail() { //affiche la trainée qui suit le mouvement du Player
    fill(255, 40);
    noStroke();
    rect(0, 0, width, height);
  }

  void displayScore() { //pour afficher le score
    fill(0);
    textSize(25);
    text("Argent : " + score, width/9, 90);
  }

  void displayLevel() {
    fill(0);
    textSize(35);
    text("Difficulté : " + currentLevelID, width/9, 120);
  }
}

//définition des classes item (agent & enemy)
class Agent {
  //définir 
  float xpos;
  float ypos;
  float incr;
  float speed;


  Agent() { //pour appeler la fonction 

    this.xpos = random(width);
    this.ypos = random(height);
    this.incr = 0;
    this.speed = 5;
  }

  void display() {

    image(fondsPublicsi, this.xpos, this.ypos, 30, 30);

    //noStroke();
    //fill(150, 0, 150);
    //ellipse(this.xpos, this.ypos, 20, 20);
  }
  void move() {
    //définit le mouvement 
    incr = incr + speed;

    xpos = xpos + (noise(incr, ypos)-0.6)*  this.speed; //noise avec valeur incrémentée
    ypos = ypos + (noise(incr, xpos)-0.6)*  this.speed;

    if (xpos > width) { //maintient les agents dans la fenêtre 
      xpos = 0;
    } else if (xpos < 0) {
      xpos = width;
    }

    if (ypos > height) {
      ypos = 0;
    } else if (ypos < 0) {
      ypos = height;
    }
  }
}

class Enemy {
  float xposO;
  float yposO;
  float incrO;
  float speed;


  Enemy() {

    this.xposO = random(width);
    this.yposO = random(height);
    this.incrO = 0;
    this.speed = 3;
  }

  void display() {

    image(fisci, this.xposO, this.yposO, 30, 30);

    //noStroke();
    //fill(255, 138, 0);
    //ellipse(this.xposO, this.yposO, 20, 20);
  }
  void move() {


    incrO = incrO + speed;

    xposO = xposO + (noise(incrO, yposO)-0.8)*  this.speed; 
    yposO = yposO + (noise(incrO, xposO)-0.8)*  this.speed;

    if (xposO > width) {
      xposO = 0;
    } else if (xposO < 0) {
      xposO = width;
    }

    if (yposO > height) {
      yposO = 0;
    } else if (yposO < 0) {
      yposO = height;
    }
  }
}

//création de la classe niveaux
class Level {

  int agentNb;
  int enemyNb;
  int agentPop;
  int enemyPop;
  float speed;


  Level(int agentNb, int enemyNb, int agentPop, int enemyPop, float speed) {

    this.agentNb = agentNb;    
    this.enemyNb = enemyNb;
    this.agentPop = agentPop;
    this.enemyPop = enemyPop;
    this.speed = speed;
  }
}
