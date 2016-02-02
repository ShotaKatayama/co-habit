# Preview all emails at http://localhost:3000/rails/mailers/share_mailer
class ShareMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/share_mailer/send_to_share
  def send_to_share
    ShareMailer.send_to_share
  end

end
