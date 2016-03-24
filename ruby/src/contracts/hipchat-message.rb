require 'multi_json'

module Contracts
  class HipchatMessage
    attr_reader :sender, :message
    def initialize(json)
      message = MultiJson.load(json)['item']['message']
      @sender = message['from']['name']
      @message = message['message']
    end
  end
end
