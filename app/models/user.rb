# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  facebook_id      :string(128)      default(""), not null
#  name             :string(100)      default(""), not null
#  status           :integer          default(0), not null
#  encrypted_secret :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class User < ActiveRecord::Base
  SEEDS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  SEPARATOR = '-'

  enum status: {active: 0, banned: 99, withdraw: 1}

  has_many :devices
  has_one :user_attributes
  has_many :user_settings
  has_many :user_clip_recipes
  has_many :user_like_recipes
  has_many :recipes
  has_many :recipe_comments

  # TODO: random_iv使いたいがエラーがでるので一旦仮のkeyを設定しておく(要対応)
  #attr_encrypted :secret, :random_iv: true
  attr_encrypted :secret, key: 'yoshikazuapp'

  validates :secret, presence: true, on: :create

  before_validation :generate_secret, on: :create

  class << self
    def fetch_by_token!(token)
      raise Aroma::Error::AuthenticationFailed.new unless token.present?
      id, secret = token.split(SEPARATOR)
      user = find_by(id: id)
      logger.debug("correct_token: "+id+SEPARATOR+user.secret) if Rails.env.development?
      raise Aroma::Error::AuthenticationFailed.new unless user.present?
      raise Aroma::Error::AuthenticationFailed.new unless user.secret == secret
      user
    end

    def fetch_by_token(token)
      begin
        fetch_by_token!(token)
      rescue Aroma::Error::AuthenticationFailed
        nil
      end
    end
  end

  def token
    "#{self.id}#{SEPARATOR}#{self.secret}"
  end

  def active?
    status_value == self.class.statuses[:active]
  end

  def banned?
    !active?
  end

  def status_value
    self.class.statuses[status]
  end

  private
  def generate_secret
    return if self.secret.present?
    self.secret = Array.new(64) { SEEDS[rand(SEEDS.size)] }.join
  end

  #def setting_value(key)
  #  user_setting = self.user_settings.by_key(key).first
  #  return user_setting.present? ? user_setting.value : 0
  #end
end
