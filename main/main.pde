import peasy.*;

void	setup() {
	size(500, 500, P3D);
	surface.setResizable(true);
	cam = new PeasyCam(this, 200);
	pgCalc = createGraphics(500,500);
	pgGraspCalc = createGraphics(500,100);
	valueSelector = "";
	setupSelector = -1;

	sState = State.START;
	cBack = cMenu;

	template = new Sierpinsky3D();
}


void	draw() {
	background(cBack);
	switch (sState) {
		case DRAW :
			template.draw();
			break;
		case SETUP : case CLICKED :
			template.printSetup();
			break;
		case START :
			startMenu();
			break;
		default :
			print("error");
			break;
	}
}

void	keyPressed() {
	switch (sState) {
		case DRAW : case SETUP : case CLICKED :
			template.interaction(interactionType.KEY, 0,0, 0, key);
			break;
		case START :
			sState = State.DRAW;
			break;
		default :
			print("error");
			break;
	}
}

void	mouseClicked() {
	switch (sState) {
		case DRAW :
			break;
		case SETUP : case CLICKED :
			template.interaction(interactionType.CLIC, mouseX, mouseY, 0, '\0');
			break;
		case START :
			sState = State.DRAW;
			break;
		default :
			print("error");
			break;
	}
}

void mouseWheel(MouseEvent event) {
	float e = event.getCount();
	switch (sState) { 
		case DRAW : case START :
			break;
		case SETUP :
			template.interaction(interactionType.SCROLL, mouseX, mouseY, e, '\0');
			break;
		default :
			print("error");
			break;
	}
}