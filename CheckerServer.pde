int size = 50;
boolean checkerpiece = false;
boolean canmove = false;
boolean hit;


ArrayList<Checker> checker = new ArrayList<Checker>();

void setup() {
  size (400, 400);
  smooth();
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
        checkerpiece = true;
      } else 
      { 
        fill(0, 0, 0);
        checkerpiece = false;
      } 
      rect (x, y, size, size);

      if (checkerpiece)
      {
        if (y < 150)
        {
          checker.add(new Checker(new PVector(x + size/2, y + size/2), color(255, 0, 0), 0));
        } else if (y >= 250)
          checker.add(new Checker(new PVector(x + size/2, y + size/2), color(0, 0, 0), 255));
      }
    }
  }

  for (int i = 0; i<checker.size(); i++)
  {

    checker.get(i).isSelected();

    checker.get(i).Draw();
  }
}

//void mouseClicked()
//{
//  canmove = true; 
//}