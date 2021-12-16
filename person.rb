require 'corrector'
class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @id = Random.rand(1...1_000_000)
    @corrector = Corrector.new
  end

  attr_accessor :name, :age
  attr_reader :id, :parent_permission

  def can_use_services
    is_of_age && @parent_permission
  end

  def validate_name
    @name = @corrector.correct_name(@name)
  end

  private

  def of_age
    @age >= 18
  end
end
