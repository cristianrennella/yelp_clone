class Review < ActiveRecord::Base
	validates_presence_of :description
	validates :description, length: { minimum: 10 }

	belongs_to :user
	belongs_to :business
end