class Checker_Blue
{
  int _ID;
  PVector _pos;
  color _color;
  int _stroke;
  int _team;


  boolean _isSelected;
  boolean _turnOver;

  Checker_Blue(PVector pos, color Color, int ID, int team)
  {
    _pos = pos;
    _color = Color;
    _ID = ID;
    _stroke = Color;

    _team = team;

    _isSelected = false;
    _turnOver = true;
  }

  public void Draw()
  {
    fill(_color);
    stroke(_stroke);
    strokeWeight(2);
    ellipse(_pos.x, _pos.y, 40, 40);
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
      if (_team == 0 && _team == data[0])
      {
        _color = color(200, 200, 0);
      }
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

    if (_team == 0 && _team == data[0])
    {
      _stroke = color(0, 255, 0);
    } else
    {
      _stroke = color(_color);
    }
  }

  public void Move()
  {
    if (_team == 0 && _team == data[0])
    {
      if (_isSelected)
      {
        if (mousePressed)
        {
          if (dist(mouseX, mouseY, _pos.x, _pos.y) < 80
            && dist(mouseX, mouseY, _pos.x, _pos.y) > 30) 
          {

            if (((int)(mouseX/50) * 50 + 25 + (int)(mouseY/50) * 50 + 25) % 20 > 0) 
            {
              //if(it is not colliding with another piece)
              _pos.x = (int)(mouseX/50) * 50 + 25;
              _pos.y = (int)(mouseY/50) * 50 + 25;
              _isSelected = false;

              data[0] = 1;
              //s.write(data[0] + " " + _ID + " " + _pos.x + " " + _pos.y + "\n");
              s.write(data[0] + "\n");
            }
          }
        }
      }
    }
  }

  public void kill()
  {
  }
}