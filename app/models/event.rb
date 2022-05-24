class Event < ApplicationRecord
  belongs_to :admin_user
  has_many :enrols, dependent: :destroy
  has_many :users, :through => :enrols
end
