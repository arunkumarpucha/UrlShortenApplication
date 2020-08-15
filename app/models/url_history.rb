class UrlHistory < ApplicationRecord
	serialize :countries,Array
	serialize :ip_addresses,Array

	belongs_to :mini_url
end
