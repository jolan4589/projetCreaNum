PVector	pol2cart(PVector c, float ray, float angle) {
	return (new PVector(c.x + ray * cos(angle), c.y + ray * sin(angle), c.z));
}

void	vertex(PVector p) {
	vertex(p.x, p.y, p.z);
}

void	drawCircle(PVector c, float ray) {
	strokeWeight(15);
	stroke(0,100,100);
	float step = TWO_PI / 100;
	for (int i = 0; i < 100; i++) {
		PVector p = pol2cart(c, i * step, ray);
		point(p.x, p.y, p.z);
	}
}