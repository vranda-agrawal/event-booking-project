class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :enrols, dependent: :destroy
  has_many :events, :through => :enrols

  after_destroy do
    Event.where(user_id:self.id).destroy_all
  end
  
end
