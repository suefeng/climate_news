class NewsThreadsController < ApplicationController
  before_action :set_news_thread, only: %i[ show update destroy ]

  # GET /news_threads
  def index
    @news_threads = NewsThread.all

    render json: @news_threads
  end

  # GET /news_threads/1
  def show
    render json: @news_thread
  end

  # POST /news_threads
  def create
    @news_thread = NewsThread.new(news_thread_params)

    if @news_thread.save
      render json: @news_thread, status: :created, location: @news_thread
    else
      render json: @news_thread.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /news_threads/1
  def update
    if @news_thread.update(news_thread_params)
      render json: @news_thread
    else
      render json: @news_thread.errors, status: :unprocessable_entity
    end
  end

  # DELETE /news_threads/1
  def destroy
    @news_thread.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_thread
      @news_thread = NewsThread.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def news_thread_params
      params.fetch(:news_thread, {})
    end
end
