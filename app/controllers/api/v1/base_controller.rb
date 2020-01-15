module Api
  module V1
    class BaseController < ActionController::API
      rescue_from CanCan::AccessDenied do |exception|
        render json: { "message": 'error' }, status: 401
      end
    end
  end
end

