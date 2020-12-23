int curentLevelID = 0;    //déclarations des paramètres
int agentsNumber;
int agentRatePop;
int badGuyNumber;
int badGuyRatePop;
int badGuy2Number;
int badGuy2RatePop;
int duffNumber;
int duffRatePop;

int agentEaten;
int nPoppedAgent = 0;
int nPoppedBadGuy = 0;
int nPoppedBadGuy2 = 0;
int nPoppedDuff = 0;


class Level {


  public int agentNumber;
  public int agentRatePop;
  public int badGuyNumber;
  public int badGuyRatePop;
  public int badGuy2Number;
  public int badGuy2RatePop;
  public int duffNumber;
  public int duffRatePop;
  public int agentEaten;
  public PImage backgroundimage;


  // définition de l'ordre des paramètres pour chaque niveau
  public Level(int agentNumber, int agentRatePop, int duffNumber, int duffRatePop, int badGuyNumber, int badGuyRatePop, int badGuy2Number, int badGuy2RatePop, int agentEaten, PImage backgroundimage) {

    this.agentNumber = agentNumber;        //attribution
    this.agentRatePop = agentRatePop;
    this.badGuyNumber = badGuyNumber;
    this.badGuyRatePop = badGuyRatePop;
    this.badGuy2Number = badGuy2Number;
    this.badGuy2RatePop = badGuy2RatePop;
    this.agentEaten = agentEaten;
    this.duffNumber = duffNumber;
    this.duffRatePop = duffRatePop;
    this.backgroundimage = backgroundimage;
  }
}
