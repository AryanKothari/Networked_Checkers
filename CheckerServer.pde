int size = 50;
boolean checkerpiece = false;
boolean mouseClicked = false;
int selectedPieces = 0;
boolean hit;

int currSelected;
int ID;

String TeamTurn = "BLUE";


ArrayList<Checker> checker = new ArrayList<Checker>();

void setup() 
{
  size (400, 400);
  background(0);
  smooth();

  for (int x = 0; x < width; x += size) 
  {
    for (int y = 0; y < height; y += size) 
    { 
      if ((x+y) % 20 ==0) 
        if (y < 150)
        {
          checker.add(new Checker(new PVector(x + size/2, y + size/2), color(0, 0, 155), ID, "BLUE"));
          ID += 1;
        } else if (y >= 250)
        {
          checker.add(new Checker(new PVector(x + size/2, y + size/2), color(0, 0, 0), ID, "BLACK"));
          ID += 1;
        }
    }
  }
}

void draw() 
{
  background(0);
  noStroke();

  for (int x = 0; x < width; x += size) 
  {
    for (int y = 0; y < height; y += size) 
    { 
      if ((x+y) % 20 ==0) {  
        fill(255, 0, 0);
      } else 
      { 
        fill(0, 0, 0);
      } 
      rect (x, y, size, size);
    }
  }

  for (int i = 0; i<checker.size(); i++)
  {
    checker.get(i).Draw();
    checker.get(i).activate();
    checker.get(i).Move();
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
      if (checker.get(currSelected)._Team == TeamTurn)
      {
          checker.get(currSelected)._isSelected = true;
      }
    }
  }
}