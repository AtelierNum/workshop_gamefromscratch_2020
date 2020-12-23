class SpecialCandy{
  
  float candyX;
  float candyY; 
  
  SpecialCandy(float candyX, float candyY){
    
    this.candyX = candyX;
    this.candyY = candyY;
  }
  
  void displayCandy(){
    
    image(neonCandy, candyX, candyY, 20, 20);
  }
  
  void moveCandy(){
    
    candyX = candyX + 5;
  }
}
