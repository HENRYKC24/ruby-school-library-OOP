require './person'

class Student < Person
  def initialize(age, parent_permission, name = 'Unknown', classroom = 'N/A')
    super(age, name)
    @classroom = classroom
    @permission = parent_permission
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
