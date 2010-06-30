class UploadPaperclipSupport < ActiveRecord::Migration
    def self.up
      add_column :uploads, :data_file_name,    :string
      add_column :uploads, :data_content_type, :string
      add_column :uploads, :data_file_size,    :integer
      add_column :uploads, :data_updated_at,   :datetime
    end

    def self.down
      remove_column :uploads, :data_file_name
      remove_column :uploads, :data_content_type
      remove_column :uploads, :data_file_size
      remove_column :uploads, :data_updated_at
    end
end
