require './rental'

class Book
  attr_accessor :title, :author
  attr_reader :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def rent(date, person)
    @rental = Rental.new(date, self, person)
    @rentals.push(@rental) unless @rentals.include? @rental
  end
end
