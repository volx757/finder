class User < ActiveRecord::Base

  has_many :works

  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password

  validates :username, :presence => true, :uniqueness => true, :length => {:in => 3..20}, :on => :create
  validates :email, :presence => true, :uniqueness => true, :on => :create
  validates :password, :confirmation => true, :on => :create
  validates_length_of :password, :in => 8..20, :on => :create

  attr_accessible :email, :password, :password_confirmation, :salt, :username, :status, :bio, :city, :tags


  def self.authenticate(username_or_email="", login_password="")
    user = User.find_by_username(username_or_email)

    if user && user.match_password(login_password)
      user
    else
      false
    end
  end

  def match_password(login_password="")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  def encrypt_password
    unless password.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def self.search(search)
    where('tags LIKE ?', "%#{search}%")
  end

end
