# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Subcategory.all.empty?
  Subcategory.create([
    { name: 'Mode' },
    { name: 'Portrait'},
    { name: 'Naissance' },
    { name: 'EVJF'},
    { name: 'Mariage'},
    { name: 'Grossesse'},
    { name: 'Baptème'},
    { name: 'Anniversaire'},
    { name: 'Couple'},
    { name: 'Famille'},
    { name: 'Evènementiel'},
    { name: 'Barmitzvah/Batmitzvah'},
    { name: 'Entreprise (Corporate)'},
    { name: 'Culinaire'},
    { name: 'Immobilier'},
    { name: 'Packshot Produit'},
    { name: 'Animalier'},
    { name: 'Vlog'},
    { name: 'Vidéo Clip Musique'},
    { name: 'Cinéma (Court, Moyen, Long Métrage)'},

    ])
  end
if Category.all.empty?
  Category.create([{ name: 'Photographe' }, { name: 'Stylisme' }, { name: 'Vidéo' },{ name: 'Maquillage'},{ name: 'Coiffure'},{ name: 'Drone'}])

  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Mode")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Portrait")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Naissance")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"EVJF")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Mariage")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Grossesse")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Baptème")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Anniversaire")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Couple")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Famille")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Evènementiel")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Immobilier")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Barmitzvah/Batmitzvah")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Entreprise (Corporate)")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Culinaire")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Packshot Produit")
  Category.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Animalier")

  Category.find_by(name:"Drone").subcategories << Subcategory.find_by(name:"Evènementiel")
  Category.find_by(name:"Drone").subcategories << Subcategory.find_by(name:"Immobilier")
  Category.find_by(name:"Drone").subcategories << Subcategory.find_by(name:"Entreprise (Corporate)")
  Category.find_by(name:"Drone").subcategories << Subcategory.find_by(name:"Vlog")
  Category.find_by(name:"Drone").subcategories << Subcategory.find_by(name:"Vidéo Clip Musique")
  Category.find_by(name:"Drone").subcategories << Subcategory.find_by(name:"Mariage")
  Category.find_by(name:"Drone").subcategories << Subcategory.find_by(name:"Cinéma (Court, Moyen, Long Métrage)")


  Category.find_by(name:"Coiffure").subcategories << Subcategory.find_by(name:"Evènementiel")
  Category.find_by(name:"Coiffure").subcategories << Subcategory.find_by(name:"Mode")
  Category.find_by(name:"Coiffure").subcategories << Subcategory.find_by(name:"Portrait")
  Category.find_by(name:"Coiffure").subcategories << Subcategory.find_by(name:"Baptème")
  Category.find_by(name:"Coiffure").subcategories << Subcategory.find_by(name:"Anniversaire")
  Category.find_by(name:"Coiffure").subcategories << Subcategory.find_by(name:"Couple")
  Category.find_by(name:"Coiffure").subcategories << Subcategory.find_by(name:"Famille")
  Category.find_by(name:"Coiffure").subcategories << Subcategory.find_by(name:"EVJF")
  Category.find_by(name:"Coiffure").subcategories << Subcategory.find_by(name:"Mariage")

  Category.find_by(name:"Maquillage").subcategories << Subcategory.find_by(name:"Evènementiel")
  Category.find_by(name:"Maquillage").subcategories << Subcategory.find_by(name:"Mode")
  Category.find_by(name:"Maquillage").subcategories << Subcategory.find_by(name:"Portrait")
  Category.find_by(name:"Maquillage").subcategories << Subcategory.find_by(name:"Baptème")
  Category.find_by(name:"Maquillage").subcategories << Subcategory.find_by(name:"Anniversaire")
  Category.find_by(name:"Maquillage").subcategories << Subcategory.find_by(name:"Couple")
  Category.find_by(name:"Maquillage").subcategories << Subcategory.find_by(name:"Famille")
  Category.find_by(name:"Maquillage").subcategories << Subcategory.find_by(name:"EVJF")
  Category.find_by(name:"Maquillage").subcategories << Subcategory.find_by(name:"Mariage")

  Category.find_by(name:"Stylisme").subcategories << Subcategory.find_by(name:"Evènementiel")
  Category.find_by(name:"Stylisme").subcategories << Subcategory.find_by(name:"Mode")
  Category.find_by(name:"Stylisme").subcategories << Subcategory.find_by(name:"Mariage")

  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Mode")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"EVJF")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Mariage")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Baptème")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Anniversaire")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Couple")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Famille")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Evènementiel")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Barmitzvah/Batmitzvah")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Entreprise (Corporate)")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Vlog")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Vidéo Clip Musique")
  Category.find_by(name:"Vidéo").subcategories << Subcategory.find_by(name:"Cinéma (Court, Moyen, Long Métrage)")




end



if Profession.all.empty?
  Profession.create([{ name: 'Photographe' }, { name: 'Vidéaste' },{ name: 'Styliste' },{ name: 'Maquilleur' },{ name: 'Coiffeur' },{ name: 'Pilote de drone' }])
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Mode")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Portrait")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Naissance")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"EVJF")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Mariage")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Grossesse")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Baptème")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Anniversaire")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Couple")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Famille")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Evènementiel")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Immobilier")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Barmitzvah/Batmitzvah")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Entreprise (Corporate)")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Culinaire")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Packshot Produit")
  Profession.find_by(name:"Photographe").subcategories << Subcategory.find_by(name:"Animalier")

  Profession.find_by(name:"Pilote de drone").subcategories << Subcategory.find_by(name:"Evènementiel")
  Profession.find_by(name:"Pilote de drone").subcategories << Subcategory.find_by(name:"Immobilier")
  Profession.find_by(name:"Pilote de drone").subcategories << Subcategory.find_by(name:"Entreprise (Corporate)")
  Profession.find_by(name:"Pilote de drone").subcategories << Subcategory.find_by(name:"Vlog")
  Profession.find_by(name:"Pilote de drone").subcategories << Subcategory.find_by(name:"Vidéo Clip Musique")
  Profession.find_by(name:"Pilote de drone").subcategories << Subcategory.find_by(name:"Mariage")
  Profession.find_by(name:"Pilote de drone").subcategories << Subcategory.find_by(name:"Cinéma (Court, Moyen, Long Métrage)")


  Profession.find_by(name:"Coiffeur").subcategories << Subcategory.find_by(name:"Evènementiel")
  Profession.find_by(name:"Coiffeur").subcategories << Subcategory.find_by(name:"Mode")
  Profession.find_by(name:"Coiffeur").subcategories << Subcategory.find_by(name:"Portrait")
  Profession.find_by(name:"Coiffeur").subcategories << Subcategory.find_by(name:"Baptème")
  Profession.find_by(name:"Coiffeur").subcategories << Subcategory.find_by(name:"Anniversaire")
  Profession.find_by(name:"Coiffeur").subcategories << Subcategory.find_by(name:"Couple")
  Profession.find_by(name:"Coiffeur").subcategories << Subcategory.find_by(name:"Famille")
  Profession.find_by(name:"Coiffeur").subcategories << Subcategory.find_by(name:"EVJF")
  Profession.find_by(name:"Coiffeur").subcategories << Subcategory.find_by(name:"Mariage")

  Profession.find_by(name:"Maquilleur").subcategories << Subcategory.find_by(name:"Evènementiel")
  Profession.find_by(name:"Maquilleur").subcategories << Subcategory.find_by(name:"Mode")
  Profession.find_by(name:"Maquilleur").subcategories << Subcategory.find_by(name:"Portrait")
  Profession.find_by(name:"Maquilleur").subcategories << Subcategory.find_by(name:"Baptème")
  Profession.find_by(name:"Maquilleur").subcategories << Subcategory.find_by(name:"Anniversaire")
  Profession.find_by(name:"Maquilleur").subcategories << Subcategory.find_by(name:"Couple")
  Profession.find_by(name:"Maquilleur").subcategories << Subcategory.find_by(name:"Famille")
  Profession.find_by(name:"Maquilleur").subcategories << Subcategory.find_by(name:"EVJF")
  Profession.find_by(name:"Maquilleur").subcategories << Subcategory.find_by(name:"Mariage")

  Profession.find_by(name:"Styliste").subcategories << Subcategory.find_by(name:"Evènementiel")
  Profession.find_by(name:"Styliste").subcategories << Subcategory.find_by(name:"Mode")
  Profession.find_by(name:"Styliste").subcategories << Subcategory.find_by(name:"Mariage")

  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Mode")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"EVJF")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Mariage")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Baptème")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Anniversaire")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Couple")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Famille")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Evènementiel")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Barmitzvah/Batmitzvah")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Entreprise (Corporate)")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Vlog")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Vidéo Clip Musique")
  Profession.find_by(name:"Vidéaste").subcategories << Subcategory.find_by(name:"Cinéma (Court, Moyen, Long Métrage)")
end

if User.all.empty?
   User.create!([
    {confirmed_at: Time.now.utc,approved: true,email: 'yoopeek@yoopeek.com', firstname: 'Team', lastname: 'Yoopeek',is_worker: true, type: 'Worker',price_rate: '', nationality: '', description: '', password:"password"}])
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
