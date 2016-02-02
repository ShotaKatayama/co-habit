class ApplicationMailer < ActionMailer::Base
  default from: "co-habit運営局"
          bcc:      "sample+sent@gmail.com",
          reply_to: "sample+reply@gmail.com"
  layout 'mailer'
end
