class SubscribeUserToMailingListJob <ActiveJob::Base
	queue_as :default
	require 'gibbon'

	def perform(user)
		gibbon = Gibbon::Request.new(api_key: "7485132cf5e6eb8ed339838df2ceb78e-us16")
		gibbon.timeout = 10
		gibbon.lists("4b2b17f02b").members.create(
			body:{
				email_address: user.email,
				status: "subscribed",
				merge_fields: {FNAME: user.name}
				})
	end
end
