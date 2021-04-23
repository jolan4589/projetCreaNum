/**
 *	Fonction affichant le menu initial d'explication
 */
void	startMenu() {
	int nlines = 6;
	pgCalc.beginDraw();
	pgCalc.clear();
	pgCalc.fill(255,255,255);
	pgCalc.smooth();
	pgCalc.textSize(16);
	pgCalc.textAlign(CENTER);
	pgCalc.text("PROJET CREATION NUMERIQUE", pgCalc.width/2, pgCalc.height/(nlines + 1)); 
	pgCalc.text("RIALLOT JOLAN ET DUONG ANTOINE", pgCalc.width/2, pgCalc.height/(nlines + 1) * 2);
	pgCalc.text("LEFT RIGHT POUR CHANGER DE MODE", pgCalc.width/2, pgCalc.height/(nlines + 1) * 3);
	pgCalc.text("APPUYER SUR P POUR OUVRIR LES PARAMETRES", pgCalc.width/2, pgCalc.height/(nlines + 1) * 4);
	pgCalc.text("LIRE LE READ ME POUR PLUS DE DETAILS", pgCalc.width/2, pgCalc.height/(nlines + 1) * 5);
	pgCalc.text("CLIQUER OU APPUYER SUR UNE TOUCHE POUR CONTINUER", pgCalc.width/2, pgCalc.height/(nlines + 1) * 6);
	pgCalc.endDraw();
	blend(pgCalc, 0,0, pgCalc.width,pgCalc.height, 0,0, width,height, SUBTRACT);
}




/**
 *	Fonction calculant la position carthesienne d'un point a partir de sa representation polaire.
 *
 *	in
 * c	: point centrale de la rotation
 * ray	: distance entre le centre et le point cherche
 * angle	: rotation a effectuer
 *
 *	out : equivalant polaire du l entree
 */
PVector	pol2cart(PVector c, float ray, float angle) {
	return(new PVector(c.x + ray * cos(angle), c.y + ray * sin(angle), c.z));
}

/**
 *	Procedure appelant vertex() sur chaque composante d'un vecteur.
 *
 *	in
 * p	: PVecteur du point a ajouter a la forme
 */
void	vertex(PVector p) {
	vertex(p.x, p.y, p.z);
}

/**
 *	Fonction calculant le milieux de deux points.
 *
 *	in
 * p1, p1	: points dont on cherche le milieux
 *
 *	out : PVector milieux des points d'entree
 */
PVector	mid2pts(PVector p1, PVector p2) {
	return(new PVector((p2.x + p1.x) / 2, (p2.y + p1.y) / 2, (p2.z + p1.z) / 2));
	// return PVector.lerp(p1, p2, 0.5);
}

/**
 *	Procedure dessinant un triangle.
 *
 *	in
 * p1, p2, p3	: les sommets du triangle
 */
void	triangle(PVector p1, PVector p2, PVector p3) {
	beginShape();
	vertex(p1);
	vertex(p2);
	vertex(p3);
	endShape(CLOSE);
}

/**
 *	Procedure dessinant une pyramide
 *
 *	in
 * pts	: liste contenant les sommets de la pyramide
 */
void	pyramid(PVector[] pts) {
	for (int i = 0; i < 4; i++) {
		triangle(pts[i], pts[(i + 1) % 4], pts[(i + 2) % 4]);
	}
}

/**
 *	Procedure dessinant une pyramide
 *
 *	in
 * p1, p2, p3, p4	: les sommets de la pyramdies
 */
void	pyramid(PVector p1, PVector p2, PVector p3, PVector p4) {
	triangle(p1, p2, p3);
	triangle(p1, p3, p4);
	triangle(p1, p4, p2);
	triangle(p2, p3, p4);
}

/**
 *	Fonction cherchant de point le plus haut parmis une liste de points.
 *
 *	in
 * pts	: lise dont on cherche a determiner le point le plus haut
 *
 *	out	: indice du point premier point le plus haut de la liste
 */
int		findTop(PVector[] pts) {
	int	top = 0;
	for (int i = 1; i < pts.length	; i++)
		if (pts[i].z > pts[top].z)
			top = i;
	return (top);
}

PVector	findPyramidCenter(PVector[] pts) {
	PVector	midBase = PVector.lerp(pts[0], pts[1], 0.5);
	PVector	mid = PVector.lerp(midBase, pts[2], 1/3);
	return(PVector.lerp(mid, pts[3], 1/3));
}

/**
 *	Fonction retournant une couleur +- aléatoire
 *
 *	out : couleur aléatoire
 */
color	randomColor() {
	colorMode(HSB, 200);
	return(color(random(200), random(200), random(80, 200)));
}

/**
 *	Fonction calculant de vecteur relatif a la translation de deux points.
 *
 *	in
 * p1	: point de depart de la translation
 * p2	: point de d'arrive de la translation
 *
 *	out	: PVecteur représentant la translation p1->p2
 */
PVector point2vector(PVector p1, PVector p2) {
	return (new PVector(p2.x - p1.x, p2.y - p1.y, p2.z - p1.z));
}

/**
 *	Fonction vérifiant si un caractère est une entrée valide pour valueSelector.
 *
 *	in
 * c	: caractère à tester
 *
 *	out  : vrai si le caractère satisfait les conditions, faut sinon
 */
boolean	isValideInpute(char c) {
	if ((c >= '0' && c <= '9') || c == '.')
		return (true);
	if (selecMode == selectorMode.COLOR && (c == ' ' || c == ','))
		return (true);
	return false;
}

/**
 *	Fonction renvoyant vrai si x et y sont dans le cadre de saisie.
 */
boolean	inGraspBox(float x, float y) {
	return (x >= 0 && x <= width && y >= (height / 2) - (height / 10) && y <= (height / 2) + (height / 10));
}

/**
 *	Fonction transformant une couleur en une chaine de caractères de la forme "H S B"
 */
String	color2string(color c) {
	return (hue(c) + " " + saturation(c) + " " + brightness(c));
}


/**
*	Procédure mettant à jour pgGraspCalc();
*/
void	setGraspCalc() {
	pgGraspCalc.beginDraw();
	pgGraspCalc.clear();
	pgGraspCalc.fill(tab ? WHITE : BLACK);
	pgGraspCalc.background(tab ? BLACK : WHITE);
	pgGraspCalc.textSize(16);
	pgGraspCalc.textAlign(CENTER, CENTER);
	pgGraspCalc.text(valueSelector, pgGraspCalc.width / 2, pgGraspCalc.height / 2);
	pgGraspCalc.endDraw();
}

/**
 *	Procédure modifiant la valeur de valueSelector.
 *
 *	in
 * c	: Caractère traité pour modifier la chaîne de caractères.
 */
void	changeValueSelector(char c) {
	switch (c) {
		case BACKSPACE :
			if (valueSelector.length() > 0) {
				if (ctrl) // Supression totale.
					valueSelector = "";
				else if ((maj && !tab) || (!maj && tab)) // Supression du premier caractère.
					valueSelector = valueSelector.substring(1);	
				else // Supression du dernier caractère.
					valueSelector = valueSelector.substring(0, valueSelector.length() - 1);	
			}
			break;
		default :
			if (isValideInpute(c)) // Ajoute d'un caractère.
				valueSelector = tab ? c + valueSelector : valueSelector + c;
			break;
	}
}

void	nextTemplate() {
	templateId++;
	templateId %= templates.size();
}

void	preTemplate() {
	templateId--;
	while (templateId < 0)
		templateId = templates.size() + templateId;
	templateId %= templates.size();
}