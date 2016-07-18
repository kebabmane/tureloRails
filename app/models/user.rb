class User < ActiveRecord::Base
  enum role: [:user, :mod, :admin]
  after_initialize :set_default_role, :if => :new_record?


  has_many :notifications, foreign_key: :recipient_id
  is_impressionable :counter_cache => true

  acts_as_follower
  acts_as_liker

  attr_accessor :login

  validates :email, :presence => true, :uniqueness => true
  validates :nickname,
      :presence => true,
      :uniqueness => {
      :case_sensitive => false
  }

  extend FriendlyId
  friendly_id :nickname, use: :slugged

  mount_uploader :avatar, MediaUploader

  def set_default_role
    self.role ||= :user
  end

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :invitable, :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :async, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter],
       :authentication_keys => [:login]

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end


 def update_with_password(params, *options)
    if super
      # TODO schedule this in the background
      UserMailer.delay.password_changed(self.id)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
          where(conditions.to_h).where(["lower(nickname) = :value OR lower(email) = :value", { :value => login.downcase }]).first
        else
          where(conditions.to_h).first
        end
      end


 def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

end
