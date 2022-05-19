class Event < ApplicationRecord
  has_many :enrols, dependent: :destroy
  has_many :users, :through => :enrols
end
