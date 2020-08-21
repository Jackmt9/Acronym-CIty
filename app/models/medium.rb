class Medium < ApplicationRecord
    belongs_to :Category
    has_many :phrases
end
