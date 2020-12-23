int score = 0;
int steplose = 0;
int stepwin = 0;

void DisplayScore() {            // fonction de score
  fill(255);
  textSize(32);
  text("score : "+score, width/2, 50);
}

void DisplaySize() {            // fonction de score
  fill(255);
  textSize(32);
  text("taille : "+(ellipseSize - 80), width/2, 80);
}

void gameOver() {          //fonction d'echec

  background(loseimage);
  fill(255);
  textSize(40);
  text("GAME OVER", width/2+400, height/2);
  textAlign(CENTER);
  text("Click to restart", width/2+400, (height/2 + 80));
  textAlign(CENTER);
  
}

void victory() {          //fonction de réussite
  background(winimage);
  fill(0);
  textSize(40);
  text("YOU WIN", width/2, height/2-100);
  textAlign(CENTER);
  text("Your score : "+score, width/2, height/2);
  textAlign(CENTER);
  text("Restart ?", width/2, height/2+100);
  textAlign(CENTER);
}

void displayNiveau(){        //fonction d'affichage du niveau
  
  textSize(50);
  text("NIVEAU "+curentLevelID, width/2,height/2);
  fill(255);
  textAlign(CENTER);
  //rect(0,300,width,400);
  //fill(126,50);
  
}

void mouseClicked() {   //fonction de reset de la partie
  badguys.clear();
  agents.clear();
  ellipseSize = 25;
  score = 0;
  curentLevelID = 0;
  steplose = 0;
  stepwin = 0;
  levels.clear();
 
  setup();
}
