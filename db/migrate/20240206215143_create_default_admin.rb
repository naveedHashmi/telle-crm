class CreateDefaultAdmin < ActiveRecord::Migration[7.0]
  def change
    User.create(first_name: 'Admin', last_name: 'Chuntelle', email: 'chuntelle@orp.com', password: 'admin1234*',
                password_confirmation: 'admin1234*')
  end

  def down
    User.find_by_email('chuntelle@orp.com')&.destroy
  end
end
