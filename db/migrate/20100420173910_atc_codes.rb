class AtcCodes < ActiveRecord::Migration
  def self.up
      add_column :drugs, :atc_codes, :string, :limit => 64
  end

  def self.down
      remove_column :drugs, :atc_codes
  end
end
