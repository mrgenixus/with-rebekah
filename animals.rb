# app for humane society.
# to record animal demograftics at intake
# to post animal profile to society website adoptions section
# to record adoption of animal
require 'pry'
require './interaction'
require './persistence'

include Interaction #screen, control, confirm, Menu
$shelter = Shelter.new

def intake
  screen "Enter another?", ['n', 'y'] do

    animal = Animal.new

    animal.name = query_user "What is the animal's Name", 'James'

    puts "The Animal's name is #{animal.name}"

    animal.sex = control 'm', 'f' do
      sex = query_user "what is the animal's sex"
      sex.downcase[0]
    end

    animal.altered = query_user "is the animal #{animal.alteration}"

    animal.species = control 'dog', 'cat' do
      query_user "what is the animal's species"
    end

    if animal.species == 'dog'
      shots = ['distemper', 'rabies', 'parvo', 'Kennel Cough']
    else
      shots = ['distemper', 'rabies', 'feline lukemia', 'fiv']
    end

    puts "Is the animal up to date on the following shots:"
    animal.shots = shots.map do |shot_type|
      up_to_date = query_user shot_type

      [shot_type, up_to_date]
    end

    animal.breed = query_user "what is the animal's breed"
    animal.age = query_user "what is the animal's age"

    puts animal.to_s
    $shelter.intake animal
  end
end

mainMenu = Menu.new

mainMenu.register_option "Intake", &method(:intake)
mainMenu.register_option "Test Screen" do
  screen "Enter another", ['n', 'y'] do
    puts "this is a screen"
  end
end

mainMenu.register_option "Test confirm" do
  name = ''

  confirm "Is that the correct name?" do
    name = query_user "what is the animal's name"
    puts "the name is #{name}"
  end

  puts "confirmed the name is #{name}"
end

mainMenu.exec
