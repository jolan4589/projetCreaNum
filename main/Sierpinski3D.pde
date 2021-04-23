  public class	Sierpinski3D extends Drawable {
	
	private int		nbIte;			 // nombre de recursions positif ou nul, 0 -> 1 pyramide, 1 -> 4 pyramides, ...
	private int		_posInAllTab;	// position, dans le tableau général, de la pyramide en construction
	private float	size;			// taille des aretes
	private float	_h;				// hauteur entre la base et le sommet de la pyramide principale
	private PVector[][]	_allPoints;		// tableau général des pyramides
	private color[]		_allColors;		// tableau des couleurs correspondant aux pyramides
	private PVector[]	_startPTS;		// points de la pyramide de depart
	private color[]		startCOLORS;	// couleurs de la pyramide de départ
		
	// Custructor

	public	Sierpinski3D() {
		build(2, 200, randomColor(), randomColor(), randomColor(), randomColor());
	}

	// Private methods

	/**
	 *	Procédure initialisant l'objet.
	 */
	private void	build(int _nbIte, float _size, color ... _startCOLORS) {
		this.nbIte = _nbIte;
		this.size = _size;
		this.startCOLORS = _startCOLORS;
		this.refresh();
	}

	/**
	*	Fonction calculant la couleur d'une pyramide
	*
	*	in
	* p	: point representatif de la pyramidie dont on cherche la couleur
	*
	*	out	: couleur interpolee de la pyramide
	*/
	private color	interpolPyramidColor(PVector p) {
		PVector[]	interp = new PVector[3]; // points interpoles
		color[]		interpColor = new color[3]; // couleurs interpolees
		float		adv = abs(p.z - this._startPTS[3].z) / this._h; // avancement de la hauteur de p par rapport a la hauteur de la pyramide initiale

		// En cas d'avancement a 0 le code renvoit du noir,
		// on le remplace par la couleur du haut de la pyramide initiale
		if (adv == 0) {
			return (startCOLORS[3]);
		}
		// Calcule des points et leurs couleurs sur les aretes a la meme hauteur que p.
		for (int i = 0; i < 3; i++) {
			interp[i] = PVector.lerp(this._startPTS[3], this._startPTS[i], adv);
			interpColor[i] = lerpColor(this.startCOLORS[3], this.startCOLORS[i], adv);
		}
		// Calcule de l'avancement entre B et C de l'intersection des droties (Ap) et (BC).
		// On utilise l'angle entre les vecteurs AB et Ap pour calculer l'avancement a PI / 3 (60 degres).
		adv = abs(PVector.angleBetween(point2vector(interp[0], interp[1]), point2vector(interp[0], p))) / (PI / 3);
		interp[1] = PVector.lerp(interp[1], interp[2], adv); // Sauvegarde du point entre B et C (m).
		interpColor[1] = lerpColor(interpColor[1], interpColor[2], adv); /// Sauvegarde de la couleur de ce point.
		adv = interp[0].dist(p) / interp[0].dist(interp[1]); // Avancement de p sur Am
		return (lerpColor(interpColor[0], interpColor[1], adv));
	}

	/**
	 *	Procédure récursive calculant l'emplacement et la couleur de chaque sous pyramide.
	 *
	 *	in
	 * pts	: sommets de la pyramide courrante
	 * n	: degré de récursion courrant 0 étant le cas d'arrêt
	 */
	private void	findSierpinski3DPoints(PVector[] pts, int n) {
		// Fin de recursion.
		if (n <= 0) {
			arrayCopy(pts, this._allPoints[this._posInAllTab]);
			// TODO : faire l'interpolation sur le centre au lieu du haut
			this._allColors[_posInAllTab] = this.interpolPyramidColor(findPyramidCenter(pts));
			this._posInAllTab++;
		}
		// Continuite de recursion.
		else {
			PVector[]	tmp = new PVector[4];
			// Pour chaque sommet definir la sous pyramide liee a ce sommet.
			for (int i = 0; i < 4; i++) {
				tmp[0] = pts[i];
				tmp[1] = mid2pts(pts[i], pts[(i + 1) % 4]);
				tmp[2] = mid2pts(pts[i], pts[(i + 2) % 4]);
				tmp[3] = mid2pts(pts[i], pts[(i + 3) % 4]);
				this.findSierpinski3DPoints(tmp, n - 1); // Appel recursif sur la sous pyramide.
			}
		}
	}

	/**
	 *	Procédure indiquant si le clic est au dessus d'un paramètre, si oui elle indique quel paramètre.
	 *	numérotation des variables :
	 *	1	2
	 *	3	4
	 *	5	6
	 */
	private void	checkOver(float x, float y) {
		float	nx = width / 4, ny = height / 6;
		float	nx2 = min(nx, ny) / 2;

		x = lerp(0, pgCalc.width, x / width);
		y = lerp(0, pgCalc.height, y / height);

		for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 2; j++) {
				if (x >= (2 * j + 1) * nx - nx2 && x <= (2 * j + 1) * nx + nx2)
					if (y >= (2 * i + 1) * ny - nx2 && y <= (2 * i + 1) * ny + nx2) {
						setupSelector = i * 2 + j;
						if (setupSelector >= 2) {
							selecMode = selectorMode.COLOR;
							valueSelector = color2string(startCOLORS[setupSelector - 2]);
						}
						else
							selecMode = selectorMode.NUMBER;
						return ;
					}
			}
		}
		setupSelector = -1;
		valueSelector = "";
	}

	// Public methods

	public void	draw() {
		cBack = BLACK;
		//stroke(0,0,0);
		noStroke();
		for (int i = 0;  i < pow(4, nbIte); i++) {
			fill(this._allColors[i]);
			pyramid(this._allPoints[i]);
		}
	}

	/**
	 *	Procédure affichant le menu de Sierpinski
	 */
	public void	printSetup() {
		float	nx = width / 4, ny = height / 6;
		this.setSetup(); // mise à jour du graphique

		if (sState == State.CLICKED) {
			pgGraspCalc = createGraphics(width, height/5);
			setGraspCalc();
			pgCalc.blend(pgGraspCalc, 0,0, pgGraspCalc.width,pgGraspCalc.height, 0, (pgCalc.height / 2) - (pgGraspCalc.height / 2), pgCalc.width, pgCalc.height/5, BLEND);
		}
		blend(pgCalc, 0,0, pgCalc.width,pgCalc.height, 0,0, width,height, BLEND);
	}

	
	// Inheritate protected function

	/**
	 *	Procédure mettant à jour les paramètres de l'objet.
	 */
	protected void	refresh() {
		this._startPTS = new PVector[4];
		this._posInAllTab = 0;

		float ray = sqrt(pow(size, 2) - pow(size / 2, 2)) * 2 / 3; // Calcul du rayon de la base
		this._h = sqrt(pow(size, 2) - pow(ray, 2)); // Calcul de la hauteur de la figure.
		PVector center = new PVector(0, 0, - (this._h / 3)); // Calcul du centre de la base.

		// Initialisation de la base.
		for (int i = 0; i < 3; i++) {
			this._startPTS[i] = pol2cart(center, ray,(TWO_PI * i) / 3);
		}
		// Initialisation du sommet.
		this._startPTS[3] = new PVector(0, 0, this._h * 2 / 3);
		
		// Creation des tableaux globaux.
		this._allPoints = new PVector[(int)pow(4, this.nbIte)][4];
		this._allColors = new color[(int)pow(4, this.nbIte)];

		// remplissage des tableaux.
		this.findSierpinski3DPoints(this._startPTS, this.nbIte);
	}

	/**
	 * Procédure mettant a jour l'affichage du menu
	 */
	protected void	setSetup() {
		float	nx = pgCalc.width / 4, ny = pgCalc.height / 6;
		float	nsize = min(nx, ny);

		if (pgCalc.width != width || pgCalc.height != height)
			pgCalc = createGraphics(width, height); // Nouveau graphique à la bonne taille

		pgCalc.beginDraw();
		pgCalc.clear();
		pgCalc.smooth();
		pgCalc.fill(WHITE);
		pgCalc.textSize(16);
		pgCalc.textAlign(CENTER, BOTTOM);
		// Affichage des textes
		pgCalc.text("nombre iteration :", nx, ny);
		pgCalc.text("longueur coté :", 3 * nx, ny);
		pgCalc.text("couleurs :", 2 * nx, 2 * ny);
		pgCalc.textAlign(CENTER, TOP);
		// Affichage des valeurs
		pgCalc.text(this.nbIte, nx, ny);
		pgCalc.text(this.size, 3 * nx, ny);
		// Affichage des carrés
		pgCalc.rectMode(CENTER);
		/**	Affichage des couleurs :
		 *	c1	c2
		 *	c2	c4
		 */
		for (int i = 0; i < 4; i++) {
			pgCalc.fill(this.startCOLORS[i]);
			pgCalc.rect((2 * floor(i % 2) + 1) * nx, 2 * ny + (2 * floor(i / 2) + 1) * ny, nsize, nsize);
		}
		pgCalc.endDraw();
	}

	/**
	 *	Procédure sauvegardant valueSelector dans la variable correspodnante.
	 */
	protected void	saveValue() {
		float	i = 0;
		color	c = BLACK;

		// Cast valueSelector dans le bon type.
		if (selecMode == selectorMode.NUMBER) {
			i = float(valueSelector);
		}
		else {
			FloatList 	tab = new FloatList();
			String[]	tmptab = split(valueSelector, " "); // Séparation des espaces

			for (String w : tmptab)
				tab.append(float(split(w, ","))); // Séparation des virgules
			
			if (tab.size() != 3) {
				valueSelector = "";
				return;
			}
			c = color(tab.get(0), tab.get(1), tab.get(2));
		}
		// Sauvegarde de la valeur
		switch (setupSelector) {
			case 0 :
				this.nbIte = floor(i);
				break;
			case 1 :
				this.size = i;
				break;
			case 2 :
				this.startCOLORS[0] = c;
				break;
			case 3 :
				this.startCOLORS[1] = c;
				break;
			case 4 :
				this.startCOLORS[2] = c;
				break;
			case 5 :
				this.startCOLORS[3] = c;
				break;
		}
		// Réinitialisation de valueSelector
		valueSelector = "";
	}

	/*
	 *	Procédure d'intéraction au clic, uniquement utilisé si sState vaut SETUP ou CLICKED
	 *
	 *	in
	 * x, y	: posittion x et y de la souris
	 */
	protected void	_clic(float x, float y) {
		switch (sState) {
			case CLICKED :
				if (inGraspBox(x, y))
					this.saveValue();
				sState = State.SETUP;
				valueSelector = "";
				break;
			case SETUP :
				this.checkOver(x, y);
				if (setupSelector >= 0)
					sState = State.CLICKED;
				break;
			default :
				print("error switch _clic in Sierpinski3D\n");
				break;
		}
	}

	/**
	 *	Procédure d'intéraction au scroll de souris.
	 *
	 *	in
	 * x, y	: positions de la souris
	 * val	: valeur à ajouter, négative vers l'avant de la souris
	 */
	protected void	_scroll(int x, int y, float val) {
		switch (sState) {
			case SETUP :
				// Récupère la variable à modifier
				this.checkOver(x, y);
				if (setupSelector >= 0)
					switch (selecMode) {
						case COLOR :
							// Cas d'un couleur : augmente la teinte
							int tmpc = startCOLORS[setupSelector - 2];
							float tmp = hue(tmpc) - val;
							tmp = (tmp < 0 ? 200 + tmp : tmp) % 200;
							startCOLORS[setupSelector - 2] = color(tmp, saturation(tmpc), brightness(tmpc)); // Nouvelle couleur avec la teinte augmentée
							break;
						case NUMBER :
							// Cas d'un nombre : modifie la valeur de -val
							switch (setupSelector) {
								case 0 :
									this.nbIte -= val;
									if (this.nbIte < 0)
										this.nbIte = 0;
									break;
								case 1 :
									this.size -= val;
									break;
								default :
									break;
							}
							break;
						default :
							break;
					}
				break;
			default :
				break;
		}
	}

	protected void	_key(char c) {
		switch (sState) {
			case DRAW :
				if (key == 'p' || key == 'P') {
					sState = State.SETUP;
					cBack = cMenu;
				}
				break;
			case SETUP :
				switch (c) {
					case ENTER : case 'p' : case 'P' :
						this.refresh();
						sState = State.DRAW;
						cBack = BLACK;
						break;
					default :
						break;
				}
				break;
			case CLICKED :
				switch (c) {
					case ENTER : case RETURN :
						this.saveValue();
						sState = State.SETUP;
						break;
					default :
						changeValueSelector(c);
						break;
				}
				break;
			default :
				print("error case _key() in Drawable\n");
				break;
		}
	}
}
