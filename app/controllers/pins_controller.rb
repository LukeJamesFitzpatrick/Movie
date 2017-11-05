class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy, :like]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pins = Pin.pin_search(params[:search]).page(params[:page]).per(6)
  end

  def like
    @like = @pin.likes.build(user_id: current_user.id)
    if @like.save
      redirect_to pins_path, notice: 'You liked this resource.'
    else
      redirect_to pins_path, notice: 'You have already liked this resource.'
    end
  end

  def show
    @pin = Pin.includes(:comments).find(params[:id])
    @comment = Comment.new
    @pin.count_views
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    @pin.view = 0
    if @pin.save
      redirect_to @pin, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find_by(id: params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this post" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image, :link)
    end
end
