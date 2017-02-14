public class Repoman : Gtk.Application {
	public Repoman () {
		Object(application_id: "org.repoman",
				flags: ApplicationFlags.FLAGS_NONE);
	}

	protected override void activate () {
		Gtk.ApplicationWindow window = new Gtk.ApplicationWindow (this);
		window.title = "Repository Manager";
		window.set_default_size (1024, 768);

		var headerBar = new Gtk.HeaderBar ();
		headerBar.title = "Repository Manager";
		headerBar.show_close_button = true;
		headerBar.set_subtitle ("Manage your repositories");		
		window.set_titlebar(headerBar);

		Repolist repolist = new Repolist();

        Gtk.ScrolledWindow scrollBar = new Gtk.ScrolledWindow (null,null);
		scrollBar.add (repolist);
		window.add (scrollBar);
		window.show_all ();
		
	}

	public static int main (string[] args) {
		Repoman app = new Repoman ();
		return app.run (args);
	}
}
