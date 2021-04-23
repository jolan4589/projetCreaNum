//drawable	template;
PeasyCam	cam;

State	sState;	// Etat courrant du programme
color	cBack; // couleur du fond
color	cMenu = #908D8D; // Couleur grize du fond menu
color	BLACK = #000000, WHITE = #FFFFFF;

PGraphics	pgCalc; // Fenetre abstraite pour afficher en 2D
PGraphics	pgGraspCalc; // Calc pour la zone de saisie

ArrayList<Drawable> templates; // Liste des objets possible
int					templateId;

selectorMode	selecMode; // Selecteur de mode de modification de variable
String		valueSelector;	// valeur qui doit remplacer celle choisi
int			setupSelector; // valeur du selecteur correspondant à la variable à modifier
boolean		ctrl, maj, tab;

/**	Enum représentant les états du programme.
 *	START		: écran d'acceuil
 *	DRAWDRAW	: écran de dessin
 *	SETUP		: écran de paramètre
 *	CLICKED		: fenêtre de saisie dans les paramètres
 */
enum	State {
	START,
	DRAW,
	SETUP,
	CLICKED
}

/**	Enum pour les types d'intéractions.
 *	CLIC	: action de clic droit, gauche et molette
 *	SCROLL	: action rouller la molette
 *	KEY		: action d'appuyer sur une touche du clavier
 */
enum	interactionType {
	CLIC,
	SCROLL,
	KEY
}

/**	EEnum pour indiquer types de variables à modifier.
 *	COLOR	: variable homonyme
 *	NUMBER	: variables int et float
 */
enum	selectorMode {
	COLOR,
	NUMBER
}