json.array!(@questions) do |question|
  json.extract! question, :id, :question, :userID
  json.url question_url(question, format: :json)
end
