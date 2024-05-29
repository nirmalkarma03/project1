class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    before_action :authorize_request,unless: :active_admin_controller?

    def not_found
        render json: { error: 'not_found' }
    end
    
    def authorize_request
        header = request.headers['token']
        header = header.split(' ').last if header
        begin
          @decoded = JsonWebToken.decode(header)
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
    end
    private
    def active_admin_controller?
        is_a?(ActiveAdmin::BaseController)
    end
end
