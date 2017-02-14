public class Source : Gtk.Box {
    
    private Pk.RepoDetail repository;
    private Pk.Client client;

    public Source(Pk.RepoDetail repository, Pk.Client client) {
        Object(orientation: Gtk.Orientation.HORIZONTAL, spacing: 10);
        this.repository = repository;
        this.client = client;
        this.set_border_width(5);

        Gtk.Switch enabled = new Gtk.Switch();
        enabled.set_active(this.repository.get_enabled());
        enabled.notify["active"].connect( () => {
            client.repo_enable(repository.repo_id,enabled.get_state(),null,null);
            });
    
        this.pack_start(enabled,false,false,10);
        this.pack_start(new Gtk.Label(get_repo_name()),false,false,10);

        Gtk.Button remove = new Gtk.Button.from_icon_name("edit-delete",Gtk.IconSize.BUTTON);
        remove.clicked.connect(() => {
            Pk.Bitfield bitfield = 0;
            client.repo_remove(bitfield,repository.repo_id,false,null,null);
            this.destroy();
        });

        this.pack_end(remove,false,false,10);
    }

    private string get_repo_name() {
        return repository.repo_id.substring(repository.repo_id.index_of(":") + 1);
    }

}
