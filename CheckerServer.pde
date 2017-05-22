int size = 50;
boolean checkerpiece = false;
int selectedPieces = 0;
boolean hit;
boolean update = false;

int currSelected;
int currSelectedBlock;
int ID;
int BlockID;
int run = 0;

int BlackCheckers;
int BlueCheckers;


int screen = 0;
String mode;

PFont font;

import processing.net.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioPlayer movesound;
AudioPlayer music;

Server s;
Client c;
String input;
int data[] = new int[6];


ArrayList<Checker_Blue> checker = new ArrayList<Checker_Blue>();
ArrayList<Square> block = new ArrayList<Square>();
InfoBar InfoBar;

void setup() 
{
  size (400, 420);
  background(0);
  smooth();

  font = createFont("font.ttf", 32);

  data[0] = 0;

  minim = new Minim(this); //Music 
  movesound = minim.loadFile("movesound.mp3");
  music = minim.loadFile("music.mp3");

  s = new Server(this, 12345); 

  for (int x = 0; x < width; x += size) 
  {
    for (int y = 0; y < height; y += size) 
    { 
      if ((x+y) % 20 ==0) 
      {
        if (y < 150)
        {
          checker.add(new Checker_Blue(new PVector(x + size/2, y + size/2), color(0, 0, 155), ID, 0));
          ID += 1;
        } else if (y >= 250)
        {
          checker.add(new Checker_Blue(new PVector(x + size/2, y + size/2), color(0, 0, 0), ID, 1));
          ID += 1;
        }
      }
    }
  }

  for (int x = 0; x < width; x += size) 
  {
    for (int y = 0; y < height; y += size) 
    { 
      if ((x+y) % 20 ==0) 
      {
        block.add(new Square(x, y, color(255, 0, 0), size, BlockID, "RED"));
        BlockID += 1;
      } else
      {
        block.add(new Square(x, y, color(0, 0, 0), size, BlockID, "BLACK"));
        BlockID += 1;
      }
    }
  }

  for (int i = 0; i<checker.size(); i++)
  {
    if (checker.get(i)._team == 0)
    {
      BlueCheckers += 1;
    }

    if (checker.get(i)._team == 1)
    {
      BlackCheckers += 1;
    }
  }

  BlackCheckers -= 4;

  InfoBar = new InfoBar();
}

void draw() 
{
  background(255, 0, 0);

  noStroke();

  if (screen == 0 || screen == 4)
  {
    music.play();
    fill (0, 0, 200);
    textSize(20);
    text("The Game Of...", 50, 60);
    text("Created by Aryan Kothari", 145, 405);
    textFont(font, 75);
    text("Checkers", 60, 115);

    fill(0, 0, 0); //play
    rect(110, 140, 180, 40);
    rect(110, 200, 180, 40);
    rect(110, 260, 180, 40);

    fill(0, 0, 255);
    textSize(30);
    text("Multiplayer", 125, 165);
    text("One Device", 125, 225);
    text("vs Bot", 140, 285);

    if (mousePressed && mouseX > 110 && 
      mouseX < 110 + 180 && mouseY > 140 && mouseY < 140 + 40) //multiplayer
    {
      movesound.play();
      movesound.rewind();
      update = true;
      screen = 1;
      mode = "multiplayer";
    }

    if (mousePressed && mouseX > 110 && 
      mouseX < 110 + 180 && mouseY > 200 && mouseY < 200 + 40) //one device
    {
      movesound.play();
      movesound.rewind();

      screen = 2;
      update = true;
      mode = "one device";
    }
  }

  if (screen == 1 || screen == 2)
  {

    for (int i = 0; i < block.size(); i++)
    {
      block.get(i).Draw();
    }


    for (int i = 0; i<checker.size(); i++)
    {
      checker.get(i).Draw();

      if (mode == "multiplayer")
      {
        if (checker.get(currSelected)._team == 0)
        {
          checker.get(i).select();
        }
      }

      if (mode == "one device")
      {
        checker.get(i).select();
      }

      checker.get(i).Move();
    }

    InfoBar.Draw();
  }

  for (int i = 0; i < block.size(); i++)
  {
    for (int j = 0; j < checker.size(); j++)
    {

      if (update)
      {
        s.write(0 + " " + 0 + " " +  
          0 + " " + screen + "\n");
        update = false;
      }

      c = s.available();
      if (c != null) {
        input = c.readString();
        input = input.substring(0, input.indexOf("\n")); // Only up to the newline
        data = int(split(input, ' ')); // Split values into an array
        checker.get(data[2])._pos.x = block.get(data[1])._posX + 25;
        checker.get(data[2])._pos.y = block.get(data[1])._posY + 25;
      }
    }
  }
}

void mouseClicked()
{
  for (int i = 0; i < checker.size(); i++)
  {
    checker.get(i)._isSelected = false;

    if (checker.get(i).checkerCollision())
    {
      currSelected = checker.get(i)._ID;

      if (mode == "multiplayer")
      {
        if (checker.get(currSelected)._team == 0 && checker.get(currSelected)._team == data[0])
        {
          checker.get(currSelected)._isSelected = true;
        }
      }

      if (mode == "one device")
      {
        if (checker.get(currSelected)._team == data[0])
        {
          checker.get(currSelected)._isSelected = true;
        }
      }
    }
  }
}

void keyPressed()
{
  if (key == ESC)
  {
    if (screen == 1)
    {
      update = true;
      screen = 4;
      s.write(data[0] + " " + 0 + " " +  0 + " " + screen + "\n");
    }
  }
}