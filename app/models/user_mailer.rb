class UserMailer < ActionMailer::Base

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account!'
  
#    @body[:url]  = "http://#{request.host}#{(":" + request.port.to_s) if request.port != 80}/activate/#{user.activation_code}"
    @body[:url]  = "http://#{$email_host_name}/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{$email_host_name}/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "noreply@example.com"
      @subject     = "[Genealizer] "
      @sent_on     = Time.now
      @body[:user] = user
  end
  
  # def local_host_name
  #   RAILS_ENV == 'development' ? 'localhost:3000' : 'genealizer.prestonlee.com'
  # end
end
