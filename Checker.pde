class Checker
{
  int _ID;
  PVector _pos;
  color _color;
  int _stroke;
  String _Team;
  boolean _isSelected;
  boolean _mouseClicked;

  Checker(PVector pos, color Color, int ID, String Team)
  {
    _pos = pos;
    _color = Color;
    _ID = ID;
    _stroke = Color;
    _isSelected = false;
    _Team = Team;
    _mouseClicked = false;
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



  public void activate()
  {
    if (_isSelected)
    {
      _color = color(255, 255, 255);
    }

    if (!_isSelected)
    {
      if (_Team == "BLUE")
      {
        _color = color(0,0,155);
      } 
      if (_Team == "BLACK")
      { 
        _color = color(0, 0, 0);
      }
    }
    
    if(_Team == TeamTurn)
    {
      _stroke = color(0,255,0);
    } else
    {
      _stroke = color(_color);
    }
  }

  public void Move()
  {
    if (_isSelected)
    {
      if (mousePressed)
      {
        if (dist(mouseX, mouseY, _pos.x, _pos.y) < 80) 
        {
          if (((int)(mouseX/50) * 50 + 25 + (int)(mouseY/50) * 50 + 25) % 20 > 0) 
          {
            //if(it is not colliding with another piece)
            _pos.x = (int)(mouseX/50) * 50 + 25;
            _pos.y = (int)(mouseY/50) * 50 + 25;
            _isSelected = false;

            if (TeamTurn == "BLUE")
            {
              TeamTurn = "BLACK";
            } else
            {
              TeamTurn = "BLUE";
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