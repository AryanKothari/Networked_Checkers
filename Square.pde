class Square
{
  float _posX;
  float _posY;
  color _color;
  int _size;
  int _ID;
  String _Color;

  boolean _isSelected;
  boolean isOccupied;

  Square(float posX, float posY, color Color, int size, int ID, String Name)
  {
    _posX = posX;
    _posY = posY;
    _color = Color;
    _size = size;
    _ID = ID;
    _Color = Name;
    _isSelected = false;
    isOccupied = false;
  }

  public void Draw()
  {
    fill(_color);
    rect(_posX, _posY, _size, _size);
  }

  public boolean spaceCollision() {
    if (mouseX >= _posX & mouseX <= _posX + _size & 
      mouseY >= _posY & mouseY <= _posY + _size)
    {
      return true;
    } else 
    {
      return false;
    }
  }

  public boolean OccupationCheck(PVector pos, int radius)
  {
    if (_posY + _size > pos.y - radius && _posX + _size > pos.x - radius 
      && _posX + _size < pos.x + radius )
    {
      return true;
    } else
    {
      return false;
    }
  }

  public boolean RectCircleColliding(PVector circle, float CRadius) {
    float distX = Math.abs(circle.x - _posX-50/2);
    float distY = Math.abs(circle.y - _posY-50/2);

    if (distX > (50/2 + CRadius)) { 
      return false;
    }
    if (distY > (50/2 + CRadius)) { 
      return false;
    }

    if (distX <= (50/2)) { 
      return true;
    } 
    if (distY <= (50/2)) { 
      return true;
    }

    float dx=distX-50/2;
    float dy=distY-50/2;
    return (dx*dx+dy*dy<=(CRadius*CRadius));
  }
}