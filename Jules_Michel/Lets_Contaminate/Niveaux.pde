// Création de la classe des niveaux

class Level {
  
  // Les Variables

  public int agentNumber;
  public int agentRatePop;
  public int vilainNumber;
  public int vilainRatePop;
  public int agentEaten;
  public int gelNumber;
  public int gelRatePop;
  
  // Définition des paramètres d'un niveau

  public Level(int agentNumber, int agentRatePop, int vilainNumber, int vilainRatePop, int agentEaten, int gelNumber, int gelRatePop) {

    // Utilisation de ces paramètres
    
    this.agentNumber = agentNumber;
    this.agentRatePop = agentRatePop;
    this.vilainNumber = vilainNumber;
    this.vilainRatePop = vilainRatePop;
    this.agentEaten = agentEaten;
    this.gelNumber = gelNumber;
    this.gelRatePop = gelRatePop;
  }
}
