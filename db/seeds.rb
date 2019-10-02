# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create([{ name: 'Photographie' }, { name: 'Maquillage' }, { name: 'Vidéographie' }])
UnderCategory.create([{ name: 'Portrait', category_id: Category.find_by(name: 'Photographie') },
  { name: 'Évènement', category_id: Category.find_by(name: 'Photographie') },
  { name: 'Mariage', category_id: Category.find_by(name: 'Photographie') },
  { name: 'Cinéma', category_id: Category.find_by(name: 'Maquillage') },
  { name: 'Mariage', category_id: Category.find_by(name: 'Maquillage') },
  { name: 'Évènement', category_id: Category.find_by(name: 'Vidéographie') },
  { name: 'Mariage', category_id: Category.find_by(name: 'Vidéographie') },
  { name: 'Court-métrage', category_id: Category.find_by(name: 'Vidéographie') },
  { name: 'Publicité', category_id: Category.find_by(name: 'Vidéographie') },
  ])
User.create([
  { email: 'a@a.com', firstname: 'John', lastname: 'Doe', type: 'User', nationality: 'French', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.'},
  { email: 'b@b.com', firstname: 'Will', lastname: 'Pioneer', type: 'Worker', PriceRate: '40', nationality: 'English', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.'}
  ])
