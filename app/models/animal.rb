class Animal < ActiveRecord::Base
belongs_to :classification
has_many :CommonNames

def recent?
  	extinction_date > 1900
  end

end
