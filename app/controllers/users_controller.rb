class UsersController < ApplicationController

    def create
        user = User.create(user_params)
        render json: user
    end

    def index
        render json: User.all
    end

    def show
        render json: current_user
    end

    def update
        current_user.update(user_params)
        render json: current_user
    end

    def destroy
        current_user.destroy
        render json: current_user
    end


    def user_params
        params.permit( :name )
    end
end