class Level{
  float heroLag;//contrôle du délai de mouvement entre la souris et le mouvement de la bulle
  int nbBulleAdd;//contrôle du nombre de spawn de balle après chaque suppression
  
  Level(float lag, int bulleRespawn){
    heroLag = lag;
    nbBulleAdd = bulleRespawn;
  }
  
}
