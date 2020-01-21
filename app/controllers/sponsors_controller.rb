class SponsorsController < ApplicationController
  load_and_authorize_resource :user, parent: false

  def edit; end

  def update
    if UpdateRecordService.new(@user).update(sponsor_params)
      redirect_to sponsor_path(@user)
    else
      render :edit
    end
  end

  def show
    @interests = @user.interests.includes(idea: :user)
  end

  private

  def sponsor_params
    params.require(:user).permit(sponsor_industries_attributes: [:industry_id],
                                 sponsor_districts_attributes: [:district_id],
                                 sponsor_helps_attributes: [:require_help_id])
  end
end
