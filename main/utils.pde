PVector	pol2cart(PVector c, float ray, float angle) {
	return (new PVector(c.x + ray * cos(angle), c.y + ray * sin(angle), c.z));
}

void	vertex(PVector p) {
	vertex(p.x, p.y, p.z);
}