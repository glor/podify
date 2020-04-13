Sequel.migration do
  change do
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:sources) do
      primary_key :id
      column :url, "text", :null=>false
      column :title, "text"
      column :downloaded_at, "timestamp without time zone"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:url], :name=>:sources_url_key, :unique=>true
    end
    
    create_table(:downloads) do
      primary_key :id
      foreign_key :source_id, :sources, :null=>false, :key=>[:id]
      column :path, "text"
      column :created_at, "timestamp without time zone", :null=>false
      column :updated_at, "timestamp without time zone", :null=>false
      
      index [:path], :name=>:downloads_path_key, :unique=>true
    end
  end
end
Sequel.migration do
  change do
    self << "SET search_path TO \"$user\", public"
    self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20200412191625_create_first_tables.rb')"
  end
end