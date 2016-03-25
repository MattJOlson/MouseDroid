require 'multi_json'

module Contracts
  class HipchatMessage
    attr_reader :sender, :message, :jiraIssues
    def initialize(json)
      message = MultiJson.load(json)['item']['message']
      @sender = message['from']['name']
      @message = message['message']
      @jiraIssues = @message.scan(/[A-Z]{3,5}-\d+/)
    end

    def hasJiraIssue
      !@jiraIssues.empty?
    end
  end
end
