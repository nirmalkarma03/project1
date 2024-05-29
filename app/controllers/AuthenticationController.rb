class AuthenticationController < ApplicationController
    before_action :find_user, only: :login
    skip_before_action :authorize_request, only: :login
    def login
        # byebug
        render json: {token: JsonWebToken.encode(user_id: @user.id)}, status: :ok
    end

    private
    def find_user
        @user = User.find_by(email: params[:email])
        if @user.present?
            check_password(params[:password])
        else
            render json: {error: "user not found"}, status: :unprocessable_entity
        end
    end

    def check_password(password)
       unless @user&.authenticate(password)
        render json: {error: "invalid password"}, status: :unprocessable_entity
       end
    end


end