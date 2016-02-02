require 'test_helper'

class ShareMailerTest < ActionMailer::TestCase
  test "send_to_share" do
    mail = ShareMailer.send_to_share
    assert_equal "Send to share", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
