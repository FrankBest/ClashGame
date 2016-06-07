ArrayList <Bullet> bullets = new ArrayList <Bullet>();
ArrayList <Soldier> soldiers = new ArrayList <Soldier>();
int  radius,temp;
float  health,attack,speed, range;
int identity;
int removed;
boolean bossSummoned;
Boss BOSS;


void setup(){
  size(800,600);
  health = 30;
  attack = 1;
  radius = 10;
  speed = 2;
  range = 150;
  //temp = 0;
  identity = 0;
  removed = 0;
  bossSummoned = false;
}

void draw(){
  boolean together = true;
  int togethertemp;
  background(192);
  //if (!bossSummoned){
  //  BOSS = new Boss(width/2,height/2,4);
  //  bossSummoned = true;
  //}
  //BOSS.summon();
  //BOSS.show();
  if (soldiers.size() > 0){
    togethertemp = soldiers.get(0).camp;
    for ( int i = 1; i < soldiers.size(); i++){
      if((together)&&(soldiers.get(i).camp != togethertemp)) together = false;
    }
  }
  else together = true;
  for(int i = 0; i < soldiers.size(); i++){
    if(!together){
      //int target = (int)random(soldiers.size());
      //while(soldiers.get(i).camp == soldiers.get(target).camp) target = (int)random(soldiers.size());
      //soldiers.get(i).attack(soldiers.get(target));
      int target = 0;
      int target2 = 0;
      float distancetemp = 1000;
      for ( int j = 0; j < soldiers.size(); j++){
        if((soldiers.get(i).camp != soldiers.get(j).camp)&&( soldiers.get(i).distance(soldiers.get(j))<distancetemp) ){
          target = j;
          target2 = j;
          distancetemp = soldiers.get(i).distance(soldiers.get(j));
        }
      }
      float distancetemp2 = distancetemp;
      for ( int j = 0; j < soldiers.size(); j++){
        if((soldiers.get(i).camp == soldiers.get(j).camp)&&(i!=j)&&( soldiers.get(i).distance(soldiers.get(j))<distancetemp2) ){
          target2 = j;
          distancetemp2 = soldiers.get(i).distance(soldiers.get(j));
        }
      }
      //if (distancetemp > soldiers.get(i).range) soldiers.get(i).move(soldiers.get(target));
      //else soldiers.get(i).attack(soldiers.get(target));
      //if (!soldiers.get(i).withFriend){
        if (distancetemp >  soldiers.get(i).range) soldiers.get(i).moveTo(soldiers.get(target));
        else if (distancetemp2 < soldiers.get(i).range/3) soldiers.get(i).moveOpposite(soldiers.get(target2));
        else if (soldiers.get(i).movepattern == 1){
          if (distancetemp >  soldiers.get(i).range/2) soldiers.get(i).moveTo(soldiers.get(target));
        }
        else soldiers.get(i).moveAround(soldiers.get(target), soldiers.get(i).movepattern);
        
        //distancetemp = range / 3;
        //for ( int j = 0; j < soldiers.size(); j++){
        // if((soldiers.get(i).camp == soldiers.get(j).camp)&&( soldiers.get(i).distance(soldiers.get(j))<distancetemp) ){
        //   soldiers.get(i).friendid = j;
        //   soldiers.get(j).friendid = i;
        //   soldiers.get(i).withFriend = true;
        //   soldiers.get(j).withFriend = true;
        //   distancetemp = soldiers.get(i).distance(soldiers.get(j));
        // }
        //}
        
      //}
      //else {
      //  soldiers.get(i).movepattern = 2;
      //  soldiers.get(i).moveAround(soldiers.get(soldiers.get(i).friendid), soldiers.get(i).movepattern);
      //}
      
      if (distancetemp <= soldiers.get(i).range) soldiers.get(i).attack(soldiers.get(target));
    }
    for(int j = 0; j < bullets.size(); j++){
      soldiers.get(i).hurt(bullets.get(j));
    }
    soldiers.get(i).show();
  }
  //if (soldiers.size()>0)
  for(int i = soldiers.size()-1; i >= 0; i--){
    if (soldiers.get(i).hp <= 0) {
      println(soldiers.get(i).id + "removed");
      //for (int j = 0 ; j < soldiers.size(); j++){
      //  if ( soldiers.get(j).friendid > i) soldiers.get(j).friendid--;
      //  else if (soldiers.get(i).friendid == i ) soldiers.get(j).withFriend = false;
      //}
      soldiers.remove(i);
      removed++;
    }
    else if (soldiers.get(i).isVisible(0,0,width,height)){
      if (soldiers.get(i).xpos < 0 ) soldiers.get(i).xpos = soldiers.get(i).xpos + width;
      else if (soldiers.get(i).xpos > width ) soldiers.get(i).xpos = soldiers.get(i).xpos - width;
      else if (soldiers.get(i).ypos < 0 ) soldiers.get(i).ypos = soldiers.get(i).ypos + height;
      else if (soldiers.get(i).ypos > height ) soldiers.get(i).ypos = soldiers.get(i).ypos - height;
            //println(soldiers.get(i).id + "removed");
            //soldiers.remove(i);
            //soldiers.get(i).xpos = random(width);
            //soldiers.get(i).ypos = random(height);
            //removed++;
    }
  }
  println("total " + removed +  " removed, created " + identity + ", " + soldiers.size() + " alive");
  
  for(int i = 0; i < bullets.size(); i++){
    if(bullets.get(i).exist){
      bullets.get(i).move();
      bullets.get(i).show();
    }
  }
  if (bullets.size()>0)
  for(int i = bullets.size()-1; i >= 0; i--){
    if (!bullets.get(i).exist) bullets.remove(i);
    else if ((bullets.get(i).xpos < 0) || (bullets.get(i).xpos > width)
          ||(bullets.get(i).ypos < 0) || (bullets.get(i).ypos > height)) bullets.remove(i);
  }
  
  if (together){
    //if (temp >= 100){
      for(int i = 0; i < 3; i++){
        for( int j = 1; j < 7; j++){

          soldiers.add(new Soldier(random(width), random(height), health, attack, speed, range, radius, j, (int)random(1,4)));
        }
      //soldiers.add(new Soldier(random(width), random(height), health, attack, speed, range, rad, 8));
      }
      //temp = 0;
    //}
    //else temp++;
  }
  
  //if(soldiers.size() <= 5;
  
  for (int i = 0; i < soldiers.size(); i++){
    textSize(10);
    fill(0);
    textAlign(LEFT);
    text(soldiers.get(i).id + "camp : " + soldiers.get(i).camp,0,30*i+10);
    text(soldiers.get(i).id + "x : " + (int)soldiers.get(i).xpos,0,30*i+20);
    text(soldiers.get(i).id + "y : " + (int)soldiers.get(i).ypos,0,30*i+30);
    text(frameRate, 100,10);   
  }
    
  
}

class Bullet{
  float spd = 8;//speed
  float xpos;//startx
  float ypos;//starty
  float dx;
  float dy;
  float angle;
  int camp;
  float damage;
  boolean exist;
  color col;
  
  public Bullet(float _xpos, float _ypos, float _dx, float _dy, int _camp, float _damage){
    xpos = _xpos;
    ypos = _ypos;
    dx = _dx;
    dy = _dy;
    camp = _camp;
    damage = _damage;
         if (camp == 1) col = color(0,0,0);
    else if (camp == 2) col = color(0,0,255);
    else if (camp == 3) col = color(0,255,0);
    else if (camp == 4) col = color(0,255,255);
    else if (camp == 5) col = color(255,0,0);
    else if (camp == 6) col = color(255,0,255);
    else if (camp == 7) col = color(255,255,0);
    //else if (camp == 8) col = color(255,255,255);
    exist = true;
    float deltax = dx - xpos;
    float deltay = dy - ypos;
    angle = atan2(deltay,deltax);  
}
  
  public void move(){
    //float deltax = dx - xpos;
    //float deltay = dy - ypos;
    //angle = atan2(deltay,deltax);
    xpos += spd*cos(angle);
    ypos += spd*sin(angle);
  }
  
  public void show(){
    strokeWeight(5);
    stroke(col);
    line(xpos-spd*cos(angle),ypos-spd*sin(angle),xpos+spd*cos(angle),ypos+spd*sin(angle));
  }
  
}

class Soldier{
  float xpos;
  float ypos;
  float maxhp;
  float hp;//health
  float atk;//attack
  float spd;//speed
  float range;
  int rad;//radius
  int camp;
  color col;
  int count;
  int time;
  int movepattern;
  int id;
  Soldier friend;
  int friendid;
  boolean withFriend;
  
  Soldier(){}
  
  Soldier(float _x, float _y, float _hp, float _atk, float _spd, float _range, int _rad, int _camp, int _movepattern){
    xpos = _x;
    ypos = _y;
    maxhp = _hp;
    hp = _hp;
    atk = _atk;
    spd = _spd;
    range = _range;
    rad = _rad;
    camp = _camp;
    count = 0;
    time = 10;
    friendid = -1;
    withFriend = false;
    id = identity++;
    println(identity + "spawned");
    movepattern = _movepattern;
    movepattern = 2;
    //1 for go straight
    //2 for go around clockwise
    //3 for go around anticlockwise
    
    if (camp == 1){
      col = color(0,0,0);
      //maxhp = maxhp*2;
      //hp = hp*2;
    }
    else if (camp == 2){
      col = color(0,0,255);
      //atk = atk*2;
    }
    else if (camp == 3){
      col = color(0,255,0);
      spd = 3*spd;
      //atk = atk*10;
      //movepattern = 2;
    }
    else if (camp == 4){
      col = color(0,255,255);
      //range = range*5;
    }
    else if (camp == 5){
      col = color(255,0,0);
      //rad = rad/5;
    }
    else if (camp == 6){
      col = color(255,0,255);
      //maxhp = maxhp*1.5;
      //hp = hp*1.5;
      //atk = atk*1.5;
    }
    else if (camp == 7){
      col = color(255,255,0);
      //range = range*2.5;
      //spd = spd*2.5;
    }
    //else if (camp == 8) col = color(255,255,255);
  }
  
  void attack(Soldier S){
    if (count >= time) {
      bullets.add(new Bullet(xpos, ypos, S.xpos+random(-S.rad*2,S.rad*2), S.ypos+random(-S.rad*2,S.rad*2), camp, atk));
      count = 0;
    }
    else count ++;
  }
  
  void hurt(Bullet bul){
    if( camp != bul.camp ){
      if ( (xpos - bul.xpos)*(xpos - bul.xpos) + (ypos - bul.ypos)*(ypos - bul.ypos) < (rad + bul.spd)*(rad + bul.spd) ){
        hp -= bul.damage;
        bul.exist = false;
      }
    }
  }
  
  void moveTo(Soldier S){
    float angle = atan2(S.ypos - ypos, S.xpos - xpos);
    xpos += spd * cos(angle);
    ypos += spd * sin(angle);
  }
  
  void moveOpposite(Soldier S){
    float angle = atan2(S.ypos - ypos, S.xpos - xpos);
    xpos -= spd * cos(angle);
    ypos -= spd * sin(angle);
  }
  
  void moveAround(Soldier S, int _movepattern){
    float angle = atan2(ypos - S.ypos, xpos - S.xpos);
    if (_movepattern == 2) angle += 2*spd/(3.14*distance(S));
    else if (_movepattern == 3) angle -= 2*spd/(3.14*distance(S));
    xpos = S.xpos + distance(S)*cos(angle);
    ypos = S.ypos + distance(S)*sin(angle);
  }
  
  float distance(Soldier S){
    return(sqrt( (xpos - S.xpos)*(xpos - S.xpos) + (ypos - S.ypos)*(ypos - S.ypos) ));
  }
  
  void show(){
    strokeWeight(1);
    stroke(col);
    fill(255);
    rect(xpos-15, ypos+20, 30, 8);
    fill(col);
    rect(xpos-15, ypos+20, 30*hp/maxhp, 8);
    ellipse(xpos,ypos,rad*2,rad*2);
    fill(255);
    textSize(30);
    textAlign(CENTER, CENTER);
    text(id,xpos,ypos-3);
  }
  
  boolean isVisible(int left, int top, int right, int bottom) {
    return (xpos - left) <= 0.0 || (right - xpos) <= 0.0 || (ypos - top) <= 0.0 || (bottom - ypos) <= 0.0;
  }
  
  
}

class Boss extends Soldier{
  int summontime;
  int summoncount;
  
  
  Boss(float _x, float _y, int _camp){
    xpos = _x;
    ypos = _y;
    maxhp = 1000;
    hp = 1000;
    camp = _camp;
    rad = 50;
    summontime = 10;
    summoncount = 0;
    
    if (camp == 1)       col = color(0,0,0);   
    else if (camp == 2)  col = color(0,0,255);   
    else if (camp == 3)  col = color(0,255,0);
    else if (camp == 4)  col = color(0,255,255);
    else if (camp == 5)  col = color(255,0,0);
    else if (camp == 6)  col = color(255,0,255);
    else if (camp == 7)  col = color(255,255,0);      
  }
  
  void summon(){
   if (summoncount > summontime){
     soldiers.add(new Soldier(xpos, ypos, health, attack, speed, range, radius, camp,(int)random(1,4))); 
     summoncount = 0;
   }
   else summoncount++;
  }
  
  void show(){
    strokeWeight(1);
    stroke(col);
    fill(255);
    rect(xpos-40, ypos+70, 80, 12);
    fill(col);
    rect(xpos-40, ypos+70, 80*hp/maxhp, 12);
    ellipse(xpos,ypos,rad*2,rad*2);
  }
}

void mousePressed(){
  //if(mouseButton == LEFT) soldiers.add(new Soldier(mouseX, mouseY, health, attack, speed, range, rad, 1));
  //else if(mouseButton == RIGHT) soldiers.add(new Soldier(mouseX, mouseY, health, attack, speed, range, rad, 2));
  //else if(mouseButton == CENTER) soldiers.add(new Soldier(mouseX, mouseY, health, attack, speed, range, rad, 3));
  if(mouseButton == LEFT)
  for(int i = 0; i < 2; i++){
    for( int j = 1; j < 7; j++){
    soldiers.add(new Soldier(random(width), random(height), health, attack, speed, range, radius, j,2));
    }
    //soldiers.add(new Soldier(random(width), random(height), health, attack, speed, range, rad, 8));
  }
  if(mouseButton == CENTER) frameRate(6000);
  if(mouseButton == RIGHT) frameRate(5);
}
