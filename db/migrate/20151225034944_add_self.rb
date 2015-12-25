class AddSelf < ActiveRecord::Migration
  def change
    add_column :name, :email,:password,:password_confirmation
  end
end
