Drawable[]	list;

void	setup() {
	size(500, 500, P2D);
	list = new Drawable[1];
	list[0] = new DiskStripe(width/2, height/2, 1);
}

void	draw() {
	list[0].draw();
}
