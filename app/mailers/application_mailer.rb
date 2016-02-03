class ApplicationMailer < ActionMailer::Base
  default from: "co-habit運営局",
          bcc:      "cohabit.share@gmail.com",
          reply_to: "cohabit.share@gmail.com"
  layout 'mailer'
end
