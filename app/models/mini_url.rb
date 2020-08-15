class MiniUrl < ApplicationRecord
	has_many :url_histories

	MINI_URL_LENGTH = 5

	before_create :generate_mini_url,:sanitize

	def generate_mini_url
		url = ([*('a'..'z'),*('0'..'9')]).sample(MINI_URL_LENGTH).join
		old_url = MiniUrl.where(short_url: url).last
		if old_url.present?
			self.generate_mini_url
		else
			self.short_url = url
		end
	end


	def sanitize
		self.original_url.strip!
		self.sanitize_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
	  self.sanitize_url = "http://#{self.sanitize_url}"
	end
end
