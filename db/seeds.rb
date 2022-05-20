puts 'Destroying current DB 🔥'

User.destroy_all
Restaurant.destroy_all

puts 'Creating 2 new restaurants 🍽'

restaurant = RestaurantInteractor::Create.new(
  params: {
    name: 'Cafe Monty',
    slug: 'cafemonty',
    logo: 'Cafe_Monty_gyaplr.png',
    address_line_1: '91 Bayview Ave',
    city: 'Toronto',
    province: 'ON',
    postal_code: 'M2K 1E6',
    country: 'Canada',
    colour: "emerald",
    tint: 900,
    font: "Arima",
  }
).call.value

restaurant_3 = RestaurantInteractor::Create.new(
  params: {
    name: 'Bella Ciao',
    slug: 'bellaciao',
    logo: 'bellaciao_2_y4kifw.png',
    address_line_1: '10 Blue Jays Way',
    city: 'Toronto',
    province: 'ON',
    postal_code: 'M5V 2G3',
    country: 'Canada',
    colour: "rose",
    tint: 800,
    font: "Oswald",
  }
).call.value

puts 'Creating 3 admins for each restaurant 👩🏽‍💻'

kristine = User.new(
  first_name: 'Kristine',
  last_name: 'McBride',
  email: 'kristinelmcbride@gmail.com',
  uid: 'kristinelmcbride@gmail.com',
  restaurant_id: restaurant.id,
  role: 'admin',
  password: 'password'
)

kristine.skip_confirmation!
kristine.save!

shahyn = User.new(
  first_name: 'Shahyn',
  last_name: 'Kamali',
  email: 'shahynkamali@gmail.com',
  uid: 'shahynkamali@gmail.com',
  restaurant_id: restaurant.id,
  role: 'admin',
  password: 'password'
)

shahyn.skip_confirmation!
shahyn.save!

gus = User.new(
  first_name: 'Gus',
  last_name: 'Richardson',
  email: 'gusrichardson1@gmail.com',
  uid: 'gusrichardson1@gmail.com',
  restaurant_id: restaurant.id,
  role: 'admin',
  password: 'password'
)

gus.skip_confirmation!
gus.save!

kristine_3 = User.new(
  first_name: 'Kristine',
  last_name: 'McBride',
  email: 'kristinelmcbride+bella@gmail.com',
  uid: 'kristinelmcbride+bella@gmail.com',
  restaurant_id: restaurant_3.id,
  role: 'admin',
  password: 'password'
)

kristine_3.skip_confirmation!
kristine_3.save!

shahyn_3 = User.new(
  first_name: 'Shahyn',
  last_name: 'Kamali',
  email: 'shahynkamali+bella@gmail.com',
  uid: 'shahynkamali+bella@gmail.com',
  restaurant_id: restaurant_3.id,
  role: 'admin',
  password: 'password'
)

shahyn_3.skip_confirmation!
shahyn_3.save!

puts 'Fetching dietaries 🥖'

gluten = Dietary.find_by(name: 'Gluten', restaurant_id: restaurant.id)
soy = Dietary.find_by(name: 'Soy', restaurant_id: restaurant.id)
lactose = Dietary.find_by(name: 'Lactose', restaurant_id: restaurant.id)
tree_nuts = Dietary.find_by(name: 'Tree nuts', restaurant_id: restaurant.id)
shellfish = Dietary.find_by(name: 'Shellfish', restaurant_id: restaurant.id)
sesame = Dietary.find_by(name: 'Sesame', restaurant_id: restaurant.id)
eggs = Dietary.find_by(name: 'Eggs', restaurant_id: restaurant.id)
peanuts = Dietary.find_by(name: 'Peanuts', restaurant_id: restaurant.id)
seafood = Dietary.find_by(name: 'Seafood', restaurant_id: restaurant.id)
vegan = Dietary.find_by(name: 'Vegan', restaurant_id: restaurant.id)
vegetarian = Dietary.find_by(name: 'Vegetarian', restaurant_id: restaurant.id)

puts 'Creating menus 📄'

lunch = Menu.create!(
  name: 'Lunch menu',
  restaurant_id: restaurant.id
)

dinner = Menu.create!(
  name: 'Dinner menu',
  restaurant_id: restaurant.id
)

dessert = Menu.create!(
  name: 'Dessert menu',
  restaurant_id: restaurant.id
)

drinks = Menu.create!(
  name: 'Drinks menu',
  restaurant_id: restaurant.id
)


puts 'Creating menus categories 🍷'

lunch_apps = MenuCategory.create!(
  name: 'Apps',
  category_type: 'food',
  menu_id: lunch.id
)

dinner_apps = MenuCategory.create!(
  name: 'Apps',
  category_type: 'food',
  menu_id: dinner.id
)

lunch_mains = MenuCategory.create!(
  name: 'Mains',
  category_type: 'food',
  menu_id: lunch.id
)

dinner_mains = MenuCategory.create!(
  name: 'Mains',
  category_type: 'food',
  menu_id: dinner.id
)

desserts = MenuCategory.create!(
  name: 'Desserts',
  category_type: 'food',
  menu_id: dessert.id
)

cocktails = MenuCategory.create!(
  name: 'Cocktails',
  category_type: 'beverage',
  menu_id: drinks.id
)

wines = MenuCategory.create!(
  name: 'Wines',
  category_type: 'beverage',
  menu_id: drinks.id
)

beers = MenuCategory.create!(
  name: 'Beers',
  category_type: 'beverage',
  menu_id: drinks.id
)

soft_drinks = MenuCategory.create!(
  name: 'Non-alcoholic',
  category_type: 'beverage',
  menu_id: drinks.id
)

puts 'Creating menus items with item sizes & dietaries 🥘'

potstickers_lunch = MenuItem.create!(
  name: 'Potstickers',
  available: false,
  description: 'Pan-fried pork potstickers',
  menu_category_id: lunch_apps.id,
  photo: 'potstickers1_uhbqsc.jpg'
)

DietaryInstance.create!(menu_item: potstickers_lunch, dietary: soy)
DietaryInstance.create!(menu_item: potstickers_lunch, dietary: gluten)

 ItemSize.create!(
  price: 9.00,
  unit: '6',
  menu_item_id: potstickers_lunch.id
)

potstickers_dinner =  MenuItem.create!(
  name: 'Potstickers',
  description: 'Pan-fried pork potstickers',
  menu_category_id: dinner_apps.id,
  photo: 'potstickers1_uhbqsc.jpg'
)

DietaryInstance.create!(menu_item: potstickers_dinner, dietary: soy)
DietaryInstance.create!(menu_item: potstickers_dinner, dietary: gluten)

 ItemSize.create!(
  price: 9.00,
  unit: '12',
  menu_item_id: potstickers_dinner.id
)

garden_salad_lunch =  MenuItem.create!(
  name: 'Garden salad',
  description: 'Tomatos, argula, balsamic vinegar',
  menu_category_id: lunch_apps.id,
  photo: 'nadine-primeau--ftWfohtjNw-unsplash_pmknmk.jpg'
)
DietaryInstance.create!(menu_item: garden_salad_lunch, dietary: vegan)
DietaryInstance.create!(menu_item: garden_salad_lunch, dietary: tree_nuts)
DietaryInstance.create!(menu_item: garden_salad_lunch, dietary: peanuts)

 ItemSize.create!(
  price: 9.00,
  unit: 'small',
  menu_item_id: garden_salad_lunch.id
)

garden_salad_dinner =  MenuItem.create!(
  name: 'Garden salad',
  description: 'Tomatos, argula, balsamic vinegar',
  menu_category_id: dinner_apps.id,
  photo: 'nadine-primeau--ftWfohtjNw-unsplash_pmknmk.jpg'
)

DietaryInstance.create!(menu_item: garden_salad_dinner, dietary: vegan)
DietaryInstance.create!(menu_item: garden_salad_dinner, dietary: tree_nuts)
DietaryInstance.create!(menu_item: garden_salad_dinner, dietary: peanuts)

 ItemSize.create!(
  price: 9.00,
  unit: 'large',
  menu_item_id: garden_salad_dinner.id
)

mushroom_soup =  MenuItem.create!(
  name: 'Mushroom soup',
  description: 'Homemade wild mushroom soup',
  menu_category_id: dinner_apps.id,
  photo: 'mushroom_soup.webp'
)

DietaryInstance.create!(menu_item: mushroom_soup, dietary: vegetarian)
DietaryInstance.create!(menu_item: mushroom_soup, dietary: lactose)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: mushroom_soup.id
)

tomato_soup =  MenuItem.create!(
  name: 'Tomato soup',
  description: 'Homemade fresh tomato soup',
  menu_category_id: lunch_apps.id,
  photo: 'jennifer-burk-8uC3b-unoSE-unsplash_aknxvr.jpg'
)

DietaryInstance.create!(menu_item: mushroom_soup, dietary: vegetarian)
DietaryInstance.create!(menu_item: mushroom_soup, dietary: lactose)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: tomato_soup.id
)

mac_and_cheese_lunch =  MenuItem.create!(
  name: 'Mac & Cheese',
  description: 'Fresh maccaroni, panchetta, topped with goldfish crumbs',
  menu_category_id: lunch_mains.id,
  photo: 'ronaldo-de-oliveira-tf2dNkqagyc-unsplash_zigoko.jpg'
)

DietaryInstance.create!(menu_item: mac_and_cheese_lunch, dietary: gluten)
DietaryInstance.create!(menu_item: mac_and_cheese_lunch, dietary: lactose)
DietaryInstance.create!(menu_item: mac_and_cheese_lunch, dietary: eggs)


 ItemSize.create!(
  price: 9.00,
  menu_item_id: mac_and_cheese_lunch.id
)

mac_and_cheese =  MenuItem.create!(
  name: 'Mac & Cheese',
  description: 'Fresh maccaroni, panchetta, topped with goldfish crumbs',
  menu_category_id: dinner_mains.id,
  photo: 'ronaldo-de-oliveira-tf2dNkqagyc-unsplash_zigoko.jpg'
)

DietaryInstance.create!(menu_item: mac_and_cheese, dietary: gluten)
DietaryInstance.create!(menu_item: mac_and_cheese, dietary: lactose)
DietaryInstance.create!(menu_item: mac_and_cheese, dietary: eggs)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: mac_and_cheese.id
)

margarita_pizza_lunch =  MenuItem.create!(
  name: 'Margarita Pizza',
  description: 'Mozzarella, oregano, basl',
  menu_category_id: lunch_mains.id,
  photo: 'pierre-antoine-caisso-3z1ifS7ERVY-unsplash_pnf8dv.jpg'
)
DietaryInstance.create!(menu_item: margarita_pizza_lunch, dietary: gluten)
DietaryInstance.create!(menu_item: margarita_pizza_lunch, dietary: lactose)
DietaryInstance.create!(menu_item: margarita_pizza_lunch, dietary: vegetarian)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: margarita_pizza_lunch.id
)

margarita_pizza =  MenuItem.create!(
  name: 'Margarita Pizza',
  description: 'Mozzarella, oregano, basl',
  menu_category_id: dinner_mains.id,
  photo: 'pierre-antoine-caisso-3z1ifS7ERVY-unsplash_pnf8dv.jpg'
)

DietaryInstance.create!(menu_item: margarita_pizza, dietary: gluten)
DietaryInstance.create!(menu_item: margarita_pizza, dietary: lactose)
DietaryInstance.create!(menu_item: margarita_pizza, dietary: vegetarian)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: margarita_pizza.id
)

salami_pizza_lunch =  MenuItem.create!(
  name: 'Salami Pizza',
  description: 'Italian salami, mozzarella, tomato sauce',
  menu_category_id: dinner_mains.id,
  photo: 'engin-akyurt-IfAb0bjhHlc-unsplash_rpm5wd.jpg'
)

DietaryInstance.create!(menu_item: salami_pizza_lunch, dietary: gluten)
DietaryInstance.create!(menu_item: salami_pizza_lunch, dietary: lactose)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: salami_pizza_lunch.id
)

salami_pizza =  MenuItem.create!(
  name: 'Salami Pizza',
  description: 'Italian salami, mozzarella, tomato sauce',
  menu_category_id: lunch_mains.id,
  photo: 'engin-akyurt-IfAb0bjhHlc-unsplash_rpm5wd.jpg'
)

DietaryInstance.create!(menu_item: salami_pizza, dietary: gluten)
DietaryInstance.create!(menu_item: salami_pizza, dietary: lactose)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: salami_pizza.id
)

club_sandwich =  MenuItem.create!(
  name: 'Club Sandwich',
  description: 'Chicken, bacon, tomato, lettuce & mayo',
  menu_category_id: lunch_mains.id,
  photo: 'suea-sivilaisith-foHj73zCV3Y-unsplash_xsdlc3.jpg'
)

DietaryInstance.create!(menu_item: club_sandwich, dietary: gluten)
DietaryInstance.create!(menu_item: club_sandwich, dietary: lactose)
DietaryInstance.create!(menu_item: club_sandwich, dietary: eggs)
DietaryInstance.create!(menu_item: club_sandwich, dietary: soy)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: club_sandwich.id
)

burger =  MenuItem.create!(
  name: 'Cheese Burger',
  description: 'Angus Beef, cheddar, lettuce & tomato',
  menu_category_id: lunch_mains.id,
  photo: 'amirali-mirhashemian-Tht2Sdwqey8-unsplash_ypahgc.jpg'
)

DietaryInstance.create!(menu_item: burger, dietary: gluten)
DietaryInstance.create!(menu_item: burger, dietary: lactose)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: burger.id
)

rib_eye =  MenuItem.create!(
  name: 'Rib-eye Steak',
  description: 'Waygu beef, 16 oz with red wine sauce',
  menu_category_id: dinner_mains.id,
  photo: 'alex-munsell-auIbTAcSH6E-unsplash_qwsnyc.jpg'
)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: rib_eye.id
)

salmon = MenuItem.create!(
  name: 'Maple Glaze Salmon',
  description: 'Atlantic Salmon with maple syrup glaze',
  menu_category_id: dinner_mains.id,
  photo: 'sebastian-coman-photography-Co-T6odt0es-unsplash_n8oxnp.jpg'
)

DietaryInstance.create!(menu_item: salmon, dietary: seafood)
DietaryInstance.create!(menu_item: salmon, dietary: soy)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: salmon.id
)

gnocchi = MenuItem.create!(
  name: 'Vegetarian Gnocchi',
  description: 'Homemade gnocchi with pesto sauce',
  menu_category_id: dinner_mains.id,
  photo: 'sebastian-coman-photography-Zmhi-OMDVbw-unsplash_p7bhqn.jpg'
)

DietaryInstance.create!(menu_item: gnocchi, dietary: vegan)
DietaryInstance.create!(menu_item: gnocchi, dietary: sesame)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: gnocchi.id
)

sorbet = MenuItem.create!(
  name: 'Sorbet Trio',
  description: 'Strawberry, mango, blueberry',
  menu_category_id: desserts.id,
  photo: 'sebastian-coman-photography--hM0-PSO3FY-unsplash_viiw5w.jpg'
)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: sorbet.id
)

brownie = MenuItem.create!(
  name: 'Chocolate Brownie',
  description: 'Dark chocolate brownie',
  menu_category_id: desserts.id,
  photo: 'alena-ganzhela-MONzTP2XxUE-unsplash_jypjog.jpg'
)

DietaryInstance.create!(menu_item: brownie, dietary: eggs)
DietaryInstance.create!(menu_item: brownie, dietary: gluten)
DietaryInstance.create!(menu_item: brownie, dietary: lactose)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: brownie.id
)

creme_brulee = MenuItem.create!(
  name: 'Creme Brulee',
  description: 'Classic cream brulee',
  menu_category_id: desserts.id,
  photo: 'alex-munsell-wiTWDYLURr8-unsplash_lua4p5.jpg'
)

DietaryInstance.create!(menu_item: creme_brulee, dietary: lactose)
DietaryInstance.create!(menu_item: creme_brulee, dietary: eggs)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: creme_brulee.id
)

whiskey_sour = MenuItem.create!(
  name: 'Whiskey Sour',
  description: 'Jameson, lemon, egg white',
  menu_category_id: cocktails.id
)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: whiskey_sour.id
)

french_martini = MenuItem.create!(
  name: 'French Martini',
  description: 'Grey goose, Chambord, pineapple',
  menu_category_id: cocktails.id
)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: french_martini.id
)

japanese_slipper = MenuItem.create!(
  name: 'Japanese Slipper',
  description: 'Midori, Cointreau & lemon',
  menu_category_id: cocktails.id
)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: japanese_slipper.id
)

margarita = MenuItem.create!(
  name: 'Classic Margarita',
  description: 'Don Julio, Cointreau & lime',
  menu_category_id: cocktails.id
)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: margarita.id
)

mojito = MenuItem.create!(
  name: 'Classic Mojito',
  description: 'Bacardi, mint & lime',
  menu_category_id: cocktails.id
)

 ItemSize.create!(
  price: 9.00,
  menu_item_id: mojito.id
)

pinot_noir = MenuItem.create!(
  name: 'Pinot Noir',
  description: 'Kim Crawford, NZ',
  menu_category_id: wines.id
)

 ItemSize.create!(
  price: 9.00,
  unit: '6 oz',
  menu_item_id: pinot_noir.id
)

 ItemSize.create!(
  price: 12.00,
  unit: '9 oz',
  menu_item_id: pinot_noir.id
)

 ItemSize.create!(
  price: 60.00,
  unit: 'Bottle',
  menu_item_id: pinot_noir.id
)

cab_sauv = MenuItem.create!(
  name: 'Cabernet Sauvignon',
  description: 'Kim Crawford, NZ',
  menu_category_id: wines.id
)

 ItemSize.create!(
  price: 11.00,
  unit: '6 oz',
  menu_item_id: cab_sauv.id
)

 ItemSize.create!(
  price: 15.00,
  unit: '9 oz',
  menu_item_id: cab_sauv.id
)

 ItemSize.create!(
  price: 72.00,
  unit: 'Bottle',
  menu_item_id: cab_sauv.id
)

shiraz = MenuItem.create!(
  name: 'Shiraz',
  description: "Jacob's Creek, AUS",
  menu_category_id: wines.id
)

 ItemSize.create!(
  price: 9.00,
  unit: '6 oz',
  menu_item_id: shiraz.id
)

 ItemSize.create!(
  price: 12.00,
  unit: '9 oz',
  menu_item_id: shiraz.id
)

 ItemSize.create!(
  price: 60.00,
  unit: 'Bottle',
  menu_item_id: shiraz.id
)

pinot_grigio = MenuItem.create!(
  name: 'Pinot Grigio',
  description: 'Ernest and Julio, CA',
  menu_category_id: wines.id
)

 ItemSize.create!(
  price: 9.00,
  unit: '6 oz',
  menu_item_id: pinot_grigio.id
)

 ItemSize.create!(
  price: 12.00,
  unit: '9 oz',
  menu_item_id: pinot_grigio.id
)

 ItemSize.create!(
  price: 60.00,
  unit: 'Bottle',
  menu_item_id: pinot_grigio.id
)

riesling = MenuItem.create!(
  name: 'Riesling',
  description: 'Mission Hill, BC',
  menu_category_id: wines.id
)

 ItemSize.create!(
  price: 10.00,
  unit: '6 oz',
  menu_item_id: riesling.id
)

 ItemSize.create!(
  price: 14.00,
  unit: '9 oz',
  menu_item_id: riesling.id
)

 ItemSize.create!(
  price: 66.00,
  unit: 'Bottle',
  menu_item_id: riesling.id
)

sauv_blanc = MenuItem.create!(
  name: 'Sauvignon Blanc',
  description: 'Peller Estates, Niagara',
  menu_category_id: wines.id
)

 ItemSize.create!(
  price: 10.00,
  unit: '6 oz',
  menu_item_id: sauv_blanc.id
)

 ItemSize.create!(
  price: 14.00,
  unit: '9 oz',
  menu_item_id: sauv_blanc.id
)

 ItemSize.create!(
  price: 66.00,
  unit: 'Bottle',
  menu_item_id: sauv_blanc.id
)

millstreet = MenuItem.create!(
  name: 'Millstreet',
  menu_category_id: beers.id
)

 ItemSize.create!(
  price: 7.00,
  unit: '12 oz',
  menu_item_id: millstreet.id
)

 ItemSize.create!(
  price: 11.00,
  unit: '20 oz',
  menu_item_id: millstreet.id
)

guiness = MenuItem.create!(
  name: 'Guiness',
  menu_category_id: beers.id
)

 ItemSize.create!(
  price: 7.00,
  unit: '12 oz',
  menu_item_id: guiness.id
)

 ItemSize.create!(
  price: 11.00,
  unit: '20 oz',
  menu_item_id: guiness.id
)


somersby = MenuItem.create!(
  name: 'Somersby',
  menu_category_id: beers.id
)

 ItemSize.create!(
  price: 7.00,
  unit: '12 oz',
  menu_item_id: somersby.id
)

 ItemSize.create!(
  price: 11.00,
  unit: '20 oz',
  menu_item_id: somersby.id
)

coke = MenuItem.create!(
  name: 'Coke',
  menu_category_id: soft_drinks.id
)

 ItemSize.create!(
  price: 2.50,
  menu_item_id: coke.id
)

coke = MenuItem.create!(
  name: 'Coke',
  menu_category_id: soft_drinks.id
)

 ItemSize.create!(
  price: 2.50,
  menu_item_id: coke.id
)

sprite = MenuItem.create!(
  name: 'Sprite',
  menu_category_id: soft_drinks.id
)

 ItemSize.create!(
  price: 2.50,
  menu_item_id: sprite.id
)

nestea = MenuItem.create!(
  name: 'Nestea',
  menu_category_id: soft_drinks.id
)

 ItemSize.create!(
  price: 2.50,
  menu_item_id: nestea.id
)

Banner.create!(photo: 'pizza_fkoxcw.jpg', header: "Bella Ciao", sub_header: 'Pizzeria Italiano', restaurant_id: restaurant_3.id)

PromotionInteractor::Create.new(
  author: kristine, 
  category_params: { categories: [{ menu_category_id: cocktails.id, unit: "percentage", discount: 50 }] }, 
  promotion_params: { name: "Happy Hour", description: "1/2 price cocktails", start_time: Time.new(2022, 01, 01, 17, 0, 0), end_time: Time.new(2022, 01, 01, 22, 0, 0), days: "Monday,Tuesday,Wednesday,Thursday,Friday", restaurant_id: restaurant.id }
).call

puts 'All done 🎉🎉🎉'
