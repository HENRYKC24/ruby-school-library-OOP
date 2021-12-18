require_relative './book'
require_relative './classroom'
require_relative './person'
require_relative './rental'
require_relative './student'
require_relative './teacher'

class School_library_app
  def initialize
    @intro_text = [
      'Please choose an option by entering a number:',
      '1 - List all books',
      '2 - List all people',
      '3 - Create a person',
      '4 - Create a book',
      '5 - Create a rental',
      '6 - List all rentals for a given person id',
      '7 - Exit'
    ]
    @books = []
    @people = []
  end

  def main
    puts ' ', ' ', 'Welcome to School Library App!', ' '
    start
  end

  def start
    puts @intro_text
    selected_option = gets.chomp
    check_selected_option(selected_option)
  end

  def check_selected_option(option)
    case option
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_all_rentals
    when '7'
      puts 'Thank you for using this app!', ' '
      exit
    else
      print 'Please input an option from the numbers listed above: '
      selected_option = gets.chomp
      check_selected_option(selected_option)
    end
  end

  def input_number
    choice = gets.chomp
    choice_check = choice.scan(/\D/).empty?
    if (choice_check)
      return choice
    end

    false
  end

  def input_number_only(min, max)
    choice = input_number
    if (choice == false)
      print 'Please, input only numbers: '
      choice = input_number_only(min, max)
    elsif (choice.to_i < min || choice.to_i > max)
      print "Please, input number from #{min} to #{max}: "
      choice = input_number_only(min, max)
    end
    choice
  end

  def input_text_only
    choice = input_text
    if !choice
      puts 'Please, at least first character should be a letter.'
    end
    choice
  end

  def parent_permission
    choice = gets.chomp
    if ('yn'.include? choice.downcase) && (choice.length == 1)
      choice.downcase
    else
      puts "Please, input either 'y' or 'n'"
      parent_permission
    end
  end

  def input_text
    inputed_text = gets.chomp
    if inputed_text == ''
      return false
    end

    normal_first_char = inputed_text[0].index(/[A-z]/)
    rnormal_first_char ? inputed_text.capitalize : false
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    choice = input_number_only(1, 2)
    case choice
    when '1'
      print 'Age: '
      age = input_number_only(1, 150)
      print 'Name: '
      name = input_text_only
      print 'Has parent permission? [Y/N]: '
      parent_permission = parent_permission
      permission = parent_permission == 'n'
      student = Student.new(age, name, 'N/A')
      @people.push(student)
      puts 'Person created successfully', ' '
      start
    when '2'
      print 'Age: '
      age = input_number_only(1, 150)
      print 'Name: '
      name = input_text_only
      print 'Specialization: '
      specialization = input_text_only
      teacher = Teacher.new(age, specialization, name)
      @people.push(teacher)
      puts 'Person created successfully', ' '
      start
    else
      puts 'Unknown entry'
    end
  end

  def create_book
    print 'Title: '
    title = input_text_only

    print 'Author: '
    author = input_text_only

    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created successfully', ' '
    start
  end

  def list_all_books
    if @books.empty?
      puts 'Empty', ' '
    else
      @books.each do |book|
        puts "Titile: \"#{book.title}\", Author: #{book.author}"
      end
      puts ' '
    end
    start
  end

  def create_rental
    if @books.empty?
      puts 'No books created yet for rental', ' '
    elsif !@books.empty? && @people.empty?
      puts 'There are books but no person created yet', ' '
    else
      puts ' ', 'Select a book from the following list by number'
      @books.each_with_index do |book, index|
        puts "#{index + 1}) Titile: \"#{book.title}\", Author: #{book.author}"
      end
      selected_num = input_number_only(1, @books.length)
      selected_book = @books[selected_num.to_i - 1]
      puts ' ', 'Select a person from the following list by number (Not ID)'
      @people.each_with_index do |person, index|
        puts "#{index + 1}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
      selected_num2 = input_number_only(1, @people.length)
      selected_person = @people[selected_num2.to_i - 1]
      print 'Date: '
      date_chosen = gets.chomp
      Rental.new(date_chosen, selected_book, selected_person)
      puts 'Rental created successfully', ' '
    end
    start
  end

  def list_all_people
    if @people.empty?
      puts 'No person created yet', ' '
    else
      @people.each do |person|
        puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
      puts ' '
    end
    start
  end

  def list_all_rentals
    puts 'ID of person: '
    given_id = input_number_only(1, 1_000_000)
    selected_person_array = @people.filter { |person| person.id == given_id.to_i }
    if selected_person_array.empty?
      puts "There is no person with the ID: \"#{given_id}\" ", ' '
    elsif selected_person_array[0].rentals.empty?
      puts "The person with the ID \"#{given_id}\" has no rentals", ' '
    else
      person = selected_person_array[0].rentals
      mapped_person = person.map do |rental|
        "Book: #{rental.book.title}, Rented on: #{rental.date}"
      end
      puts mapped_person
    end
    puts ' '
    start
  end
end

School_library_app.new.main
