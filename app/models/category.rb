class Category < ApplicationRecord
  has_many :media
  has_many :phrases, through: :media
end
