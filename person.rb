class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @id = Random.rand(1...1000000)
  end

  attr_accessor :name, :age
  attr_reader :id, :parent_permission

  def can_use_services
    is_of_age && @parent_permission
  end

  private

  def of_age
    @age >= 18
  end
end
