import peasy.*;

void	setup() {
	size(500, 500, P3D);
	surface.setResizable(true);
	cam = new PeasyCam(this, 200);
	pgCalc = createGraphics(width,height);
	pgGraspCalc = createGraphics(width,height);
	valueSelector = "";
	setupSelector = -1;
	ctrl = false;
	maj = false;
	tab = false;

	sState = State.START;
	cBack = cMenu;

	templates = new ArrayList<Drawable>();
	templateId = 0;

	templates.add(new Sierpinski3D());
	templates.add(new SierpinskiCube());
	templates.add(new DiskStripe());
	templates.add(new Bowl());
}


void	draw() {
	background(cBack);
	switch (sState) {
		case DRAW :
			templates.get(templateId).draw();
			break;
		case SETUP : case CLICKED :
			templates.get(templateId).printSetup();
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
	if (keyCode == 16)
		maj = true;
	else if (keyCode == 17)
		ctrl = true;
	else if (key == TAB)
		tab = !tab;
	switch (sState) {
		case DRAW :
			if (keyCode == LEFT)
				nextTemplate();
			else if (keyCode == RIGHT)
				preTemplate();
			else
				templates.get(templateId).interaction(interactionType.KEY, 0,0, 0, key);
			break;
		case SETUP : case CLICKED :
			templates.get(templateId).interaction(interactionType.KEY, 0,0, 0, key);
			break;
		case START :
			sState = State.DRAW;
			break;
		default :
			print("error");
			break;
	}
}

void	keyReleased() {
	if (keyCode == 16)
		maj = false;
	else if (keyCode == 17)
		ctrl = false;
}

void	mouseClicked() {
	switch (sState) {
		case DRAW :
			break;
		case SETUP : case CLICKED :
			templates.get(templateId).interaction(interactionType.CLIC, mouseX, mouseY, 0, '\0');
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
			templates.get(templateId).interaction(interactionType.SCROLL, mouseX, mouseY, e, '\0');
			break;
		default :
			print("error");
			break;
	}
}
