class AddAuthenticationTokenToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :authentication_token, :string
  	add_index :users, :authentication_token, :unique => true

  	User.find_each do |u|   # 用于消除此前user没有authentication_token的尴尬
  		puts "generate user #{u.id} token"
  		u.generate_authentication_token
  		u.save!
  	end
  end
end
