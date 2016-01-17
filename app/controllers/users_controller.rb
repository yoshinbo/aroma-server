class Api::V1::UsersController < ApplicationController
  #skip_before_action :authenticate, only: [:create]

  #validates :show do
  #  integer :id, required: true
  #end

  def create
    logger.debug("Hello, world!")
    #user = User.find_by(facebook_id: permitted_params[:facebook_id])
    #if user.present?
    #  @user = user
    #  @is_new = false
    #else
    #  @user = User.create!(permitted_params)
    #  @is_new = true
    #end
    #update_device(@user)
  end

  def show
    logger.debug("Hello, world!")
  end

#  private
#  def permitted_params
#    params.require(:user).permit(:facebook_id, :name)
#  end
end
