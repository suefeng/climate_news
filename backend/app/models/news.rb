class News < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
