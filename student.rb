require './person'

class Student < Person
  def initialize(age, classroom = 'N/A', name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @classroom = classroom
  end

  attr_reader :classroom

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push self unless classroom.students.include? self
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
