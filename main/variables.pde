//drawable	template;
PeasyCam	cam;
State	sState;	// Etat courrant du programme
color	cBack; // couleur du fond
color	cMenu = #908D8D; // Couleur grize du fond menu
color	BLACK = #000000, WHITE = #FFFFFF;
PGraphics	pgCalc; // Fenetre abstraite pour afficher en 2D
PGraphics	pgGraspCalc; // Calc pour la zone de saisie
Drawable	template; // Template en cours d'utilisation
selectorMode	selecMode; // Selecteur de mode de modification de variable
String		valueSelector;	// valeur qui doit remplacer celle choisi
int			setupSelector; // valeur du selecteur correspondant à la variable à modifier

// Enum représentant les états du programme
enum	State {
	START,
	DRAW,
	SETUP,
	CLICKED
}

// Enum pour les types d'intéractions
enum	interactionType {
	CLIC,
	SCROLL,
	KEY
}

// Enum pour les types de variables à modifier
enum	selectorMode {
	COLOR,
	NUMBER
}