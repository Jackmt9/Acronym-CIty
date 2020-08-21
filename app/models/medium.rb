class Medium < ApplicationRecord
    belongs_to :category
    has_many :phrases
end
