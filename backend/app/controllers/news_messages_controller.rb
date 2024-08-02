class NewsMessagesController < ApplicationController
  before_action :set_news_message, only: %i[ show update destroy ]

  # GET /news_messages
  def index
    @news_messages = NewsMessage.all

    render json: @news_messages
  end

  # GET /news_messages/1
  def show
    render json: @news_message
  end

  # POST /news_messages
  def create
    @news_message = NewsMessage.new(news_message_params)

    if @news_message.save
      render json: @news_message, status: :created, location: @news_message
    else
      render json: @news_message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /news_messages/1
  def update
    if @news_message.update(news_message_params)
      render json: @news_message
    else
      render json: @news_message.errors, status: :unprocessable_entity
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
      params.fetch(:news_message, {})
    end
end
