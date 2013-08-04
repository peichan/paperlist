class BooklistController < ApplicationController
  def hello
    @booklist = Book.find(:all)
  end
end
