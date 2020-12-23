//import de la Sound Library//

import processing.sound.*;

//déclaration des sons utilisés//

SoundFile backgroundMusic;
SoundFile goodCandy;
SoundFile badCandy;
SoundFile nextLevelSound;
SoundFile candyNeon;

//création ds ArrayLists d'items :

ArrayList<Agent> catchGuys = new ArrayList<Agent>(); // création d'une Array List d'agents (bonbons) à attraper
ArrayList<Agent> avoidGuys = new ArrayList<Agent>(); // création d'une Array List d'agents (araignées) à éviter
ArrayList<SpecialCandy> specialGuys = new ArrayList<SpecialCandy>(); //création de l'ArrayList des items spéciaux
ArrayList<Agent> newLife = new ArrayList<Agent>(); //création de l'ArrayList de vies bonus

ArrayList<Level> levels = new ArrayList<Level>(); // création de l'ArrayList des niveaux

Chara player; //création d'une instance de classe pour le joueur

Level currentLvl; //création de l'instance de classe des niveaux

//chargement des images//
PImage willo;
PImage candy;
PImage spider;
PImage neonCandy;
PImage forest;
PImage sadWillo;
PImage happyWillo;
PImage welcomeWillo;
PImage flame;

//chargement des polices d'écriture//

PFont sad;
PFont pixel;

//déclaration des variables//

int score; //score du joueur sur chaque niveau
int catchGuysCaught;
int specialCandyCaught;
int ncatchGuysNumber;
int navoidGuysNumber;
int nspecialCandy;
int nnewLife;
int currentLevel; //définition du niveau actuel à 0 : c'est l'écran d'accueil

//délcaration des variables booléennes vérifiant certains paramètres :
boolean opening;
boolean gameOver;
boolean victory;
boolean welcome;

void setup() {
  
//liens vers les images utilisées//
  willo = loadImage("Ghostie_neon.png");
  candy = loadImage("Candy_neon_2.png");
  spider = loadImage("yoggSothot.png");
  neonCandy = loadImage("Candy_neon.png");
  forest = loadImage("forest.jpg");
  sadWillo = loadImage("sadWillo.png");
  happyWillo = loadImage("happywillo.png");
  welcomeWillo = loadImage("welcomeWillo.png");
  flame = loadImage("flame.png");

//liens vers les polices
  pixel = createFont("Luna.ttf", 32);
  sad = createFont("Mathlete-Bulky.otf", 40);

//liens et utilisations des fichiers sonores :
  backgroundMusic = new SoundFile(this, "underclocked.mp3");
  backgroundMusic.loop();

  goodCandy = new SoundFile(this, "goodCandy.mp3");
  badCandy = new SoundFile(this, "badCandy.mp3");

  nextLevelSound = new SoundFile(this, "nextLevelSound.mp3");
  candyNeon = new SoundFile(this, "Candy_neon.mp3");
 
  size (800, 600);//création d'une fenêtre de taille 800x600 px
  
  image(forest, 0, 0); //réglage du fond

//on initie les variables de nombre d'items attrapés et chargés à zéro :
  catchGuysCaught = 0; //aucun item attrapé
  ncatchGuysNumber = 0; //aucun item à attraper chargé
  navoidGuysNumber = 0; //aucun item à éviter chargé
  score = 0; //score nul

  gameOver = false; //on définit que le joueur n'a, pour l'instant, ni gagné ni perdu
  victory = false;
  opening = false;
  
  welcome = true; //pour l'instant, on décide d'afficher l'écran de bienvenue

  player = new Chara(width/2, height/2); //on appelle l'avatar du joueur

//ccréation des niveaux : 

  levels.add(new Level(7, 60, 25, 52, 3, 0, 0)); //création du premier niveau - currentLevel = 0
  //pour ce niveau : 7 sprites à attraper / apparition toutes les 60 frames / 25 sprites à éviter / apparition toutes le 52 frames 
  // 3 dégats par sprite ennemi touché/ 0 item spécial à récupérer/0 vie supplémentaire

  levels.add(new Level(12, 65, 32, 50, 3, 1, 0)); //currentLevel = 1
  levels.add(new Level(20, 70, 37, 47, 3, 2, 1)); //currentLevel = 2
  levels.add(new Level(27, 75, 40, 46, 4, 3, 2)); //currentLevel = 3
  levels.add(new Level(35, 80, 43, 45, 5, 3, 2)); //currentLevel = 4

  currentLevel = 0; //la variable de passage de niveau est déclarée de sorte à ce que l'ArrayList appelle le premier niveau
  currentLvl = levels.get(currentLevel); //on appelle le niveau correspondant à la valeur du niveau donné

  //chargement de l'espace de jeu vide

  catchGuys.clear();
  avoidGuys.clear();
  specialGuys.clear();
  newLife.clear();
}

void draw() {
  
//écran d'accueil :
  if (opening == false && welcome == true) {

    welcomeWindow();
    currentLevel = 0;
    currentLvl = levels.get(currentLevel);
  } else {

    //le joueur a appuyé sur S : le jeu démarre au niveau 1
    fill(255, 5);
    background(forest);
    
    player.displayChara(); //affichage de l'avatar
    player.moveChara(mouseX, mouseY); // mouvement de l'avatar suivant la souris

    catchGuysPop(); //fonction d'appel des items à attraper

    avoidGuysPop(); //fonction d'appel des items à éviter

    specialGuysPop(); //fonction d'appel des items spéciaux
    
    newLifePop(); //fonction d'appel des vies supplémentaires

    catchingCatchGuys(); //fonction gérant l'interaction avec les items à attraper

    catchingAvoidGuys(); //fonction gérant l'interaction avec les items à éviter

    catchingSpecialGuys(); //fonction gérant l'interaction avec les items spéciaux
    
    catchingNewLife(); //fonction gérant l'interaction avec les vies bonus
    
  if(catchGuysCaught == currentLvl.catchGuysNumber && victory == false){ //si on a attrape le nombre d'items demandé et que le niveau maximum n'est pas atteint, on passe au niveau suivant
    
    nextLevel();
  }

    displayScreen(); //affichage du score, des vies, du niveau, des items spéciaux atttrapés, ...

    endGame(); //fonction actionnée en cas de défaite

    victoryGame(); //fonction actionnée en cas de victoire
  }
}
// fonction de diffusion du score, des vies, et du numéro du niveau en cours //
void displayScreen() { 

  //texte à afficher en permanence : 

  fill(255);
  textSize(20);

  textFont(pixel, 18);
  
  textAlign(LEFT);
  text("Score : " + score, 20, 30);

  text("Level : " + currentLevel, 20, 60);

  text("Lives : " + currentLvl.lives, 20, 90);

  text("Candy : " + catchGuysCaught + " / " + currentLvl.catchGuysNumber, 20, 120);

  text("Neon Candy : " + specialCandyCaught + " / " + currentLvl.specialItems, 540, 30);
}

//fonction faisant apparaître les sprites à attraper//
void catchGuysPop() { 
  if (frameCount % currentLvl.catchGuysRatePop == 0 && ncatchGuysNumber < currentLvl.catchGuysNumber) {
    for (int i = 0; i<1; i++) {

      catchGuys.add(new Agent(candy, width/2, height/2, 30, 30, 1)); //on ajoute un nouvel agent à attraper
      ncatchGuysNumber += 1; //icrémentation de la variable du nombre d'items apparus
    }
  }
}

//fonction faisant apparaître les sprites à éviter//
void avoidGuysPop() { 

  if (frameCount %  currentLvl.avoidGuysRatePop == 0 && navoidGuysNumber < currentLvl.avoidGuysNumber) { 
    for (int i = 0; i<1; i++) {

      avoidGuys.add(new Agent(spider, width/2, height/2, 45, 45, 1));// on ajoute un nouvel agent à éviter
      navoidGuysNumber += 1; //incrémentation de la variable du nombr d'items à éviter apparus
    }
  }
}

void specialGuysPop() {
  if (frameCount % 300 == 0  && currentLvl.specialItems != 0 && nspecialCandy< currentLvl.specialItems) {
    for (int i = 0; i<1; i++) {

      specialGuys.add(new SpecialCandy(random(width), random(height))); //on ajoute un nouvel agent à attraper
      nspecialCandy += 1; //incrémentation du nombre d'items spéciaux apparus
    }
  }
}

void newLifePop() {
  if (frameCount % 400 == 0  && currentLvl.lifeBonus != 0 && nnewLife< currentLvl.lifeBonus) {
    for (int i = 0; i<1; i++) {

      newLife.add(new Agent(flame, random(width), random(height), 40, 40, 1)); //on ajoute un nouvel agent à attraper
      nnewLife += 1; //incrémentation du nombre de vies apparues
    }
  }
}

//fonction attrapant les sprites valides//
void catchingCatchGuys() {

  for (int i = 0; i< catchGuys.size(); i++) { //attraper les balles blanches

    Agent catchMe = catchGuys.get(i); //sort les agents du tableau un par un
    catchMe.display(); //affiche les agents
    catchMe.move(); //fait évoluer les agents sur la map

    if (dist(player.posCercleX, player.posCercleY, catchMe.xpos, catchMe.ypos) < 40) {
      catchGuys.remove(i); //le joueur mange l'unité, elle disparaît
      catchGuysCaught += 1; //on note que le joueur a attrapé 1 nouvel item
      score += 5; 
      goodCandy.play(); //musique d'item attrapé
    }
  }
}

//fonction attrapant les sprites à éviter//
void catchingAvoidGuys() {
  for (int i = 0; i< avoidGuys.size(); i++) { //attraper les balles rouges

    Agent avoidMe = avoidGuys.get(i); //sort les agents du tableau un par un
    avoidMe.display(); //affiche les items à éviter
    avoidMe.move(); //fait évoluer ces items sur la map

    if (dist(player.posCercleX, player.posCercleY, avoidMe.xpos, avoidMe.ypos) < 40) {
      avoidGuys.remove(i); //le joueur mange l'unité, elle disparaît
      score -= currentLvl.damage; //le joueur perd le nombre de points que lui cause le dommage des ennemis au niveau actuel
      currentLvl.lives -= 1; //le joueur perd une vie dans ce niveau
      badCandy.play(); //musique de mauvais item attrapé
    }
  }
}

void catchingSpecialGuys() {
  for (int i = 0; i< specialGuys.size(); i++) { //attraper les balles blanches

    SpecialCandy catchMeQuick = specialGuys.get(i); //sort les agents du tableau un par un
    catchMeQuick.displayCandy(); //affiche les items spéciaux
    catchMeQuick.moveCandy(); //fait évoluer les items spéciaux sur la map
    if (catchMeQuick.candyX > width) {
      specialGuys.remove(i); //fait disparaîte l'agent
    }

    if (dist(player.posCercleX, player.posCercleY, catchMeQuick.candyX, catchMeQuick.candyY) < 20) {
      specialGuys.remove(i); //le joueur mange l'unité, elle disparaît
      specialCandyCaught += 1; //incrémentation de la variable des items spéciaux attrapés
      score += 20; //bonus de score
      candyNeon.play();//musique d'item spécial attrapé
    }
  }
}

//fonction permettant d'attraper une vie bonus
void catchingNewLife() {

  for (int i = 0; i< newLife.size(); i++) { //attraper les balles blanches

    Agent lifeBonus = newLife.get(i); //sort les agents du tableau un par un
    lifeBonus.display(); //affichage de la vie bonus
    lifeBonus.move(); //déplace la vie bonus sur la map

    if (dist(player.posCercleX, player.posCercleY, lifeBonus.xpos, lifeBonus.ypos) < 40) {
      newLife.remove(i); //le joueur mange l'unité, elle disparaît
      currentLvl.lives += 1; //le joueur gagne une vie
      candyNeon.play(); //musique d'item spécial attrapé
    }
  }
}

//fonction de passage de niveau//
void nextLevel() {
   currentLevel++; //on incrémente la variabel de niveau
  if(currentLevel < levels.size()) { //on vérifie que le joueur n'a pas atteint le dernier niveau

    nextLevelSound.play(); //son de passage de niveau

    currentLvl.lives = 3; //on rétablit le nombre de vies à 3

    //on enlève tous les sprites précédents :
    catchGuys.clear(); 
    avoidGuys.clear();
    specialGuys.clear();
    
    //le nombre d'itesm attrapés revient à zéro
    catchGuysCaught = 0;
    specialCandyCaught = 0;

    //les variables d'items apparus retombent à zéro :

    navoidGuysNumber = 0;

    ncatchGuysNumber = 0;

    nspecialCandy = 0;
    
    //on passe au niveau suivant :

    currentLvl = levels.get(currentLevel); //génération du niveau suivant

  }else{ //si le joueur est arrivé au bout du niveau final :
          victory = true;
  }
  
}

//fonction de fin de jeu en cas de défaite par dépassement du temps imparti//
void endGame() {
  if (currentLvl.lives == 0) { //le joueur a perdu toutes ses vies

    if (gameOver == false) {
      gameOver  = true; //affirme que le joueur a perdu
    }
    gameOverScreen(); //écran de défaite
    //on enlève tous les sprites précédents:
    catchGuys.clear(); 
    avoidGuys.clear();
    specialGuys.clear();
    
    //on retourne au menu principal :
    opening = false;
    welcome = false;
  }
}

//fonction d'écran de game over si le joueur n' pas attrapé tous le sitems à temps ou a perdu toutes ses vies//
void gameOverScreen() { 

  if (gameOver == true) {

    fill(0);
    noStroke();
    rect(0, 0, width, height);

    imageMode(CENTER);
    image(sadWillo, width/2, height/2, 400, 400);
    textAlign(CENTER);
    textFont(sad);
    fill(255);
    textSize(32);
    text("Your score : "+ score, width/2, 500);
    text("Press A to restart", width/2, 550);
  }
}

//fonction de victoire en cas de passage des trois niveaux//
void victoryGame() {

  if (catchGuysCaught == currentLvl.catchGuysNumber && currentLevel == levels.size()) {
    if (victory == false) {
      victory = true;
    }
    
    //écran de victoire :
    victoryScreen();
    
    //on enlève tous les sprites précédents :
    catchGuys.clear(); 
    avoidGuys.clear();
    specialGuys.clear();
    
    //retour à l'écran d'accueil :
    opening = false;
    welcome = false;
  }
}

//fonction d'écran de victoire si le joueur a passé les 3 niveaux//
void victoryScreen() {
  if (victory == true) {

    fill(255);
    noStroke();
    rect(0, 0, width, height);

    imageMode(CENTER);
    image(happyWillo, width/2, height/2, 800, 600);

    textAlign(CENTER);
    textFont(pixel);
    fill(0);
    textSize(29);

    text("Your score : "+ score, width/2, 520);
    text("Press A to try again", width/2, 570);
  }
}

//fonction rétablissant le nombre de vies //
void resetLife(int i) {
  if (gameOver == true || victory == true) {

    currentLvl.lives = i;
  }
}

void keyTyped() {
  //fonction de reset du jeu après une victoire ou une défaite par pression de la touche A
  if (key == 'a') { 
    if (gameOver == true||victory == true) {
      welcome = true;
      opening = false; //on rappelle l'écran d'accueil

      resetLife(3); //rétablit le nombre de vies à 3
      score = 0; //score nul
      currentLevel = 0; //niveau remis à zéro

    //on rétablit le nombre d'items attrapés à zéro :
      catchGuysCaught = 0;
      specialCandyCaught = 0;

    //on rétablit le nombre d'items apparus à zéro :
      ncatchGuysNumber = 0;
      navoidGuysNumber = 0;
      nspecialCandy = 0;
    }
  } else {
    //fonction de démarrage du jeu par pression de la touche S
    if (key =='s') {
      background(forest);
      opening = true;
      currentLevel = 0;
      resetLife(3); //nombre de vies établi à 3
    }
  }
}

void welcomeWindow() {

  background(forest);
  
  imageMode(CENTER);
  image(welcomeWillo, width/2, height/2, 450, 325);
  textAlign(CENTER);
  fill(255);
  textFont(pixel, 45);
  text("Welcome !", width/2, 100);
  textFont(pixel, 32);
  text("Press S to start", width/2, 550);
}
