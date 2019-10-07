# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Category.all.empty?
  Category.create([{ name: 'Photographie' }, { name: 'Maquillage' }, { name: 'Vidéographie' }])
end
if Subcategory.all.empty?
  Subcategory.create([{ name: 'Portrait', category_id: Category.find_by(name: 'Photographie') },
    { name: 'Évènement', category_id: Category.find_by(name: 'Photographie').id },
    { name: 'Mariage', category_id: Category.find_by(name: 'Photographie').id },
    { name: 'Cinéma', category_id: Category.find_by(name: 'Maquillage').id },
    { name: 'Mariage', category_id: Category.find_by(name: 'Maquillage').id },
    { name: 'Évènement', category_id: Category.find_by(name: 'Vidéographie').id },
    { name: 'Mariage', category_id: Category.find_by(name: 'Vidéographie').id },
    { name: 'Court-métrage', category_id: Category.find_by(name: 'Vidéographie').id },
    { name: 'Publicité', category_id: Category.find_by(name: 'Vidéographie').id },
    ])
  end
if User.all.empty?
  User.create([
    { email: 'a@a.com', firstname: 'John', lastname: 'Doe', type: 'Customer', nationality: 'French', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.', password:"password"},
    { email: 'c@c.com', firstname: 'Friedrich', lastname: 'Nikla', type: 'Customer', nationality: 'German', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.', password:"password"},
    { email: 'd@d.com', firstname: 'Patrick', lastname: 'Onatenpa', type: 'Customer', nationality: 'French', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.', password:"password"},
    { email: 'b@b.com', firstname: 'Will', lastname: 'Pioneer', type: 'Worker', price_rate: '40', nationality: 'English', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.', password:"password"},
    { email: 'e@e.com', firstname: 'Fabrice', lastname: 'Lagarde', type: 'Worker', price_rate: '60', nationality: 'French', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.', password:"password"},
    { email: 'f@f.com', firstname: 'Will', lastname: 'Smoth', type: 'Worker', price_rate: '30', nationality: 'English', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.', password:"password"},
    ])
end
if FormatDelivery.all.empty?
  FormatDelivery.create!([
    { name: 'Clé USB'},
    { name: 'DVD'},
    { name: 'Papier'},
    { name: 'Drive'},
    ])
end
if Job.all.empty?
  Job.create([
    { name: 'Shooting photo mariage week-end', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.', localisation: 'Vannes', min_price: '2000', max_price: '6000', min_time: '10', max_time: '15', category_id: Category.first.id,subcategory_id: Category.first.subcategories.first.id,format_delivery_id: FormatDelivery.first.id, customer_id: Customer.first.id },
    { name: 'Maquillage mariage week-end', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.', localisation: 'Vannes', min_price: '2000', max_price: '6000', min_time: '10', max_time: '15', category_id: Category.second.id,subcategory_id: Category.second.subcategories.first.id,format_delivery_id: FormatDelivery.second.id, customer_id: Customer.first.id },
    { name: 'Film saut en parachute', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.', localisation: 'Bastia', min_price: '2000', max_price: '6000', min_time: '10', max_time: '15', category_id: Category.last.id,subcategory_id: Category.last.subcategories.first.id,format_delivery_id: FormatDelivery.third.id, customer_id: Customer.first.id },
    { name: 'Film compétition rugby', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nisl ex, ornare accumsan enim in, ultricies venenatis risus. Vivamus sagittis est consectetur molestie molestie.', localisation: 'Montpellier', min_price: '2000', max_price: '6000', min_time: '10', max_time: '15', category_id: Category.first.id,subcategory_id: Category.first.subcategories.first.id, format_delivery_id: FormatDelivery.last.id,customer_id: Customer.first.id },
    ])
end
