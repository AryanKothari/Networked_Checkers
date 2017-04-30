class Checker
{
  PVector _pos;
  color _color;
  int _stroke;
  boolean _isSelected;

  Checker(PVector pos, color Color, int stroke)
  {
    _pos = pos;
    _color = Color;
    _stroke = stroke;
    _isSelected = false;
  }

  public void Draw()
  {
    fill(_color);
    stroke(_stroke);
    ellipse(_pos.x, _pos.y, 40, 40);
  }

  private boolean checkerCollision() {

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



  public void isSelected()
  {
    if (checkerCollision())
    {
      _isSelected = true;
    }

    if (_isSelected)
    {
      _color = color(0, 0, 155);
    }
  }
}