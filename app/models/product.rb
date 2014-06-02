class Product < ActiveRecord::Base

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01, message: "must be at least 1 cent (0.01)"}
	validates :title, uniqueness: {message: "must be unique"}, length: {minimum: 10, message: "must be at least 10 characters long"}
	validates :image_url, allow_blank: true, format: {
		with:  /\.(gif|jpg|png)\z/i,
		message: 'must be a URL for gif, jpeg, or png image.'
	}
end
