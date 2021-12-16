require 'corrector'
require 'rental'

class Person
  attr_accessor :name, :age, :rentals
  attr_reader :id, :parent_permission

  def initialize(age, name = 'Unknown', parent_permission: true)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @id = Random.rand(1...1_000_000)
    @corrector = Corrector.new
    @rentals = []
  end


  def can_use_services
    is_of_age && @parent_permission
  end

  def validate_name
    @name = @corrector.correct_name(@name)
  end

  def rent_book(date, book)
    rental = Rental.new(date, book, self)
    @rentals.push(rental) if !@rentals.include? rental
  end

  private

  def of_age
    @age >= 18
  end
end
