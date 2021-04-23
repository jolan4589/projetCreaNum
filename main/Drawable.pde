public abstract class Drawable {
	abstract protected void	_clic(float x, float y);
	abstract protected void	_scroll(int x, int y, float val);
	abstract protected void	_key(char c);
	abstract protected void	refresh(); // met à jour l'objet.
	abstract protected void	setSetup(); // Met à jour le graphique d'affichage 2D avec le menu correspondant.
	abstract protected void saveValue(); // Sauvegarde de la valeur saisie par l'utilisateur dans la variable correspondante.

	abstract public void	draw(); // Affichage de l'objet.
	abstract public void	printSetup(); // Affichage du menu de l'objet.

	/**
	 *	Procédure servant à répartir les intéraction entre les différentes procédures d'intéractions.
	 *
	 *	in
	 * type	: Type d'intéraction cf enum interactionType.
	 * x, y	: Position x et y de la souris.
	 * val	: Nombre de cran parcouru par la molette.
	 * c	: Caractère saisi.
	 */
	public void	interaction(interactionType type, int x, int y, float val, char c) {
		switch (type) {
			case CLIC :
				this._clic(x, y);
				break;
			case SCROLL :
				this._scroll(x, y, val);
				break;
			case KEY :
				this._key(c);
				break;
			default :
				print("Error interaction");
		}
	}
}
