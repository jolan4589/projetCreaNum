public abstract class Drawable {
	abstract protected void	_clic(float x, float y);
	abstract protected void	_scroll(float val);
	abstract protected void	_key(char c);
	abstract protected void	refresh();
	abstract protected void	setSetup();
	abstract protected void saveValue();

	abstract public void	draw();
	abstract public void	printSetup();

	public void	interaction(interactionType type, int x, int y, float val, char c) {
		switch (type) {
			case CLIC :
				this._clic(x, y);
				break;
			case SCROLL :
				this._scroll(val);
				break;
			case KEY :
				this._key(c);
				break;
			default :
				print("Error interaction");
		}
	}
}
