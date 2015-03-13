class SubsController < ApplicationController
  before_action :is_owner?, only: [:edit, :update]

  def new
    @sub = Sub.new

    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])

    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  # def destroy
  # end

  def index
    render :index
  end

  def show
    @sub = Sub.find(params[:id])

    render :show
  end

  private

  def is_owner?
    sub = Sub.find(params[:id])
    redirect_to sub_url(sub) unless current_user.id == sub.moderator_id
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
