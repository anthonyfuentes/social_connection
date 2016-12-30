
class User < ApplicationRecord
  before_create :generate_token
  validates :password, length: { minimum: 5 }, allow_nil: true
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_one :profile, dependent: :destroy
  has_one :profile_photo, class_name: 'Photo'
  has_many :likes, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :initiated_friendings, class_name: 'Friending',
    foreign_key: 'friender_id', dependent: :destroy
  has_many :received_friendings, class_name: 'Friending',
    foreign_key: 'friended_id', dependent: :destroy
  has_many :friended_users, through: :initiated_friendings,
    source: :friended
  has_many :users_friended_by, through: :received_friendings,
    source: :friender
  has_one :cover_photo, through: :profile

  def self.send_welcome_email(user_id)
    user = User.find(user_id)
    mailer.welcome(user).deliver_later
  end

  def photos(n = 0)
   n == 0 ? super : photo.where(user_id: id).limit(n)
  end

  def cover_photo
    profile.cover_photo
  end

  def profile_photo
    profile.profile_photo
  end

  def name
    "#{ first_name } #{ last_name }"
  end

  def friends(n = 0)
    all_friends = friended_users + users_friended_by
    n == 0 ? all_friends : all_friends[0...n]
  end

  def friends_ids(n = 0)
    all_friends_ids = friended_user_ids + users_friended_by_ids
    n == 0 ? all_friends_ids : all_friends_ids[0...n]
  end

  def friend_or_self?(user)
    user.id == id || friends_ids.include?(user.id)
  end

  def generate_token
    begin
      self.auth_token = token_generator.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end

  def regenerate_auth_token
    generate_token
    save!
  end

  def education
    profile.education
  end

  def home_town
    profile.home_town
  end

  def current_town
    profile.current_town
  end

  def self.search(name: '', user:)
    if name && !name.empty?
      name_search(name)
    else
      where("id <> ?", user.id)
    end
  end

  private
  def self.mailer
    UserMailer
  end

  def self.name_search(name)
    where("first_name ILIKE :name OR last_name ILIKE :name",
          name: "%#{ name }%")
  end

  def photo
    Photo
  end

  def token_generator
    SecureRandom
  end

end
