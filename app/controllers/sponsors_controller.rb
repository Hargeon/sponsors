class SponsorsController < ApplicationController
  load_and_authorize_resource :user, parent: false

  def edit; end

  def update
    if CreateSearchCriteriaService.create?(@user, sponsor_params)
      redirect_to sponsor_path(@user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @interests = @user.interests.includes(:idea)
  end

  private

  def sponsor_params
    params.require(:user).permit(sponsor_industries_attributes: [:industry_id],
                                 sponsor_districts_attributes: [:district_id],
                                 sponsor_helps_attributes: [:require_help_id])
  end
end
