class UsersController < ApplicationController
    # before_action :find_user, only: [:show, :update, :destroy]
    skip_before_action :authorize_request, only: :create
    def index
        render json: User.all , status: :ok
    end

    def show
        # render json:{data: @user} , staus: :ok
        render json:{data: @current_user} , staus: :ok
    end

    def create 
        user = User.new(user_params)
        if user.save 
            render json: {data: user}, status: :created
        else
            render json: {error: user}, status: :unprocessable_entity
        end
    end

    def update 
        if @current_user.update(user_params)
            render json: {data: @current_user}, status: :ok
        else
            render json: {error: "Not update"}
        end
    end

    def destroy
        @current_user.delete
        render json: {message: "Record delete successfully"}
    end

    private

    def user_params
        params.require('data').permit(:name, :email, :gender, :status,:password, :created_at, :updated_at)
    end

    def find_user
        @user = User.find_by(id: params[:id])
        unless @user.present?
            render json: {message: "Not found"}
        end
    end
end