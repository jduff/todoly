class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login

  validates_uniqueness_of :login, :allow_nil=>true
  validates_format_of :login, :with => /^[^@\s]*$/i, :message => "You can't have @ or spaces in your login" # Logins cannot have @ symbols or spaces

  def self.find_for_database_authentication(conditions)
    value = conditions[authentication_keys.first]
    where(["login = :value OR email = :value", { :value => value }]).first
  end
end
