class User < ActiveRecord::Base
  acts_as_token_authenticatable
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  after_update :send_password_change_email, if: :needs_password_change_email?
  has_many :notifications, foreign_key: :recipient_id
  has_many :devices
  has_many :identities
  acts_as_follower
  acts_as_liker


    # Include default devise modules. Others available are:
    # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :async, :validatable, :omniauth_providers => [:facebook, :twitter, :google_oauth2],
         :authentication_keys => [:login]

  attr_accessor :login

  validates :email, :presence => true, :uniqueness => true
  validates :nickname,
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


  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update


  def ensure_authentication_token
     if authentication_token.blank?
       self.authentication_token = generate_authentication_token
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
     recoverable.send_reset_password_instructions
     recoverable
   end

    def self.new_with_session(params, session)
     super.tap do |user|
       if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
         user.email = data["email"] if user.email.blank?
       end
     end
   end

   def generate_authentication_token
     loop do
       token = Devise.friendly_token
       break token unless User.where(authentication_token: token).first
     end
   end



   def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          nickname: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def skip_confirmation!
    self.confirmed_at = Time.now
  end


def subscribe_user_to_mailing_list
  SubscribeUserToMailingListJob.perform_later(self)
end


def needs_password_change_email?
 encrypted_password_changed? && persisted?
end

def send_password_change_email
  UserMailer.password_changed(id).deliver_later
end

end
