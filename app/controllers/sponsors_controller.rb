class SponsorsController < ApplicationController
  load_and_authorize_resource :user

  def edit
    if owner?
      @user = User.find(params[:id])
    else
      flash[:alert] = 'Access denied'
      redirect_to ideas_path
    end
  end

  def update
    if owner?
      @user = User.find(params[:id])
      if CreateSearchCriteriaService.create?(@user, sponsor_params)
        redirect_to sponsor_path(@user)
      else
        render :edit
      end
    else
      flash[:alert] = 'Access denied'
      redirect_to ideas_path
    end
  end

  def show
    @user = User.find(params[:id])
    @interests = @user.interests.includes(:idea)
    @available = owner?
  end

  private

  def sponsor_params
    params.require(:user).permit(sponsor_industries_attributes: [:industry_id],
                                 sponsor_districts_attributes: [:district_id],
                                 sponsor_helps_attributes: [:require_help_id])
  end

  def owner?
    if current_user&.sponsor? && (current_user&.id == params[:id].to_i)
      true
    else
      false
    end
  end
end
