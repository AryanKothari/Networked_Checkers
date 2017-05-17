int size = 50;
boolean checkerpiece = false;
boolean mouseClicked = false;
int selectedPieces = 0;
boolean hit;

int currSelected;
int currSelectedBlock;
int ID;
int BlockID;

boolean Update = false;

import processing.net.*;

Server s;
Client c;
String input;
int data[] = new int[3];


ArrayList<Checker_Blue> checker = new ArrayList<Checker_Blue>();
ArrayList<Square> block = new ArrayList<Square>();

void setup() 
{
  size (400, 400);
  background(0);
  smooth();

  data[0] = 0;

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
}

void draw() 
{
  background(0);
  noStroke();

  for (int i = 0; i < block.size(); i++)
  {
    block.get(i).Draw();
  }

  for (int i = 0; i<checker.size(); i++)
  {
    checker.get(i).Draw();
    checker.get(i).select();
    checker.get(i).Move();

    if (data[0] == 1)
    {
      checker.get(i)._isSelected = false;
    }
  }

  for (int i = 0; i < block.size(); i++)
  {
    for (int j = 0; j < checker.size(); j++)
    {

      c = s.available();
      if (c != null) {
        input = c.readString();
        input = input.substring(0, input.indexOf("\n")); // Only up to the newline
        data = int(split(input, ' ')); // Split values into an array
        checker.get(data[2])._pos.x = block.get(data[1])._posX + 25;
        checker.get(data[2])._pos.y = block.get(data[1])._posY + 25;
        println(data[1], data[2]);
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

      if (checker.get(currSelected)._team == 0 && checker.get(currSelected)._team == data[0])
      {
        checker.get(currSelected)._isSelected = true;
      }
    }
  }
}