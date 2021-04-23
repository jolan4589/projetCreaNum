public class Bowl extends Drawable {
	
	// Propriétés
	
	private int		nbSubDiv; // nomre de segments par cercle
	private int		nbSubDivZ; // nombre voulu de segment par hauteur
	private int		nbSubDivEffectiv; // nomre effectif de segment par hauteur
	private float[]	nbInDiv; // nombre de division entre deux cercles
	private int		nbCircles; // nombre de cercles
	private PVector[]	circles; // centre des cercles
	private float[]		rays; // rayon des cercles
	private float[]		rots; // rotation des cercles
	private PVector[][]	points; // tableau des points de l'objet
	private color[]		colors; // couleurs a atteindre pour les cercles

	// Constructeurs

	public Bowl() {
		build();
	}

	private void build() {
		this.nbSubDiv = int(random(3, 100));
		this.nbSubDivZ = int(random(3, 100));
		this.nbCircles = int(random(2, 5));
		this.circles = new PVector[this.nbCircles];
		this.rays = new float[this.nbCircles];
		this.rots = new float[this.nbCircles];
		this.colors = new color[this.nbCircles];

		float hmax = (300 * this.nbCircles) / 2;
		for (int i = 0; i < this.nbCircles; i++) {
			this.circles[i] = new PVector(random(400) - 200, random(400) - 200, 300 * i - hmax);
			this.rays[i] = random(40, 500);
			this.rots[i] = random(-5, 5);
			this.colors[i] = randomColor();
		}

		getNbInDiv();
		getPoints();
	}

	// Fonctions privees

	private float findMaxDist(int i) {
		float step = TWO_PI / 1000;
		float dist = 0;
			
		for (int j = 0; j < 1000; j++) {
			float tmp = PVector.dist(
			pol2cart(this.circles[i], this.rays[i], j * step + this.rots[i]),
			pol2cart(this.circles[i + 1], this.rays[i + 1], j * step + this.rots[i + 1]));
			if (tmp > dist)
			dist = tmp;
		}
		return(dist);
	}

	private void  getNbInDiv() {
		this.nbInDiv = new float[this.nbCircles - 1];
		float totalDist = 0;
		this.nbSubDivEffectiv = this.nbCircles;
		int nbInPts = this.nbSubDivZ - this.nbCircles;
			
		for (int i = 0; i < this.nbCircles - 1; i++) {
			this.nbInDiv[i] = findMaxDist(i);
			totalDist += this.nbInDiv[i];
		}
		for (int i = 0; i < this.nbCircles - 1; i++) {
			this.nbInDiv[i] = (int)(this.nbInDiv[i] / totalDist * nbInPts);
			this.nbSubDivEffectiv += this.nbInDiv[i];
		}
	}

	private void  getPoints() {
		this.points = new PVector[this.nbSubDiv][this.nbSubDivEffectiv];
		float thStep = TWO_PI / this.nbSubDiv;
			
		for (int i = 0; i < this.nbSubDiv; i++) {
			float	th = thStep * i;
			int		currentPoint = 0;

			for (int j = 0; j < this.nbInDiv.length; j++) {
				PVector currentA = pol2cart(this.circles[j], this.rays[j], th + this.rots[j]);
				PVector currentB = pol2cart(this.circles[j + 1], this.rays[j + 1], th + this.rots[j + 1]);
				float stepx = (currentB.x - currentA.x) / (this.nbInDiv[j]);
				float stepy = (currentB.y - currentA.y) / (this.nbInDiv[j]);
				float stepz = (currentB.z - currentA.z) / (this.nbInDiv[j]);

				this.points[i][currentPoint] = currentA;
				currentPoint++;
				for (int k = 1; k < this.nbInDiv[j] + 1; k++) {
					points[i][currentPoint] = new PVector(currentA.x + k * stepx, currentA.y + k * stepy, currentA.z + k * stepz);
					currentPoint++;
				}
				this.points[i][currentPoint] = currentB;
			}
		}
	}

	void  drawBase(int i) {
		PVector	c = this.circles[i];
		float	r = this.rays[i];
		float 	step = TWO_PI / this.nbSubDiv;
			
		// TODO : couleurs
		beginShape();
		for (int j = 0; j < this.nbSubDiv; j++) {
			vertex(pol2cart(c, r, j * step + rots[i]));
		}
		endShape(CLOSE);
	}

	// Fonctions publiques

	public void    draw() {
		for (int i = 0; i < this.nbSubDiv; i++) {
			for (int j = 0; j < this.nbSubDivEffectiv - 1; j++) {
				strokeWeight(0);
				fill(100 * j / (this.nbSubDivEffectiv - 1) ,50, 50);
				int next = (i + 1) % nbSubDiv;

				beginShape();
				vertex(this.points[i][j]);
				vertex(this.points[i][j + 1]);
				vertex(this.points[next][j + 1]);
				vertex(this.points[next][j]);
				endShape(CLOSE);
			}
		}
		drawBase(0);
		drawBase(this.nbCircles - 1);
	}

	protected void	_clic(float x, float y) {}
	protected void	_scroll(int x, int y, float val) {}
	protected void	_key(char c) {}
	protected void	refresh() {}
	protected void	setSetup(){}
	protected void saveValue() {}

	public void	printSetup() {}
}