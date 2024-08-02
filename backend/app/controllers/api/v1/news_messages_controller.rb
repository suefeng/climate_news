class Api::V1::NewsMessagesController < ApplicationController
  before_action :set_news_message, only: %i[show destroy]

  # GET /news_messages
  def index
    @news_messages = NewsMessage.all

    render json: @news_messages, status: :ok
  end

  # GET /news_messages/1
  def show
    render json: @news_message, status: :ok
  end

  # POST /news_messages
  def create
    query = params[:news_message][:message_body] || "What's the latest climate news for #{Date.today.strftime('%B %d, %Y')}"
    message = NewsMessage.find_by("message_body->>'query' = ? AND is_bot = ?", query, false)
    if message.nil?
      @news_message = NewsMessage.new(message_body: { query: }, is_bot: false)

      if @news_message.save
        render json: @news_message, status: :created
      else
        render json: @news_message.errors, status: :unprocessable_entity
      end
    else
      render json: { query: 'Already checked today. Check again tomorrow.' }, status: :ok
    end
  end

  # DELETE /news_messages/1
  def destroy
    @news_message.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_news_message
    @news_message = NewsMessage.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_message_params
    params.require(:news_message).permit(:message_body)
  end
end
