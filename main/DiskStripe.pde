public class  DiskStripe extends Drawable {
	private int		nbCircles; // nombre de cercles
	private int		nbStripes; // nombre de rayures par cercle
	private float	prctStripe; // pourcentage de la rayure entre deux points (entre 0 et 1)
	private color	centerC; // couleur du centre
	private PVector[]	circleCenters; // centre des cercles
	private float[]		circlesRay; // rayon des cercles
	private float[]		circlesAngle; // angle des rayures au seins d'un cercle
	private color[]		circlesColor; // couleur à atteindre pour l'extérieur du cercle
	private PVector[][]	points;
	
	// Custructor
	public  DiskStripe() {
		this.nbCircles = int(random(2, 5));
		this.nbStripes = int(random(100));
		this.prctStripe = random(1);
		this.centerC = randomColor();
		this.circleCenters = new PVector[nbCircles];
		this.circlesRay = new float[nbCircles];
		this.circlesAngle = new float[nbCircles];
		this.circlesColor = new color[nbCircles];

		float hmax = (100 * this.nbCircles) / 2;
		for (int i = 0; i < this.nbCircles; i++) {
			this.circleCenters[i] = new PVector(random(400) - 200, random(400) - 200, 100 * i - hmax);
			this.circlesRay[i] = random(40, 500);
			this.circlesAngle[i] = random(1);
			this.circlesColor[i] = randomColor();
		}

		this.getPoints();
	}
	
	public  DiskStripe(int _nbCircles, int _nbStripes, float _prctStripe, color _centerC, PVector[] _circleCenters, float[] _circlesRay, float[] _circlesAngle, color[] _circlesColor)  {
		this.nbCircles = _nbCircles;
		this.nbStripes = _nbStripes;
		this.prctStripe = _prctStripe;
		this.centerC = _centerC;
		this.circleCenters = _circleCenters;
		this.circlesRay = _circlesRay;
		this.circlesAngle = _circlesAngle;
		this.circlesColor = _circlesColor;
			
		this.getPoints();
	}

	// Private methods

	private void  getPoints() {
		this.points = new PVector[this.nbCircles][this.nbStripes * 2];
		float	stepAngle = TWO_PI / nbStripes;
		float	stripeAngle = stepAngle * prctStripe;
			
		for (int i = 0; i < this.nbCircles; i++) {
			for (int j = 0; j < this.nbStripes; j++) {
				// printf(i, j, circleCenters[i], circlesRay[i], stepAngle, circlesAngle[i], stripeAngle);
				this.points[i][2 * j] = pol2cart(circleCenters[i], circlesRay[i], j * stepAngle + circlesAngle[i]);
				this.points[i][2 * j + 1] = pol2cart(circleCenters[i], circlesRay[i], j * stepAngle + circlesAngle[i] + stripeAngle);
			}
		}
	}

	// Public methods
	public void  draw() {
		fill(this.centerC);
		for (int i = 0; i < nbCircles - 1; i++) {
			for (int j = 0; j < nbStripes; j++) {
				beginShape();
				vertex(this.points[i][2 * j]);
				vertex(this.points[i + 1][2 * j]);
				vertex(this.points[i + 1][2 * j + 1]);
				vertex(this.points[i][2 * j + 1]);
				endShape(CLOSE);
			}
		}
	}

	protected void	_clic(float x, float y) {}
	protected void	_scroll(int x, int y, float val) {}
	protected void	_key(char c) {}
	protected void	refresh() {}
	protected void	setSetup(){}
	protected void saveValue() {}

	public void	printSetup() {}
}