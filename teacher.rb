require './person'

class Teacher < Person
  def initialize(age, specialization = 'N/A', name = 'Unknown')
    super(age, name)
    @specialization = specialization
  end

  attr_accessor :specialization

  def can_use_services
    true
  end
end
