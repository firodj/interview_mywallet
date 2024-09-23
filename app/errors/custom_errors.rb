module CustomErrors
  class UserNotAuthorized < StandardError; end
  class InsufficientBalance < StandardError; end
end