class User < ActiveRecord::Base
  acts_as_token_authenticatable
  enum role: [:user, :vip, :admin, :practitioner]
  after_initialize :set_default_role, :if => :new_record?
  after_update :send_password_change_email, if: :needs_password_change_email?
  has_many :notifications, foreign_key: :recipient_id
  acts_as_follower
  acts_as_liker

    # Include default devise modules. Others available are:
    # :lockable, :timeoutable
    devise :invitable, :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :async, :validatable, :omniauth_providers => [:facebook, :twitter],
         :authentication_keys => [:login]

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

   def identity_for(provider)
     identities.where(provider: provider).first
   end

   def twitter
       identities.where( :provider => "twitter" ).first
   end

     def twitter_client
       @twitter_client ||= Twitter.client( access_token: twitter.accesstoken )
     end

     def facebook
       identities.where( :provider => "facebook" ).first
     end

     def facebook_client
       @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
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
