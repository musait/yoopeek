# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Subcategory.all.empty?
  Subcategory.create([
    { name: 'Portrait' },
    { name: 'Évènement'},
    { name: 'Mariage' },
    { name: 'Cinéma'},
    { name: 'Court-métrage'},
    { name: 'Publicité'},
    ])
  end
if Category.all.empty?
  Category.create([{ name: 'Photographie' }, { name: 'Maquillage' }, { name: 'Vidéographie' }])
end
if Profession.all.empty?
  Profession.create([{ name: 'Photographe' }, { name: 'Vidéographe' }])
end

if User.all.empty?
   User.create!([
    {confirmed_at: Time.now.utc,approved: true,email: 'yoopeek@yoopeek.com', firstname: 'Yoopeek', lastname: 'Yoopeek',is_worker: true, type: 'Worker',price_rate: '', nationality: '', description: '', password:"password"},
    {confirmed_at: Time.now.utc,approved: true,email: 'a@a.com', firstname: 'new', lastname: 'client',is_worker: false, type: 'Customer',price_rate: '', nationality: '', description: '', password:"password"}])
end
if Admin.all.empty?
  Admin.create!({  confirmed_at: Time.now.utc,approved: true,firstname:"admin",is_worker: false,lastname:"admin",email:"admin@admin.com",password:"password"})
end
if FormatDelivery.all.empty?
  FormatDelivery.create!([
    { name: 'Clé USB'},
    { name: 'DVD'},
    { name: 'Papier'},
    { name: 'Drive'},
    ])
end
if CreditsOffer.all.blank?
    CreditsOffer.create([
      {credits: 10, price: 8, reduction: nil},
      {credits: 20, price: 15, reduction: 5},
      {credits: 50, price: 35, reduction: 12.5},
      {credits: 100, price: 65, reduction: 18},
      {credits: 500, price: 300, reduction: 25},
      {credits: 1000, price: 500, reduction: 37.5},
    ])
end
