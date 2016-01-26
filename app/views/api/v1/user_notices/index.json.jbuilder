json.user_notices do
  json.array! @user_notices do |user_notice|
    json.partial! 'api/partial/user_notice', user_notice: user_notice
  end
end
