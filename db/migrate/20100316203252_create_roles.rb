class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table "roles" do |t|
      t.string :code,	:null => false,	:limit => 16
      t.string :name,	:null => false,	:limit => 16
    end
    
    # generate the join table
    create_table "roles_users", :id => false do |t|
      t.integer	:role_id,	:null => false
		t.integer	:user_id,	:null => false
    end
    add_index "roles_users", "role_id"
    add_index "roles_users", "user_id"
  end

  def self.down
    drop_table "roles"
    drop_table "roles_users"
  end
end