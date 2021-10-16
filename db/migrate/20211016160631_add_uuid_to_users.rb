class AddUuidToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :uuid, :uuid, default: "gen_random_uuid()", null: false
    rename_column :users, :id, :integer_id
    rename_column :users, :uuid, :id
    execute "ALTER TABLE users drop constraint users_pkey;"
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
    remove_column :users, :integer_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
