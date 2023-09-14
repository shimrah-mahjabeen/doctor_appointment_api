class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table(:users) do |t|
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      t.string  :type
      t.string :name
      t.string :email
      t.json :tokens

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
