public class  DiskStripe implements Drawable {
	private PVector	center;
	private int		nbCircle;
	private int		nbStripe;
	
	// Custructor
	public DiskStripe() {
		build(new PVector(0,0), 0);
	}
	
	public DiskStripe(PVector _center) {
		build(_center, 0);
	}
	
	public DiskStripe(PVector _center, float _nbCircle) {
		build(_center, _nbCircle);
	}
	
	public DiskStripe(float _centerX, float _centerY) {
		build(new PVector(_centerX, _centerY), 0);
	}
	
	public DiskStripe(float _centerX, float _centerY, float _nbCircle) {
		build(new PVector(_centerX, _centerY), _nbCircle);
	}
	
	private void	build(PVector _center, float _nbCircle) {
	this.center = _center;
	this.nbCircle = _nbCircle;
	}
	
	// Private methods
	
	// Public methods
	public void	draw() {
		for (int i = 0; i < this.nbCircle; i++) {
		ellipse(this.center.x, this.center.y, abs(this.center.x - mouseX), abs(this.center.y - mouseY));
		}
	}
}
