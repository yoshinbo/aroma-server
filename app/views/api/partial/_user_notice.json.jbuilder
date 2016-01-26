json.extract! user_notice, *[:id, :user_id, :from_id, :content_id, :content, :created_at, :updated_at]
json.notice_type user_notice.type_value
