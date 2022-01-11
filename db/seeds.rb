# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.create!([{
               name: 'Fiji Water',
               points: 14
             },
              {
                name: 'Campbell Soup',
                points: 12
              },
              {
                name: 'First Aid Pouch',
                points: 10
              },
              {
                name: 'AK47',
                points: 8
              }])
User.create!([{
               name: 'Admin',
               email: 'admin@devsinc.com',
               password: '000000',
               password_confirmation: '000000',
               gender: 'Male',
               age: 23,
               role: 'admin'
             },
              {
                name: 'Moazzam',
                email: 'moazzam.ali@devsinc.com',
                password: '000000',
                password_confirmation: '000000',
                gender: 'Male',
                age: 23,

                locations_attributes: {
                  '0': {
                    lat: 1.2323,
                    lng: 1.2323
                  }
                },

                inventories_attributes: {
                  '0': { stock: 50, item_id: 1 },
                  '1': { stock: 50, item_id: 2 },
                  '2': { stock: 50, item_id: 3 },
                  '3': { stock: 50, item_id: 4 }
                }
              },
              {
                name: 'Jamil',
                email: 'muhammad.jamil@devsinc.com',
                password: '000000',
                password_confirmation: '000000',
                gender: 'Male',
                age: 24,

                locations_attributes: {
                  '0': {
                    lat: 2.2323,
                    lng: 2.2323
                  }
                },

                inventories_attributes: {
                  '0': { stock: 60, item_id: 1 },
                  '1': { stock: 60, item_id: 2 },
                  '2': { stock: 60, item_id: 3 },
                  '3': { stock: 60, item_id: 4 }
                }
              },
              {
                name: 'Awais',
                email: 'awais.murtaza@devsinc.com',
                password: '000000',
                password_confirmation: '000000',
                gender: 'Male',
                age: 25,

                locations_attributes: {
                  '0': {
                    lat: 3.2323,
                    lng: 3.2323
                  }
                },

                inventories_attributes: {
                  '0': { stock: 70, item_id: 1 },
                  '1': { stock: 70, item_id: 2 },
                  '2': { stock: 70, item_id: 3 },
                  '3': { stock: 70, item_id: 4 }
                }
              }])
