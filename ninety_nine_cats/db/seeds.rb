# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all
ApplicationRecord.connection.reset_pk_sequence!("cats")
ApplicationRecord.connection.reset_pk_sequence!("cat_rental_requests")

Cat.create(name: 'Magic Man', birth_date: '2010/04/20', color: 'wild', sex: 'A')
Cat.create(name: 'Nemo', birth_date: '1945/04/20', color: 'black', sex: 'M')
Cat.create(name: 'Ozwald', birth_date: '2016/12/25', color: 'white', sex: 'Q')

CatRentalRequest.create(cat_id: 2, start_date: '2016/12/25', end_date: '2016/12/30')