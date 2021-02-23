class Provider < ApplicationRecord
  has_many :transaction
  has_many :customer
end
