require './person'
class Student < Person
  def initialize(age, classroom = 'N/A', name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @classroom = classroom
  end

  attr_accessor :classroom

  def play_hooky
    "¯\(ツ)/¯"
  end
end
