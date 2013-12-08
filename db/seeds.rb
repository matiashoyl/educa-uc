require 'csv'    


CSV.foreach("public/TablaESC_TIPO_ESCALA.csv", {:col_sep => "\t"}) do |row|
  Scale.create!(:name => row[1])
  puts "SCALES #{Scale.last.id}"
end

CSV.foreach("public/TablaESC_SUB_ESCALA.csv") do |row|
  Subscale.create!(:name => row[2], :scale_id => row[1])
  puts "SUB-SCALES #{Subscale.last.id}"
end

CSV.foreach("public/TablaESC_ITEMS.csv") do |row|
  Item.create!(:name => row[2], :subscale_id => row[1])
  puts "ITEMS #{Item.last.id}"
end

# CSV format:
#   - row0: indicator id
#   - row1: item_id
#   - row2: column_id, indicator_number
#   - row3: name
CSV.foreach("public/TablaESC_INDICADORES.csv", :quote_char => "\'") do |row|
  Column.create(:puntuation => row[2][0].to_i , :item_id => row[1].to_i)
  Indicator.create(:name => row[3], :column_id => Column.last.id, :indicator_number => row[2][-1].to_i)
  puts "INDICATOR #{Indicator.last.id}"
end

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin
