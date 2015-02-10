class Animal < ActiveRecord::Base
belongs_to :classification
has_many :CommonNames


end
