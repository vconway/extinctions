# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'csv'
 
class DataLoader
  attr_reader :classifications
 
  def initialize
    @classifications = {}
  end
 
  def purge
    CommonName.destroy_all
    Animal.destroy_all
    Classification.destroy_all
  end
 
  # CSV column order is
  #
  # classification
  # scientific name
  # common name (commas)
  # url
  # exctinction date
  # range
  # image url
  def load_from_csv(file_path)
    CSV.foreach(file_path) do |row|
      puts "Adding #{row[1]}"
 
      classification = find_or_create_classification(row[0])
      animal = create_animal(classification, row)
      create_common_names(animal, row)
    end
  end
 
  def find_or_create_classification(name)
    classifications[name] = Classification.create!(name: name) unless classifications.key?(name)
    classifications[name]
  end
 
  def create_animal(classification, row)
    classification.animals.create!(
      name:             row[1],
      url:              row[3].to_s,
      extinction_date: row[4].to_i,
      range:            row[5].to_s,
      image_url:        row[6].to_s
    )
  end
 
  def create_common_names(animal, row)
    row[2].to_s.split(',').each do |common_name|
      animal.common_names.create!(name: common_name)
    end
  end
end
 
file_path = Rails.root.join('db/holocene-americas.csv')
loader = DataLoader.new
loader.purge
loader.load_from_csv(file_path)