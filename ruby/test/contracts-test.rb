require 'test/unit'
require 'contracts/hipchat-message'

class TestHipchatMessage < Test::Unit::TestCase
  @@jiraIssueName = 'THX-1138'
  @@messageText = "Message containing #{@@jiraIssueName}"
  @@testReplyJson = <<JSON
{
  "event": "event",
  "item": {
    "message": {
      "date": "date",
      "from": {
        "id": "userId",
        "mention_name": "@JRandomUser",
        "name": "J. Random User"
      },
      "id": "messageId",
      "mentions": [
        {
          "id": "mentionedUserId",
          "mention_name": "@MentionedUser"
        }
      ],
      "message": "#{@@messageText}",
      "type": "Message Type"
    }
  }
}
JSON
  def test_sender
    msg = Contracts::HipchatMessage.new(@@testReplyJson)
    assert_equal(msg.sender, "J. Random User")
  end

  def test_message
    msg = Contracts::HipchatMessage.new(@@testReplyJson)
    assert_equal(msg.message, @@messageText)
  end
end
