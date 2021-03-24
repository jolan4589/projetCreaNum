public class  Test implements Drawable {
  int  posX, posY;
  
  // Custructor
  public Test() {
    this.posX = width/2;
    this.posY = height/2;
  }
  
  
  private void  build() {
  }
  
  // Private methods
  
  // Public methods
  public void  draw() {
    rectMode(CENTER);
    rect(this.posX, this.posY, mouseX, mouseY);
  }
}
