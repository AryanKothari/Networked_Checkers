class Checker_Blue
{
  int _ID;
  PVector _pos;
  color _color;
  int _stroke;
  int _team;


  boolean _isSelected;
  boolean _turnOver;
  boolean _isActive;

  Checker_Blue(PVector pos, color Color, int ID, int team)
  {
    _pos = pos;
    _color = Color;
    _ID = ID;
    _stroke = Color;

    _team = team;

    _isSelected = false;
    _turnOver = true;
    _isActive = true;
  }

  public void Draw()
  {
    if (_isActive)
    {
      fill(_color);
      stroke(_stroke);
      strokeWeight(2);
      ellipse(_pos.x, _pos.y, 40, 40);
    }
  }

  public boolean checkerCollision() {

    // get distance between the point and circle's center
    // using the Pythagorean Theorem
    float distX = mouseX - _pos.x;
    float distY = mouseY - _pos.y;
    float distance = sqrt( (distX*distX) + (distY*distY) );

    // if the distance is less than the circle's
    // radius the point is inside!
    if (distance <= 20) {
      return true;
    } else return false;
  }



  public void select()
  {
    if (_isSelected)
    {
      _color = color(200, 200, 0);
    }

    if (!_isSelected)
    {
      if (_team == 0)
      {
        _color = color(0, 0, 155);
      } 
      if (_team == 1)
      { 
        _color = color(0, 0, 0);
      }
    }

    if (_team == data[0])
    {
      _stroke = color(0, 255, 0);
    } else
    {
      _stroke = color(_color);
    }
  }

  public void Move()
  {
    for (int i = 0; i < block.size(); i++)
    {
      if (_team == data[0])
      {
        if (_isSelected)
        {
          if (mousePressed)
          {
            if (block.get(i).spaceCollision())
            {
              currSelectedBlock = block.get(i)._ID;
              if (block.get(currSelectedBlock)._Color == "RED") 
              {
                if (block.get(currSelectedBlock).isAvaliable)
                {
                  _pos.x = block.get(currSelectedBlock)._posX + 25;
                  _pos.y = block.get(currSelectedBlock)._posY + 25;

                  distance = dist(block.get(prevSelectedBlock)._posX, 
                    block.get(prevSelectedBlock)._posY + 50, 
                    block.get(currSelectedBlock)._posX, 
                    block.get(currSelectedBlock)._posY + 50);

                  if (distance > 100)
                  {
                    activateKill = true;
                    println(activateKill);
                  }

                  movesound.play();
                  movesound.rewind();

                  _isSelected = false;
                  block.get(currSelectedBlock).isAvaliable = false;
                  block.get(prevSelectedBlock).isAvaliable = true;


                  if (mode == "multiplayer")
                  {
                    data[0] = 1;
                    s.write(data[0] + " " + 
                      block.get(currSelectedBlock)._ID + " " + 
                      _ID + " " + screen + " " + block.get(prevSelectedBlock) + "\n");
                  }

                  if (mode == "one device")
                  {
                    if (data[0] == 0)
                    {
                      data[0] = 1;
                    } else 
                    {
                      data[0] = 0;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }


  public void kill()
  {
    _isActive = false;
  }
}