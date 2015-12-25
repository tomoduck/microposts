class AddAboutSelfToUser < ActiveRecord::Migration
  def change
    add_column :users, :about_self, :string
  end
end
