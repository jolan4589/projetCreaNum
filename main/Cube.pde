public class Cube {
	float	x, y, z, size; // position x, y et z du centre et la longueur de ses arêtes

	Cube(float _x, float _y, float _z, float _size) {
		this.x = _x;
		this.y = _y;
		this.z = _z;
		this.size = _size;
	}

	public void	draw() {
		float	r = this.size / 2;
		
		beginShape();
		vertex(this.x + r, this.y + r, this.z + r);
		vertex(this.x - r, this.y + r, this.z + r);
		vertex(this.x - r, this.y - r, this.z + r);
		vertex(this.x + r, this.y - r, this.z + r);
		endShape(CLOSE);

		
		beginShape();
		vertex(this.x + r, this.y + r, this.z - r);
		vertex(this.x - r, this.y + r, this.z - r);
		vertex(this.x - r, this.y - r, this.z - r);
		vertex(this.x + r, this.y - r, this.z - r);
		endShape(CLOSE);

		
		beginShape();
		vertex(this.x + r, this.y + r, this.z + r);
		vertex(this.x - r, this.y + r, this.z + r);
		vertex(this.x - r, this.y + r, this.z - r);
		vertex(this.x + r, this.y + r, this.z - r);
		endShape(CLOSE);

		
		beginShape();
		vertex(this.x + r, this.y - r, this.z + r);
		vertex(this.x - r, this.y - r, this.z + r);
		vertex(this.x - r, this.y - r, this.z - r);
		vertex(this.x + r, this.y - r, this.z - r);
		endShape(CLOSE);

		
		beginShape();
		vertex(this.x + r, this.y + r, this.z + r);
		vertex(this.x + r, this.y - r, this.z + r);
		vertex(this.x + r, this.y - r, this.z - r);
		vertex(this.x + r, this.y + r, this.z - r);
		endShape(CLOSE);

		
		beginShape();
		vertex(this.x - r, this.y + r, this.z + r);
		vertex(this.x - r, this.y - r, this.z + r);
		vertex(this.x - r, this.y - r, this.z - r);
		vertex(this.x - r, this.y + r, this.z - r);
		endShape(CLOSE);
	}
}