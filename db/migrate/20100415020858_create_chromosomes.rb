class CreateChromosomes < ActiveRecord::Migration
  def self.up
    create_table :chromosomes do |t|
		t.integer	:number, :null => false
		t.string	:import_code, :null => false
      t.timestamps
    end
	add_index	:chromosomes, :import_code
	for n in 1..23 do
		execute "INSERT INTO chromosomes (id, number, import_code) VALUES (#{n}, #{n}, 'chr#{n}')"
	end
  end

  def self.down
	remove_index :chromosomes, :import_code
    drop_table :chromosomes
  end
end
