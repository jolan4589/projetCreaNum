import peasy.*;

Drawable[]	list;
color		backgroundC;
int			template;
PeasyCam	cam;

void	setup() {
	size(500, 500, P3D);
	cam = new PeasyCam(this, 200);

	PVector[] tmp = new PVector[3];
	tmp[0] = new PVector(0, 0, 0);
	tmp[1] = new PVector(50, 50, 50);
	tmp[2] = new PVector(0, 0, -50);
	float[] tmp2 = new float[3];
	float[] tmp3 = new float[3];
	color[] tmp4 = new color[3];
	tmp2[0] = 80;
	tmp2[1] = 200;
	tmp2[2] = 50;
	tmp3[0] = 0;
	tmp3[1] = 0;
	tmp3[2] = 0;
	tmp4[0] = color(100,0,0);
	tmp4[1] = color(0,0,0);
	tmp4[1] = color(0,0,0);

	list = new Drawable[2];
	list[0] = new DiskStripe(3, 10, 0.3, color(100, 50, 50), tmp, tmp2, tmp3, tmp4);
	list[1] = new Test();

	template = 0;
}

void	draw() {
	background(backgroundC);
	list[template].draw();
}

void	mousePressed() {
	// template = (template + 1) % 2;
}