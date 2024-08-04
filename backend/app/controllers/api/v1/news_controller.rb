class Api::V1::NewsController < ApplicationController
  before_action :set_news, only: %i[show destroy]

  # GET /news
  def index
    @news = News.order(published_at: :desc, created_at: :desc)

    render json: @news, status: :ok
  end

  # GET /news/1
  def show
    render json: @news, status: :ok
  end

  # DELETE /news/1
  def destroy
    @news.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_news
    @news = News.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_params
    params.fetch(:news, {})
  end
end
