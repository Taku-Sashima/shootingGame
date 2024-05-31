int time;
boolean r,l,u,d,bull;
Player player;

void setup(){
  size(800,800);
  frameRate(250);
  player = new Player(400,700,50,100);
}

void draw(){
  background(0);
  fill(255);
  rect(545,25,210,60);
  time++;
  
  //プレイヤーの弾丸の動き
  if(bull){
    if(time%15==0){
      bullet.add(new Bullet(player.x,player.y,8,10));
    }
  }
  for(int i=0; i<bullet.size(); i++){
    if(bullet.get(i).bull_y<0){
      bullet.remove(i);
    }
    if(bullet.size()==0)
    break;
    bullet.get(i).shoot();
    bullet.get(i).fire();
  }
  
  //敵の弾丸の動き
  for(int i=0; i<enemy.size();i++){
    if(time%150==0){
      e_bullet.add(new e_Bullet(enemy.get(i).ene_x,enemy.get(i).ene_y,10,player.x,player.y));
    }
  }
  for(int i=0; i<e_bullet.size(); i++){
    if(e_bullet.get(i).e_bull_y>800){
      e_bullet.remove(i);
    }
    if(e_bullet.size()==0)
    break;
    e_bullet.get(i).shoot();
    e_bullet.get(i).fire();
  }
  
  //敵の動き
  int[] col = new int[3];
  for(int i=0; i<3;i++){
    col[i]=int(random(20,255));
  }
  if(time%700==0){
    enemy.add(new Enemy(random(300,500),0,random(40,50),0.3,random(-0.35,0.35), col));
  }
  for(int i=0; i<enemy.size(); i++){
    enemy.get(i).emerge();
    enemy.get(i).e_move();
    if(enemy.get(i).e_HP<25 || enemy.get(i).ene_x<0 || enemy.get(i).ene_x>800 
    || enemy.get(i).ene_y>900){
      enemy.remove(i);
    }
    if(enemy.size()==0)
    break;
  }
  
  //pacの動き
  player.show();
  player.move();
  player.hitpoint();
  
  collision();
  
}

//プレイヤーの弾丸のクラス,変数と動きと描写↓
ArrayList<Bullet> bullet = new ArrayList<Bullet>();
class Bullet{
  float bull_x,bull_y,speed,rad;
  
  Bullet(float bull_x,float bull_y,float speed,float rad){
    this.bull_x=bull_x;
    this.bull_y=bull_y;
    this.speed=speed;
    this.rad=rad;
  }
  
  void fire(){
    noStroke();
    ellipse(bull_x,bull_y,rad,rad);
  }
  
  void shoot(){
    bull_y-=speed;
  }
  
}

//敵の弾丸のクラス,変数と動きと描写↓
ArrayList<e_Bullet> e_bullet = new ArrayList<e_Bullet>();
class e_Bullet{
  float e_bull_x,e_bull_y,e_rad,px,py;
  PVector e_bull_vec;
  
  e_Bullet(float e_bull_x,float e_bull_y,float e_rad, float px, float py){
    this.e_bull_x = e_bull_x;
    this.e_bull_y = e_bull_y;
    this.e_rad=e_rad;
    e_bull_vec = new PVector(px - e_bull_x, py - e_bull_y);
  }
  
  void fire(){
    fill(#AC1476);
    noStroke();
    ellipse(e_bull_x,e_bull_y,e_rad,e_rad);
  }
  
  void shoot(){
    e_bull_vec = e_bull_vec.setMag(0.7);
    e_bull_x += e_bull_vec.x;
    e_bull_y += e_bull_vec.y;
  }
  
}

//敵のクラス↓
ArrayList<Enemy> enemy = new ArrayList<Enemy>();
class Enemy{
  float ene_x,ene_y,e_HP,speed,speed_x;
  int[] col = new int[3];
  
  Enemy(float ene_x,float ene_y,float e_HP,float speed,float speed_x,int[] col){
    this.ene_x=ene_x;
    this.ene_y=ene_y;
    this.e_HP=e_HP;
    this.speed=speed;
    this.speed_x=speed_x;
    this.col=col;
  }
  void e_move(){
    ene_x += speed_x;
    ene_y += speed;
  }
  
  void emerge(){
    fill(col[0],col[1],col[2]);
    noStroke();
    rect(ene_x,ene_y,e_HP,e_HP);
  }
  
}

//プレイヤーのクラス
class Player{
  float x,y;
  int s,p_HP;
  Player(float x,float y, int s, int p_HP){
    this.x=x;
    this.y=y;
    this.s=s;
    this.p_HP=p_HP;
  }
  
  //Pacの描写
  void show(){
     fill(#FFF939);
     noStroke();
     arc(x,y,s,s,QUARTER_PI,7*QUARTER_PI);
  }
  
  //Pacの動き↓
  void move(){
    if(r){
      x+=1.5;
      surround();
    }
    if(l){
      x-=1.5;
      surround();
    }
    if(u){
      y-=1.5;
      surround();
    }
    if(d){
      y+=1.5;
      surround();
    }
  }
  
  void surround(){
    if(x<20){
      x=20;
    }if (x>780){
      x=780;
    }if(y<20){
      y=20;
    }if (y>780){
      y=780;
    }
  }
  
  //HPバーの表示
  void hitpoint(){
    fill(#00FF00);
    rect(550,30,p_HP*2,50);
  }
  
}




void keyPressed(){
  print(key);
  if(keyCode==39){
    r=true ;
  }
  if(keyCode==37){
    l=true ;
  }
  if(keyCode==38){
    u=true ;
  }
  if(keyCode==40){
    d=true ;
  }
  //弾丸の格納を真にする
  if(keyCode==32){
    bull=true;
  }
  
}

void keyReleased(){
  if(keyCode==39){
    r=false ;
  }
  if(keyCode==37){
    l=false ;
  }
  if(keyCode==38){
    u=false ;
  }
  if(keyCode==40){
    d=false ;
  }
  //弾丸のの格納を偽にする
  if(keyCode==32){
    bull=false;
  }
}

//敵と弾丸の接触判定
void collision(){
  for(int i=0; i<enemy.size(); i++){
    for (int j=0; j<bullet.size(); j++){
      float ex=enemy.get(i).ene_x, ey=enemy.get(i).ene_y, es=enemy.get(i).e_HP,
      bx=bullet.get(j).bull_x, by=bullet.get(j).bull_y;
      if(ex<bx && ex+es>bx && ey<by && ey+es>by){
        enemy.get(i).e_HP -= 1;
        bullet.remove(j);
      }
    }
  }
}
