# frozen_string_literal: true

# Top most level categories

['Fashion', 'Health & Beauty', 'Baby', 'Furniture & Home Decor',
 'Classified Ads', 'Wadamart Business'].each do |cat|
  Category.find_or_create_by(name: cat)
end

#### Fashion

fashion = Category.find_by_name('Fashion')

["Women's Clothing", "Women's Shoes", "Men's Clothing", 'Accessories'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: fashion.id)
end

women_clothing = Category.find_by_name("Women's Clothing")

['Tops', 'Sweaters', 'Outwear, Coats, Jacket', 'Jeans', 'Swimwear'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: women_clothing.id)
end

women_shoes = Category.find_by_name("Women's Shoes")

['Sneakers', 'Sandals', 'Flats', 'Heels', 'Boots & Booties', 'Clogs & Mules'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: women_shoes.id)
end

mens_clothing = Category.find_by_name("Men's Clothing")

['Dress Shirts', 'Bottoms', 'Outwear, Coats, Jacket', 'Graphic Tees',
 'Activewear', 'Shoes'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: mens_clothing.id)
end

accessories = Category.find_by_name('Accessories')

["Women's Handbags", "Men's Bags", "Women's Jewlery", "Men's Watches",
 "Women's Eyewear", "Men's Eyewear"].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: accessories.id)
end

#### Health & Beauty

health = Category.find_by_name('Health & Beauty')

['Health Care', 'Skin Care', 'Makeup', 'Nail Care'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: health.id)
end

health_care = Category.find_by_name('Health Care')

['Health Monitors', 'Relaxation', "Women's Enhancements"].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: health_care.id)
end

skin_care = Category.find_by_name('Skin Care')

['Face', 'Eye & Lips', 'Sun care', 'Face Masks', 'Skin Care Sets', 'Skin Care Tools'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: skin_care.id)
end

makeup = Category.find_by_name('Makeup')

['Foundations & Tinted Moisturizers', 'Concealers', 'Eyes',
 'Lips', 'Makeup Sets', 'Makeup Tools & Accessories'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: makeup.id)
end

nail_care = Category.find_by_name('Nail Care')

['Nail Grooming', 'Nail Art, Jewlery & Tools', 'Nail Treatments',
 'Nail Polish', 'Nail Dryers', 'Nail Organizers'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: nail_care.id)
end

#### Baby

baby = Category.find_by_name('Baby')

['Baby Clothing & Shoes', 'Baby Activity & Gear',
 'Baby Nursery & Feeding', 'Baby Health & Safety'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: baby.id)
end

baby_clothing = Category.find_by_name('Baby Clothing & Shoes')

['Baby Girl Clothing', 'Baby Boy Clothing', 'Unisex Baby Clothing',
 'Baby Clothing Gifts', 'Kids Clothing', 'Baby Shoes'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: baby_clothing.id)
end

baby_activities = Category.find_by_name('Baby Activity & Gear')

['Strollers', 'Car seats', 'Carriers', 'Travel beds',
 'Baby Play', 'Baby Toys'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: baby_activities.id)
end

baby_nursery = Category.find_by_name('Baby Nursery & Feeding')

['Baby Bedding', 'Baby Cribs', 'Baby Furniture', 'Baby Décor', 'Crib Toys & Attachments',
 'Baby Feeding'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: baby_nursery.id)
end

baby_health = Category.find_by_name('Baby Health & Safety')

['Baby Monitors', 'Baby Bath', 'Baby Proofing', 'Baby Health Care',
 'Baby Safety', 'Baby Grooming'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: baby_health.id)
end

#### Furniture & Home Decor

furniture_home = Category.find_by_name('Furniture & Home Decor')

['Furniture', 'Home Decor'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: furniture_home.id)
end

furniture = Category.find_by_name('Furniture')

['Living Room Furniture', 'Bedroom Furniture', 'Kitchen & Dining Furniture',
 'Home Office Furniture', 'Baby Furniture', 'Entryway Furniture'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: furniture.id)
end

home_decor = Category.find_by_name('Home Decor')

['Wall Decor', 'Home Accents', 'Rugs', 'Kitchen', 'Bath', 'Decorative Storage'].each do |cat|
  Category.find_or_create_by(name: cat, parent_id: home_decor.id)
end
