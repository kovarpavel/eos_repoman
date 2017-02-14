public class Repolist : Gtk.ListBox {

    private Pk.Client client;

    public Repolist() {
        client = new Pk.Client();
        buildList();
    }

    public void buildList() {
        Pk.Results repolist = client.get_repo_list(Pk.Filter.NONE,null,null);
        repolist.get_repo_detail_array().foreach((repo) => {
            Source source = new Source(repo,client);
            this.insert(source,10);
        });
    }


}
