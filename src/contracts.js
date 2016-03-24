module.exports = function(contracts) {
  return {
    HipChat: {
        messageFromRoomMessage: function() {
            return "I haz a hipchat!";
        }
    }
  };
}();
