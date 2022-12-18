class AddCityToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :city, :string, default: 'No city'
  end
end
