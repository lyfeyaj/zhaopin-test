#encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         # :recoverable, 
         :rememberable, 
         :trackable, 
         :validatable
  
  validates_uniqueness_of :username, :on => :create, :message => "该用户名已被占用, 请更换新的用户名"
  
  before_save :generate_uuid, :calc_uptime_since_sign_up
  
  def self.as_new_guest
    u = new username: 'guest', uuid: SecureRandom.uuid
    if u.save(validate: false)
      u
    end
  end
  
  def uptime
    if !guest?
      uptime_since_sign_up + calc_uptime + (self.updated_at - self.current_sign_in_at).round / 60
    else
      calc_uptime
    end
  end
  
  def calc_uptime
    (Time.zone.now - self.current_sign_in_at).round / 60
  end
  
  def email_required?
    false
  end
  
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
  
  def calc_uptime_since_sign_up
    self.uptime_since_sign_up += (Time.zone.now - self.updated_at).round / 60 if (self.updated_at && self.username != 'guest')
  end
  
  def guest?
    self.username == 'guest'
  end
  
end
