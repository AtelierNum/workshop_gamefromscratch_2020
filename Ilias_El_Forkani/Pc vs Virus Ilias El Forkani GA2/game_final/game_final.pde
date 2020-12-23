//les variables
//quand les virus sont trop rapides pour vous hesitez pas a ne pas tirez mais a les intercepter avec l'antivirus just en bougeant le pc (comment dans le gif)
float canonX = 450;    
float cartoucheY = 620;   
float cartoucheX = 355;
float virusX = 350;
float virusY = 0;
float circlX = 450;
float circlY = 0;
float gamestate = 0;
boolean moveDown = true;
boolean moveUp = false;
boolean cartouche = true;
int countA = 0;
int countY = 0;
int countH = 3;
PFont font;
PImage varus;
PImage pc;
PImage antivirus;
PImage windows;
PImage first;
PImage montagne;



import ddf.minim.*;     // bandes sonores
Minim minim;
AudioPlayer impact;
AudioPlayer music;
AudioPlayer infect;
AudioPlayer lose;
AudioPlayer won;
AudioPlayer voe;

void setup() { 
  size(900, 1000);                                   //taille de l'ecran
  varus = loadImage("varus.png");                    //images
  pc = loadImage("pc.png");
  antivirus = loadImage("antivirus.png");
  windows = loadImage("windows.jpg");
  first = loadImage("first.jpg");
  montagne = loadImage("montagne.png");
  minim = new Minim(this);                          //commande son
  impact = minim.loadFile("tir.wav");               //titre du son
  music = minim.loadFile("metal.mp3"); 
  infect = minim.loadFile("infect.wav");
  lose = minim.loadFile("lose.mp3");
  won = minim.loadFile("winn.mp3");
  voe = minim.loadFile("voe.wav");
}
void draw() {
  if (gamestate == 0) {                            
    startscreen();
  } else if (gamestate == 1) {
    gamescreen();
  } else if (gamestate == 2) {
    gameover();
  } else if (gamestate ==3) {
    gamewin();
  }
}
void startscreen() {                 //l'ecran de début
  background(first);
  fill(0, 0, 255);
  textSize(70);
  text("Clique pour", 250, 480);
  text("sauver ton pc", 200, 550);
  if (mousePressed) {                //si on clique sur la souris gamestate 1 s'enclenche
    gamestate = 1;
  }
}
void gamescreen() {                 // l'écran au millieu du jeu
  music.play();
  background (windows); 
  textSize(20);
  fill(204, 102, 0);
  text("VIE", 40, 110);

  text(countH, 100, 110);         //le compteur des vies


  image(varus, virusX, virusY, 84, 84);
  textSize(20); 
  fill(0, 255, 0);                            
  text("VIRUS", 40, 50);                          
  text (countA, 100, 50);          //le score des virus (ennemie) 

  image (pc, canonX, 600, 150, 150);
  fill(0, 0, 255);                     
  text("VIRUS DETRUIT", 40, 80);
  text(countY, 200, 80);           //score du joueur (virus détruit)
  cartoucheX = canonX + 9;

  image(antivirus, cartoucheX, cartoucheY, 50, 50);
  if (keyPressed == true && key == CODED && keyCode == LEFT) {
    canonX = canonX - 9;                   //vitesse deplacement a gauche
  }
  if (keyPressed == true && key == CODED && keyCode == RIGHT) {
    canonX = canonX + 9;                  //vitesse deplacement a droite
  }
  if (moveDown == true) {
    circlY = circlY +3;                  //vitesse deplacement de vie
  }
  if (moveDown == true) { 
    virusY = virusY +2;                  //premier vitesse deplacement des virus
    if (countY > 10 ) {                   //si le score du joueur atteind 10 la vitesse de deplacement du virus augumente de 1
      virusY = virusY +3;
    }
    if (countY > 30 ) {                  //si le score du joueur atteind 30 la vitesse de deplacement du virus augumente de 1
      virusY = virusY +4;
    }
    if (countY >= 30 && countY < 34) {     
      fill(0);                     
      text("Continue comme ça", 200, 400);  //2 eme text pour montrer que le niveau auguemente encore 
    }

    if (countY >= 10 && countY < 15) {     //le text "bien joué" apparait au score 10 et dispparait au score 15
      fill(0);                     
      text("Bien joué", 200, 400);         //premier text pour monter que le niveau auguemente 
    }
    if (countY >= 20 && countY < 40) {       // les vies apparaissent a 20 de score et disparaissent a 40 de score
      fill(204, 102, 0);
      ellipse(circlX, circlY, 55, 55);
      if (cartoucheY < circlY + 50 && cartoucheY > circlY - 50 && cartoucheX < circlX + 50 && cartoucheX > circlX - 50) 
      {
        circlY = 0;
        circlX = random(30, 670);   //les vies apraissent randomly
        moveDown = true;  
        countH++;
        voe.play(10);
      }
    }



    if (countY > 45) {            //commande pour tourner a droite et a gauche le pc et ca vitesse de deplacement
      if (keyPressed == true && key == CODED && keyCode == LEFT) { 
        canonX = canonX - 11;
      }
      if (keyPressed == true && key == CODED && keyCode == RIGHT) {
        canonX = canonX + 11;
      }
      if (countY >= 45 && countY < 55) {     
      fill(0);                     
      text("encore !", 200, 400);
      }
    }
    if (countY > 75) {      //si le joueur atteind le score 75 (virus détruit) les virus augument leur vitesse de déplacement encore
      virusY = virusY +5;
    }
    if (countY >= 75 && countY < 84) {     
      fill(0);                     
      text("encore quelques virus !", 200, 400);  
    }
    if (countY > 97) {       // au score 94 la vitesse déplacement des virus augumentent de 1
      virusY = virusY +6;
    }
    if (countH <= 0) {     //si le score des vies est de 0 l'ecran de gamestate2 apparait
      gamestate = 2;
    }
    if (countY == 100) {  //si le score de virus détruit atteind 100 l'ecran de gamestate 3 apparait
      gamestate = 3;
    }
  }
  if (virusY <= 650) {
    moveDown = true;
  }
  if (virusY> 650) {
    virusY = 0;
    virusX = random(30, 670);
    moveDown = true;
    countA++;
    countH-= 1;
    infect.play(10);
  }
  if (circlY <= 650) {
    moveDown = true;
  }
  if (circlY> 650) {
    circlY = 0;
    circlX = random(32, 680);
    moveDown = true;
  }
  if (keyPressed && key == ' ')      //la touche espace permet d'envoyer l'antivirus
  {
    moveUp= true;
  }


  if (moveUp == true) {
    cartoucheY = cartoucheY - 10;      //vitesse deplacement de la cartouche au tout début
    if (countY> 20) {
      cartoucheY = cartoucheY - 13;     // la vitesse de deplacement de la cartouche augument quand le score est de 20
    }
  }
  if (cartoucheY < 10) { 
    cartoucheY = 650;
    moveUp = false;
  }  
  if (cartoucheY < virusY + 50 && cartoucheY > virusY - 50 && cartoucheX < virusX + 50 && cartoucheX > virusX - 50)
  {
    virusY = 0;
    virusX = random(30, 670);      // les virus apparaissent randomly 
    moveDown =true; 
    countY++;                      //si le virus n'a pas été touché par l'antivirus le score des virus (ennemie) augument de 1 
    impact.play(10);               //le son play s'enclenche a chaque fois qu'un virus ne touche pas l'antivirus
  }
}
void gameover() {    

  
  textSize(70);
  text("Infécté", 300, 480);
  lose.play();    //music de perdre commence
  music.pause();  // music du jeux s'arrete
}
void gamewin() {
  background(montagne);
  textSize(70);
  text("PC clean !", 250, 480);
  music.pause();   // music du jeux s'arrete
  won.play();      // music de gagne commence
}
