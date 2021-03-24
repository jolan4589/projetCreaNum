public class	DiskStripe implements Drawable {
	private int		nbCircle; // nombre de cercles
	private int		nbStripe; // nombre de rayures par cercle
	private float	prctStripe; // pourcentage de la rayure entre deux points (entre 0 et 1)
	private color		centerC; // couleur du centre
	private PVector[]	circleCenter; // centre des cercles
	private float[]		circleRay; // rayon des cercles
	private float[]		circleAngle; // angle des rayures au seins d'un cercle
	private color[]		circleColor; // couleur à atteindre pour l'extérieur du cercle
	private PVector[][]	points;
	
	// Custructor
	public	DiskStripe() {
	}
	
	public	DiskStripe(int _nbCircle, int _nbStripe, float _prctStripe, color _centerC, PVector[] _circleCenter, float[] _circleRay, float[] _circleAngle, color[] _circleColor)  {
		this.nbCircle = _nbCircle;
		this.nbStripe = _nbStripe;
		this.prctStripe = _prctStripe;
		this.centerC = _centerC;
		this.circleCenter = _circleCenter;
		this.circleRay = _circleRay;
		this.circleAngle = _circleAngle;
		this.circleColor = _circleColor;
		
		this.getPoints();
	}
	
	// Private methods
	
	private void	getPoints() {
		this.points = new PVector[this.nbCircle][this.nbStripe * 2];
		float	stepAngle = TWO_PI / nbStripe;
		float	stripeAngle = stepAngle * prctStripe;

		for (int i = 0; i < this.nbCircle; i++) {
			for (int j = 0; j < this.nbStripe; j++) {
				// printf(i, j, circleCenter[i], circleRay[i], stepAngle, circleAngle[i], stripeAngle);
				this.points[i][2 * j] = pol2cart(circleCenter[i], circleRay[i], j * stepAngle + circleAngle[i]);
				this.points[i][2 * j + 1] = pol2cart(circleCenter[i], circleRay[i], j * stepAngle + circleAngle[i] + stripeAngle);
			}
		}
	}

	// Public methods
	public void	draw() {
		for (int i = 0; i < nbCircle - 1; i++) {
			for (int j = 0; j < nbStripe; j++) {
				beginShape();
				vertex(this.points[i][2 * j]);
				vertex(this.points[i + 1][2 * j]);
				vertex(this.points[i + 1][2 * j + 1]);
				vertex(this.points[i][2 * j + 1]);
				endShape(CLOSE);
			}
		}
	}
}
