# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Education', 'Media', 'Trade', 'Ecommerce', 'Helthcare', 'Industrial', 'Military'].each { |name| Industry.find_or_create_by!(name: name) }
['Europe', 'Asia', 'Global', 'Australia', 'North America', 'South America', 'Africa'].each { |name| District.find_or_create_by!(name: name) }
['CEO', 'CTO', 'Programmer', 'System administrator'].each { |name| Member.find_or_create_by!(name: name) }
['Funding', 'Mentoring', 'Marketing strategy', 'Investment manager', 'Operational assistance'].each { |name| RequireHelp.find_or_create_by!(name: name) }
