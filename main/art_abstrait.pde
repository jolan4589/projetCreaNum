public class abstrait implements Drawable {

	// Propriétés

	private int			nbSubDiv; // nomre de segments par cercle
	private int			nbSubDivZ; // nombre voulu de segment par hauteur
	private int			nbSubDivEffectiv; // nomre effectif de segment par hauteur
	private float[]		nbInDiv; // nombre de division entre deux cercles
	private int			nbCircles; // nombre de cercles
	private	PVector[]	circles; // centre des cercles
	private float[]		rays; // rayon des cercles
	private float[]		rots; // rotation des cercles
	private PVector[][]	points; // tableau des points de l'objet
	private color[]		colors; // couleurs a atteindre pour les cercles

	// Constructeurs

	public abstrait() {
		build();
	}

	private void build() {
		this.nbSubDiv = 5;
		this.nbSubDivZ = 10;
		this.nbCircles = 3;
		this.circles = new PVector[3];
		this.circles[0] = new PVector(50, 100, 250);
		this.circles[1] = new PVector(400,-200, 100);
		this.circles[2] = new PVector(-50, -100, -250);
		this.rays = new float[3];
		this.rays[0] = 300;
		this.rays[1] = 50;
		this.rays[2] = -200;
		this.rots = new float[3];
		this.rots[0] = 0;
		this.rots[1] = 0;
		this.rots[2] = 0;
		this.colors = new color[3];
		this.colors[0] = color(0, 50, 50);
		this.colors[0] = color(0, 50, 50);
		this.colors[0] = color(0, 50, 50);

		getNbInDiv();
		getPoints();
		//print(nbSubDivEffectiv,":", nbInDiv[0],":", nbInDiv[1],":");
		for (int i = 0; i < nbSubDiv; i++) {
			print(points[i]);
			print("\n");
			/*for (int j = 0; j < nbSubDivEffectiv; j++) {

			}*/
		}
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
		return (dist);
	}

	private void	getNbInDiv() {
		this.nbInDiv = new float[this.nbCircles - 1];
		float totalDist = 0;
		this.nbSubDivEffectiv = this.nbCircles;
		int nbInPts = this.nbSubDivZ - this.nbCircles;

		for (int i = 0; i < this.nbCircles - 1; i++) {
			this.nbInDiv[i] = findMaxDist(i);
			totalDist += this.nbInDiv[i];
		}
		for (int i = 0; i < this.nbCircles - 1; i++) {
			this.nbInDiv[i] = (int) (this.nbInDiv[i] / totalDist * nbInPts);
			this.nbSubDivEffectiv += this.nbInDiv[i];
		}
	}

	private void	getPoints() {
		this.points = new PVector[this.nbSubDiv][this.nbSubDivEffectiv];
		float thStep = TWO_PI / this.nbSubDiv;

		for (int i = 0; i < this.nbSubDiv; i++) {
			float th = thStep * i;
			int currentPoint = 0;

			for (int j = 0; j < this.nbInDiv.length; j++) {
				PVector currentA = pol2cart(this.circles[j], this.rays[j], th + this.rots[j]);
				PVector currentB = pol2cart(this.circles[j + 1], this.rays[j + 1], th + this.rots[j + 1]);
				float stepx = (currentB.x - currentA.x) / (this.nbInDiv.length);
				float stepy = (currentB.y - currentA.y) / (this.nbInDiv.length);
				float stepz = (currentB.z - currentA.z) / (this.nbInDiv.length);

				this.points[i][currentPoint] = currentA;
				currentPoint++;
				this.points[i][(int)(currentPoint + this.nbInDiv[j])] = currentB;
				for (int k = 1; k < this.nbInDiv[j] + 1; k++) {
					points[i][currentPoint] = new PVector(currentA.x + k * stepx, currentA.y + k * stepy, currentA.z + k * stepz);
					currentPoint++;
				}
			}
		}
	}

	void	drawBase(int i) {
		PVector c = this.circles[i];
		float	r = this.rays[i];
		float	step = TWO_PI / this.nbSubDiv;

		// TODO : couleurs
		beginShape();
		for (int j = 0; j < this.nbSubDiv; j++) {
			vertex(pol2cart(c, r, j * step + rots[i]));
		}
		endShape(CLOSE);
	}

	// Fonctions publiques

	public void		draw() {
		for (int i = 0; i < 1 /* this.nbSubDiv */; i++) {
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
		strokeWeight(50);
		point(circles[0].x, circles[0].y, circles[0].y);
		strokeWeight(30);
		point(circles[1].x, circles[1].y, circles[1].y);
		strokeWeight(10);
		point(circles[2].x, circles[2].y, circles[2].y);
	}
}


/*

[ 350.0, 100.0, 250.0 ] [ 400.0, -50.0, 175.0 ] [ 450.0, -200.0, 100.0 ] [ 500.0, -350.0, 25.0 ] [ 450.0, -200.0, 100.0 ] [ 100.0, -150.0, -75.0 ] [ -250.0, -100.0, -250.0 ] [ -600.0, -50.0, -425.0 ] [ -250.0, -100.0, -250.0 ]
[ 142.7051, 385.31696, 250.0 ] [ 279.07794, 116.434875, 175.0 ] [ 415.4508, -152.4472, 100.0 ] [ 551.82367, -421.32928, 25.0 ] [ 415.45084, -152.44717, 100.0 ] [ 151.82373, -221.32924, -75.0 ] [ -111.803375, -290.2113, -250.0 ] [ -375.4305, -359.09338, -425.0 ] [ -111.80339, -290.2113, -250.0 ]
[ -192.70512, 276.33557, 250.0 ] [ 83.42201, 52.86241, 175.0 ] [ 359.54913, -170.61075, 100.0 ] [ 635.6763, -394.08392, 25.0 ] [ 359.54913, -170.61075, 100.0 ] [ 235.67627, -194.0839, -75.0 ] [ 111.803406, -217.55704, -250.0 ] [ -12.069458, -241.03018, -425.0 ] [ 111.803406, -217.55704, -250.0 ]
[ -192.70508, -76.3356, 250.0 ] [ 83.42206, -152.86243, 175.0 ] [ 359.5492, -229.38927, 100.0 ] [ 635.67633, -305.9161, 25.0 ] [ 359.54916, -229.38927, 100.0 ] [ 235.67627, -105.91609, -75.0 ] [ 111.80339, 17.557083, -250.0 ] [ -12.069489, 141.03026, -425.0 ] [ 111.80339, 17.557076, -250.0 ]
[ 142.70514, -185.31696, 250.0 ] [ 279.078, -216.43489, 175.0 ] [ 415.45087, -247.55283, 100.0 ] [ 551.8237, -278.67078, 25.0 ] [ 415.45087, -247.55283, 100.0 ] [ 151.82373, -78.67076, -75.0 ] [ -111.803406, 90.2113, -250.0 ] [ -375.43054, 259.09335, -425.0 ] [ -111.80342, 90.2113, -250.0 ]
7.2949142, 250.0 ] [ 391.43488, -104.077965, 175.0 ] [ 447.55283, -215.45084, 100.0 ] [ 503.67078, -326.82373, 25.0 ] [ 447.55283, -215.45085, 100.0 ] [ 103.670746, -126.82373, -75.0 ] [ -240.21133, -38.19661, -250.0 ] [ -584.0934, 50.430496, -425.0 ] [ -240.2113, -38.19661, -250.0 ]

*/