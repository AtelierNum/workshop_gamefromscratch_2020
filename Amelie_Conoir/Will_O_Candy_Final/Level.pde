class Level { //classe de définition des niveaux

//les paramètres évoluants sont les suivants :
  
  public int catchGuysNumber; //nombre de sprites à attraper
  public int catchGuysRatePop; //cadence d'apparition des sprites à attraper
  public int avoidGuysNumber; //nombre de sprites  à éviter
  public int avoidGuysRatePop; //cadence d'apparition des sprites à éviter
  public int damage; //dommages effectués par les sprites à éviter
  public int specialItems; //nombre d'items spéciaux à récupérer
  public int lives = 3; //nombre de ssprite à éviter attrapés
  public int lifeBonus;

  public Level(int catchGuysNumber, int catchGuysRatePop, int avoidGuysNumber, int avoidGuysRatePop, int damage, int specialItems, int lifeBonus){

    this.catchGuysNumber = catchGuysNumber;
    this.catchGuysRatePop = catchGuysRatePop;
    this.avoidGuysNumber = avoidGuysNumber;
    this.avoidGuysRatePop = avoidGuysRatePop;
    this.damage = damage;
    this.specialItems = specialItems;
    this.lifeBonus = lifeBonus;
    /*this.getBigItems = getBigItems;
    this.getSmallItems = getSmallItems;*/
    
  }
  
}
