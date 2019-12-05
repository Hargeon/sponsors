# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Industry.find_or_create_by(name: 'Education')
Industry.find_or_create_by(name: 'Media')
Industry.find_or_create_by(name: 'Medical')
Industry.find_or_create_by(name: 'Trade')
Industry.find_or_create_by(name: 'Ecommerce')
Industry.find_or_create_by(name: 'Helthcare')
Industry.find_or_create_by(name: 'Industrial')
Industry.find_or_create_by(name: 'Military')

District.find_or_create_by(name: 'Europe')
District.find_or_create_by(name: 'Asia')
District.find_or_create_by(name: 'Global')
District.find_or_create_by(name: 'Australia')
District.find_or_create_by(name: 'North America')
District.find_or_create_by(name: 'South America')
District.find_or_create_by(name: 'Africa')

Member.find_or_create_by(name: 'CEO')
Member.find_or_create_by(name: 'CTO')
Member.find_or_create_by(name: 'Programmer')
Member.find_or_create_by(name: 'System administrator')

RequireHelp.find_or_create_by(name: 'Funding')
RequireHelp.find_or_create_by(name: 'Mentoring')
RequireHelp.find_or_create_by(name: 'Marketing strategy')
RequireHelp.find_or_create_by(name: 'Investment manager')
RequireHelp.find_or_create_by(name: 'Operational assistance')
