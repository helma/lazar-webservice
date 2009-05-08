class CreateModels < ActiveRecord::Migration
  def self.up
    create_table :models do |t|
      t.string :name
      t.boolean :regression, :default => false 
      t.integer :user_id
      t.timestamps
    end
    create_table :servers do |t|
      t.integer :pid, :model_id
      t.timestamps
    end
    create_table :users do |t|
      t.string :name, :hashed_password
      t.timestamps
    end
  end

  def self.down
    drop_table :users
    drop_table :servers
    drop_table :models
  end
end
