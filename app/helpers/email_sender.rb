
def create_link password_token
	"#{request.url.to_s}/#{password_token.to_s}"
end

def send_password_reset(email, link)
  RestClient.post "https://api:key-d733bc88a2fb89d47ef91cfa2a5fb31a"\
  "@api.mailgun.net/v2/sandbox8e90015459c74825b6714ab541d9ac60.mailgun.org/messages",
  :from => "Clucker <postmaster@sandbox8e90015459c74825b6714ab541d9ac60.mailgun.org>",
  :to => "<#{email}>",
  :subject => "Password Reset",
  :text => "Please click the link below to reset your password\n#{link}."
end