class Paper < ActiveRecord::Base
  attr_accessible :author, :endingPage, :publicationYear, :publicationName, :startingPage, :title, :url

  validates_presence_of :title, :author
  validates_uniqueness_of :title
end
