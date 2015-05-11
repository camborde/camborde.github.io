//On déclare les objets et variables dont on aura besoin plus tard
/* @pjs preload="bg.png, perso.png, mauvais.png, bon.png, perdu.png, coeur1.png, coeur2.png, coeur3.png"; */
PImage bg; 
PImage perso;
PImage mauvais;
PImage bon;
PImage perdu;
PImage coeur1;
PImage coeur2;
PImage coeur3;
int vie;
int rand;
int type;
int score;
int partie = 1;
gateau gato  = new gateau();
legume legumo  = new legume();


// Classe légume (qui s'occupera de gérer les carottes et radis)
class legume {
  int x, y;
  void creer(){
   float de = random(1,3);
   int de2 = int(de);
   if(de2==1){mauvais = loadImage("carotte.png");} 
   else if(de2==2){mauvais = loadImage("radis.png");} 
   y = 0;
   x = int(random(0, 750));
  }
  void afficher(){
    image(mauvais, x, y);
  }
  void bouger(){
    y=y+10; 
  }
}

// Classe gâteau (qui s'occupera de gérer les beignets et les tartes)
  class gateau {
  int x, y;
  void creer(){
   float de = random(1,3);
   int de2 = int(de);
   if(de2==1){bon = loadImage("donut.png");} 
   else if(de2==2){bon = loadImage("tarte.png");} 
   y = 0;
   x = int(random(0, 750));
  }
  void afficher(){
    image(bon, x, y);
  }
  void bouger(){
    y=y+10;
  }
} 

// Initialisation du jeu 
void setup(){
   size(800,600);
   bg = loadImage("mordor.png"); // On charge les images du jeu
   perso = loadImage("pouet.png");
   perdu = loadImage("perdu.png");
   coeur3 = loadImage("coeur3.png");
   coeur2 = loadImage("coeur2.png");
   coeur1 = loadImage("coeur1.png");
   legumo.creer();
   gato.creer();
   type = 1;
   score = 0;
   frameRate(60);
   textSize(30);
   vie = 3;
}

// Boucle principale du jeu, elle tourne 60 fois par seconde
void draw() {
  if(mousePressed==true){partie = 1;}
  if(partie==1){
  // On affiche tout les objets à l'écran (sauf le gâteau / le légume)
  noCursor();
  background(bg);
  image(perso, mouseX, 600-81);
  text(score, 20, 40);
  if(vie==3){image(coeur3, 700, 20);}
  if(vie==2){image(coeur2, 700, 20);}
  if(vie==1){image(coeur1, 700, 20);}
  
  if(type==1){ // Si l'objet présent sur l'écran est un gâteau, on le fait bouger et on l'affiche
  gato.bouger();
  gato.afficher();
  legumo.x = 0;
  }
  if(type==2){ // Pareil si c'est un légume
  legumo.bouger();
  legumo.afficher();
  gato.x = 0;
  }
  
  // Si un objet touche le personnage 
  if(gato.y>=520 && gato.y <= 550 || legumo.y>=520 && legumo.y <= 550){
    
    if(gato.x >= mouseX-20 && gato.x <= mouseX + 71 || legumo.x >= mouseX-20 && legumo.x <= mouseX + 71){
      
      if(type==2 && vie != 1){vie--;}
      else if(type==2 && vie == 1){
        
        background(perdu);
        score = -1;
        vie = 3;
        partie = 0;
        
      } 
      
      rand = int(random(1,3));
      if(rand==1){
      gato.creer();
      legumo.creer();
      type=1;}
      else if(rand == 2){
      gato.creer();
      legumo.creer();
      type=2;}
      score++; // On augmente le score
  } 
  
  // Si un objet touche le sol
   } else if(gato.y >= 600 || legumo.y >= 600){
      rand = int(random(1,3));
      if(rand==1){
      gato.creer();
      legumo.creer();
      type=1;}
      else if(rand == 2){
      gato.creer();
      legumo.creer();
      type=2;}
}}}
