OmniAuth.config.logger = Rails.logger

	Rails.application.config.middleware.use OmniAuth::Builder do
	  provider :facebook, '1990788754503259', 'a435a970242c270a4e9e4b12bded0d60'
	end