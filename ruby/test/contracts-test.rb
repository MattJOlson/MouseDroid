require 'test/unit'
require 'contracts/hipchat-message'

class TestHipchatMessage < Test::Unit::TestCase

  def build_test_json(messageText)
    return <<JSON
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
      "message": "#{messageText}",
      "type": "Message Type"
    }
  }
}
JSON
  end

  def test_sender_should_parse_out_message_from_name
    msg = Contracts::HipchatMessage.new(build_test_json("whatever"))
    assert_equal(msg.sender, "J. Random User")
  end

  def test_message_should_parse_out_message_message
    msg = Contracts::HipchatMessage.new(build_test_json("whatever"))
    assert_equal(msg.message, "whatever")
  end

  def test_jira_issue_should_be_absent_when_not_present
    msg = Contracts::HipchatMessage.new(build_test_json("foobaz"))
    assert_false(msg.hasJiraIssue)
  end

  def test_jira_issue_should_be_found_when_present
    text = "Message containing THX-1138, which looks like a Jira issue"
    msg = Contracts::HipchatMessage.new(build_test_json(text))
    assert_true(msg.hasJiraIssue)
  end

  def test_jira_issue_should_be_extracted_when_present
    text = "Message containing THX-1138, which looks like a Jira issue"
    msg = Contracts::HipchatMessage.new(build_test_json(text))
    assert_equal(msg.jiraIssues, ["THX-1138"])
  end

  def test_multiple_jira_issues_should_be_found_in_the_message
    text = "DEP-31337 is the deploy task for THX-1138"
    msg = Contracts::HipchatMessage.new(build_test_json(text))
    assert_equal(msg.jiraIssues, ["DEP-31337", "THX-1138"])
  end

end
