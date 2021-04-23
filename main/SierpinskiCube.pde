  public class	SierpinskiCube extends Drawable {
	
	private int		nbIte;			 // nombre de recursions positif ou nul, 0 -> 1 pyramide, 1 -> 4 pyramides, ...
	private int		_posInAllTab;	// position, dans le tableau général, de la pyramide en construction
	private float	size;			// taille des aretes
	private Cube[]	_allCubes;		// tableau général des pyramides
	private color[]		_allColors;		// tableau des couleurs correspondant aux pyramides
	private color[]		startCOLORS;	// couleurs de la pyramide de départ

	// Custructor

	public	SierpinskiCube() {
		build(1, 200, randomColor(), randomColor(), randomColor(), randomColor(), randomColor(), randomColor(), randomColor(), randomColor());
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
	private color	interpolCubeColor(Cube current) {
		float	xadv, yadv, zadv;
		float	nsize;
		color	tmp, tmp1, tmp2;

		nsize = this.size / 2;
		xadv = (float)(current.x + nsize) / (float)size;
		yadv = (float)(current.y + nsize) / (float)size;
		zadv = (float)(current.z + nsize) / (float)size;
		// En cas d'avancement a 0 le code renvoit du noir,
		// on le remplace par la couleur du haut de la pyramide initiale
		if (xadv == 0 && yadv == 0 && zadv == 0) {
			return (startCOLORS[0]);
		}
		tmp = lerpColor(startCOLORS[0], startCOLORS[1], xadv);
		tmp1 = lerpColor(startCOLORS[2], startCOLORS[3], xadv);
		tmp2 = lerpColor(tmp, tmp1, zadv);

		tmp = lerpColor(startCOLORS[4], startCOLORS[5], xadv);
		tmp1 = lerpColor(startCOLORS[6], startCOLORS[7], xadv);
		tmp1 = lerpColor(tmp, tmp1, zadv);

		return(lerpColor(tmp2, tmp1, yadv));
	}

	/**
	 *	Procédure récursive calculant l'emplacement et la couleur de chaque sous pyramide.
	 *
	 *	in
	 * pts	: sommets de la pyramide courrante
	 * n	: degré de récursion courrant 0 étant le cas d'arrêt
	 */
	private void	findSierpinskiCubes(Cube current, int n) {
		// Fin de recursion.
		if (n <= 0) {
			this._allCubes[_posInAllTab] = current;
			this._allColors[_posInAllTab] = this.interpolCubeColor(current);
			this._posInAllTab++;
		}
		// Continuite de recursion.
		else {
			float nsize = current.size / (float)2;
			this.findSierpinskiCubes(new Cube(current.x + nsize, current.y + nsize, current.z + nsize, nsize), n - 1);
			this.findSierpinskiCubes(new Cube(current.x + nsize, current.y + nsize, current.z - nsize, nsize), n - 1);
			this.findSierpinskiCubes(new Cube(current.x + nsize, current.y - nsize, current.z + nsize, nsize), n - 1);
			this.findSierpinskiCubes(new Cube(current.x + nsize, current.y - nsize, current.z - nsize, nsize), n - 1);
			this.findSierpinskiCubes(new Cube(current.x - nsize, current.y + nsize, current.z + nsize, nsize), n - 1);
			this.findSierpinskiCubes(new Cube(current.x - nsize, current.y + nsize, current.z - nsize, nsize), n - 1);
			this.findSierpinskiCubes(new Cube(current.x - nsize, current.y - nsize, current.z + nsize, nsize), n - 1);
			this.findSierpinskiCubes(new Cube(current.x - nsize, current.y - nsize, current.z - nsize, nsize), n - 1);
			this.findSierpinskiCubes(new Cube(current.x, current.y, current.z, nsize), n - 1);
		}
	}

	/**
	 *	Procédure indiquant si le clic est au dessus d'un paramètre, si oui elle indique quel paramètre.
	 *	numérotation des variables :
	 *	1		2
	 *	3	4	7	8
	 *	5	6	9	10
	 */
	private void	checkOver(float x, float y) {
		float	nx = pgCalc.width / 8, ny = pgCalc.height / 8;
		float	nsize = min(nx, ny) / 2;

		x = lerp(0, pgCalc.width, x / width);
		y = lerp(0, pgCalc.height, y / height);

		if ( y >= ny - nsize && y <= ny + nsize ) {
			if ( x >= 2 * nx - nsize && x <= 2 * nx + nsize ) {
				selecMode = selecMode.NUMBER;
				setupSelector = 0;
				return ;
			}
			if ( x >= 6 * nx - nsize &&  x <= 6 * nx + nsize ) {
				selecMode = selecMode.NUMBER;
				setupSelector = 1;
				return ;
			}
		}
		for (int i = 0; i < 2; i++) {
			for (int j = 0; j < 4; j++) {
				if ( y >= ( 2 * floor(j / 2) + 4 ) * ny - nsize &&
					y <= ( 2 * floor(j / 2) + 4 ) * ny + nsize &&
					x >= ( 2 * floor(j % 2) + 1 + i * 4 ) * nx - nsize &&
					x <= ( 2 * floor(j % 2) + 1 + i * 4 ) * nx + nsize
				) {
					selecMode = selectorMode.COLOR;
					setupSelector = 2 + j + 4 * i;
					valueSelector = color2string(this.startCOLORS[4 * i + j]);
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
		for (int i = 0;  i < pow(9, nbIte); i++) {
			fill(this._allColors[i]);
			this._allCubes[i].draw();
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
		this._posInAllTab = 0;

		// Creation des tableaux globaux.
		this._allCubes = new Cube[(int)pow(9, this.nbIte)];
		this._allColors = new color[(int)pow(9, this.nbIte)];

		// Remplissage des tableaux;
		this.findSierpinskiCubes(new Cube(0, 0, 0, this.size), this.nbIte);
	}

	/**
	 * Procédure mettant a jour l'affichage du menu
	 */
	protected void	setSetup() {
		float	nx = pgCalc.width / 8, ny = pgCalc.height / 8;
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
		pgCalc.text("nombre iteration :", 2 * nx, ny);
		pgCalc.text("longueur coté :", 6 * nx, ny);
		pgCalc.text("couleurs :", 4 * nx, 2 * ny);
		pgCalc.textAlign(CENTER, TOP);
		// Affichage des valeurs
		pgCalc.text(this.nbIte, 2 * nx, ny);
		pgCalc.text(this.size, 6 * nx, ny);
		// Affichage des carrés
		pgCalc.rectMode(CENTER);
		/**	Affichage des couleurs :
		 *	c1	c2 | c5	c6
		 *	c3	c4 | c7	c8
		 */
		for (int i = 0; i < 4; i++) {
			pgCalc.fill(this.startCOLORS[i]);
			pgCalc.rect((2 * floor(i % 2) + 1) * nx, 3 * ny + (2 * floor(i / 2) + 1) * ny, nsize, nsize);
			
			pgCalc.fill(this.startCOLORS[i + 4]);
			pgCalc.rect(pgCalc.width / 2 + (2 * floor(i % 2) + 1) * nx, 3 * ny + (2 * floor(i / 2) + 1) * ny, nsize, nsize);
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
			case -1:
				break;
			case 0 :
				this.nbIte = floor(i);
				break;
			case 1:
				this.size = i;
				break;
			default :
				this.startCOLORS[setupSelector - 2] = c;
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
