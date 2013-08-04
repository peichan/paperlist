class Book < ActiveRecord::Base
  attr_accessible :category, :name, :price
end
