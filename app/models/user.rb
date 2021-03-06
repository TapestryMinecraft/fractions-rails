# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  name             :string
#  uuid                 :string           not null
#  password_digest      :string           not null
#  session_token        :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  current_character_id :integer
#

class User < ActiveRecord::Base
  after_initialize :ensure_session_token
  before_validation :ensure_name_and_uuid, on: :create

  validates :name, presence: true
  validates :uuid, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validate :owns_current_character, if: :current_character_id
  validate :password_must_not_match_name

  has_many :characters
  belongs_to :current_character, class_name: 'Character'

  def self.digest(password)
    BCrypt::Password.create(password)
  end

  def self.find_by_credentials(uuid, password)
    user = User.find_by(uuid: uuid)
    user.try(:is_password?, password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def password
    @password
  end

  def password=(password)
    @password = password
    self.password_digest = User.digest(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.update_attributes(session_token: User.generate_session_token)
    self.session_token
  end

  def can_create_character?
    last = characters.order(:created_at).last
    !last || last.created_at < (characters.count * 7).days.ago
  end

  def overwrite_name!
    self.update_attributes(name: self.uuid)
  end

  private

    def ensure_session_token
      self.session_token ||= User.generate_session_token
    end

    def ensure_name_and_uuid
      response = MojangApiConnection.profile_given_name(self.name)

      if response.is_a? Hash
        self.name = response[:name]
        self.uuid = response[:uuid]

        User.find_by(name: self.name).try(:overwrite_name!)
      else
        errors.add(:base, response)
      end
    end

    def owns_current_character
      unless current_character && current_character.user == self
        errors.add(:current_character_id, "does not belong to user")
      end
    end

    def password_must_not_match_name
      if self.password && self.password.downcase == self.name.downcase
        errors.add(:password, "must not match name")
      end
    end
end
