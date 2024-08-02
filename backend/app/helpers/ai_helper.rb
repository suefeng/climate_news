module AiHelper
  def ai_token
    ENV['AI_API_KEY'] || Rails.application.credentials.dig(:ai_token)
  end
  def assistant_token
    ENV['ASSISTANT_ID'] || Rails.application.credentials.dig(:assistant_id)
  end
end
