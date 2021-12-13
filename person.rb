class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @id = 1
  end

  attr_accessor :name, :age
  attr_reader :id, :parent_permission

  private

  def of_age
    @age >= 18
  end

  def can_use_services
    is_of_age && @parent_permission
  end
end
