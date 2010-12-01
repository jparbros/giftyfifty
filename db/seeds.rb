# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Occasion.delete_all
Occasion.create([
        {:name => 'birthday'},
        {:name => 'wedding'},
        {:name => 'mothers day'},
        {:name => 'baptism'},
        {:name => 'first communion'},
        {:name => 'christmas'},
        {:name => 'baby shower'}])
  
Location.delete_all      
Location.create([
        {:country => 'MX'},
        {:country => 'US'}])
        
Provider.delete_all
Provider.create([
        {:name => 'amazon'},
        {:name => 'ebay'}])
        
        
us = Location.where(:country => 'US').first

AmazonShipment.delete_all
["Apparel","Beauty","Jewelry", "Watches", "Loose","Stones","Shoes","Software","VHS videos"] .each do |category|
  AmazonShipment.create([
        {:category => category,
        :per_shipment => 399,
        :per_item => 99,
        :location_id => us.id,
        :per_pound => false}
  ])
end

AmazonShipment.create([
      {:category => 'Books',
      :per_shipment => 300,
      :per_item => 99,
      :location_id => us.id,
      :per_pound => false}
])

["Music CDs","Cassettes","Vinyl","DVDs"] .each do |category|
  AmazonShipment.create([
        {:category => category,
        :per_shipment => 199,
        :per_item => 99,
        :location_id => us.id,
        :per_pound => false}
  ])
end

AmazonShipment.create([
      {:category => 'Video Games',
      :per_shipment => 399,
      :per_item => 99,
      :location_id => us.id,
      :per_pound => false}
])

AmazonShipment.create([
      {:category => 'Video Game Consoles & Accessories',
      :per_shipment => 749,
      :per_item => 99,
      :location_id => us.id,
      :per_pound => false}
])

AmazonShipment.create([
      {:category => 'Toys',
      :per_shipment => 399,
      :per_item => 85,
      :location_id => us.id,
      :per_pound => true}
])

AmazonShipment.create([
      {:category => 'Computers',
      :per_shipment => 799,
      :per_item => 65,
      :location_id => us.id,
      :per_pound => true}
])

["Automotive", "Baby", "Cell Phones & Accessories", "Electronics", "Furniture", "Grocery", "Health & Personal Care", 
  "Home & Garden", "Kitchen & Housewares", "Luggage", "Outdoor Living", "Sports", "Tools & Hardware", 
  "Industrial & Scientific", "Office Products"].each do |category|
    AmazonShipment.create([
          {:category => category,
          :per_shipment => 499,
          :per_item => 59,
          :location_id => us.id,
          :per_pound => true}
    ])
end

mx = Location.where(:country => 'MX').first

['Books', 'VHS videotapes'].each do |category|
  AmazonShipment.create([
        {:category => category,
        :per_shipment => 499,
        :per_item => 499,
        :location_id => mx.id,
        :per_pound => false}
  ])
end

['CDs', 'DVDs', 'Music Cassettes', 'Vinyl'].each do |category|
  AmazonShipment.create([
        {:category => category,
        :per_shipment => 499,
        :per_item => 299,
        :location_id => mx.id,
        :per_pound => false}
  ])
end

['Jewelry', 'Clothing Items', 'Shoes', 'Baby', 'Toys'].each do |category|
  AmazonShipment.create([
        {:category => category,
        :per_shipment => 1399,
        :per_item => 299,
        :location_id => mx.id,
        :per_pound => false}
  ])
end

['Automotive', 'Computers', 'Electronics', 'Home', 'Personal Care', 'Kitchen', 'Outdoor Living', 'Tools'].each do |category|
  AmazonShipment.create([
        {:category => category,
        :per_shipment => 1399,
        :per_item => 249,
        :location_id => mx.id,
        :per_pound => true}
  ])
end