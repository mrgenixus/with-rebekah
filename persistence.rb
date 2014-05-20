class Animal
  attr_accessor :id

  attr_accessor :name, :sex, :species, :altered, :shots, :breed, :age

  def alteration
    if sex == "m"
      "neutered"
    else
      "spayed"
    end
  end

  def to_s
    [:name, :sex, :species, :altered, :shots, :breed, :age].map do |field|
      "#{field.to_s}: #{self.public_send(field)}"
    end.join(', ')
  end

end

class Shelter
  def initialize
    @@animals = []
  end

  def intake animal
  end

  def adopt adopt
  end

  def get id
  end
end
