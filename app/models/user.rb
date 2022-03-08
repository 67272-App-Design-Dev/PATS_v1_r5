class User < ApplicationRecord
 # Most of the secure password machinery will be implemented using a single Rails built_in module
  # called `has_secure_password`, which we'll include in the User model as follows:
  has_secure_password

# When included in a model as above, this one module adds the following functionality:
    # 1- The ability to save a securely hashed `password_digest` attribute to the database: 
    # The has_secure_password module will be responsible of creating the password_digest out of the password 
    # and password confirmation entered by the user when signinup.
    # 2- A pair of virtual attributes: password and password_confirmation, and their getters and setters 
    # (as if we did the following:  attr_accessor :password, :password_confirmation)
    # IMPORTANT NOTE: NEVER CREATE THESE TWO FIELDS WHEN YOU GENERATE THE MODEL.
    # 3- An `authenticate` method that returns the user when the password is correct (and false otherwise)

  # The only requirement for `has_secure_password` to work its magic is for the corresponding model to have 
  # an attribute called `password_digest`. (The name digest comes from the terminology of cryptographic hash functions. 
  # In this context, hashed password and password digest are synonyms.)
  # In the case of the User model, this leads to the data model shown in the ERD of PATS.

  # To make the password digest, `has_secure_password` uses a state-of-the-art hash function called `bcrypt`.
  #  By hashing the password with bcrypt, we ensure that a hacker won't be able to log in to the site even if they
  #  manage to obtain a copy of the database. 
  # To use bcrypt in the sample application, we need to add the bcrypt gem to our Gemfile (Check line 29 of the Gemfile).

  # Example:
  # rails console
  # >> User.create(first_name: "Houda", last_name:"bouamor", username: "hbouamor", role:"vet",
                #  password: "foobar", password_confirmation: "foobar", active:true)
    # => #<User id: 2, first_name: "Houda", last_name: "bouamor", role: "vet", 
    # username: "hbouamor", password_digest: "$2a$12$yiGEoc10GgXCucq9XryyQOXT0wxwNO76gUSdIl3SAMp...", active: true">
  
    
  # Relationships
  has_many :notes
  has_one :owner

  # Validations
  # make sure required fields are present
  validates_presence_of :first_name, :last_name, :username 
  validates_uniqueness_of :username
  validates_presence_of :password, :on => :create 
  validates_presence_of :password_confirmation, :on => :create 
  validates_confirmation_of :password, message: "does not match"
  validates_length_of :password, :minimum => 4, message: "must be at least 4 characters long", :allow_blank => true
  validates_inclusion_of :role, in: %w( vet assistant owner), message: "is not recognized in the system"

  # validates_format_of :password, //

  # Other methods
  # -----------------------------  
  def proper_name
    first_name + " " + last_name
  end
  
  def name
    last_name + ", " + first_name
  end

  # login by username
  # This is a class method that takes a combination of username and password 
  # starts by checking if the username exists
  # then if the username is found, the password is checked.
  def self.authenticate(username, password)
      find_by_username(username).try(:authenticate, password)
  end
  # for use in authorizing with CanCan
  ROLES = [['Vet', :vet],['Assistant', :assistant],['Owner', :owner]]

  # the role? method checks if the user has a role among the ones we define here. 
  def role?(authorized_role)
    return false if role.nil?
    role.downcase.to_sym == authorized_role
  end


end
