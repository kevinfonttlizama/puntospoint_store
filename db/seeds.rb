# Crear administradores
admin1 = Admin.find_or_create_by_email('admin1@example.com') do |admin|
  admin.name = 'Admin1'
  admin.password = 'password'
end

admin2 = Admin.find_or_create_by_email('admin2@example.com') do |admin|
  admin.name = 'Admin2'
  admin.password = 'password'
end

admin3 = Admin.find_or_create_by_email('admin3@example.com') do |admin|
  admin.name = 'Admin3'
  admin.password = 'password'
end

# Crear categorías
category1 = admin1.categories.find_or_create_by_name('Electronics')
category2 = admin2.categories.find_or_create_by_name('Clothing')
category3 = admin3.categories.find_or_create_by_name('Home')
category4 = admin1.categories.find_or_create_by_name('Sports')
category5 = admin2.categories.find_or_create_by_name('Books')

# Crear productos y asignar categorías
product1 = admin1.products.find_or_create_by_name('Television') do |product|
  product.price = 500.0
end
product1.categories << category1 unless product1.categories.include?(category1)
# Actualizar imagen
product1.update_attributes(image: File.open(Rails.root.join('app/assets/images/television.jpg')))

product2 = admin2.products.find_or_create_by_name('T-Shirt') do |product|
  product.price = 20.0
end
product2.categories << category2 unless product2.categories.include?(category2)
# Actualizar imagen
product2.update_attributes(image: File.open(Rails.root.join('app/assets/images/tshirt.jpg')))

product3 = admin3.products.find_or_create_by_name('Microwave') do |product|
  product.price = 150.0
end
product3.categories << category1 unless product3.categories.include?(category1)
product3.categories << category3 unless product3.categories.include?(category3)
# Actualizar imagen
product3.update_attributes(image: File.open(Rails.root.join('app/assets/images/microwave.jpg')))

product4 = admin1.products.find_or_create_by_name('Football') do |product|
  product.price = 30.0
end
product4.categories << category4 unless product4.categories.include?(category4)
# Actualizar imagen
product4.update_attributes(image: File.open(Rails.root.join('app/assets/images/football.jpg')))

product5 = admin2.products.find_or_create_by_name('Novel') do |product|
  product.price = 15.0
end
product5.categories << category5 unless product5.categories.include?(category5)
# Actualizar imagen
product5.update_attributes(image: File.open(Rails.root.join('app/assets/images/novel.jpg')))


# Crear clientes
customer1 = Customer.find_or_create_by_email('customer1@example.com') do |customer|
  customer.name = 'Customer1'
  customer.password = 'password'
end

customer2 = Customer.find_or_create_by_email('customer2@example.com') do |customer|
  customer.name = 'Customer2'
  customer.password = 'password'
end

customer3 = Customer.find_or_create_by_email('customer3@example.com') do |customer|
  customer.name = 'Customer3'
  customer.password = 'password'
end

customer4 = Customer.find_or_create_by_email('customer4@example.com') do |customer|
  customer.name = 'Customer4'
  customer.password = 'password'
end

customer5 = Customer.find_or_create_by_email('customer5@example.com') do |customer|
  customer.name = 'Customer5'
  customer.password = 'password'
end

# Verificar que los clientes y productos existen antes de crear las compras
if customer1 && product1
  purchase1 = Purchase.where(customer_id: customer1.id, product_id: product1.id).first_or_initialize
  purchase1.quantity = 1
  purchase1.price = product1.price
  purchase1.save!
end

if customer2 && product2
  purchase2 = Purchase.where(customer_id: customer2.id, product_id: product2.id).first_or_initialize
  purchase2.quantity = 3
  purchase2.price = product2.price
  purchase2.save!
end

if customer3 && product3
  purchase3 = Purchase.where(customer_id: customer3.id, product_id: product3.id).first_or_initialize
  purchase3.quantity = 2
  purchase3.price = product3.price
  purchase3.save!
end

if customer4 && product4
  purchase4 = Purchase.where(customer_id: customer4.id, product_id: product4.id).first_or_initialize
  purchase4.quantity = 1
  purchase4.price = product4.price
  purchase4.save!
end

if customer5 && product5
  purchase5 = Purchase.where(customer_id: customer5.id, product_id: product5.id).first_or_initialize
  purchase5.quantity = 4
  purchase5.price = product5.price
  purchase5.save!
end
