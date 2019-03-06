class UsersController < ApplicationController
    # before_action :define_current_user
    skip_before_action :authenticate, only: [ :create ]
    

    def create
        user = User.create(user_params)
        render json: user, methods: [ :token ]
    end

    def index
        render json: User.all
    end

    def show
        user = User.find(params[:id])
        render json: user
    end

    def update
        current_user.update(user_params)
        render json: current_user
    end

    def destroy
        current_user.destroy
        render json: current_user
    end



    def get_matchee_info 
        matchee = User.find(params[:matchee_id])
        render json: matchee 
    end

    def find_all_match_entries
        matchees = User.find_match_entries(current_user)
        render json: matchees
    end

    def user_params
        params.permit( :name, :email, :password, :bio, :gender, :age, :birthday, :image, :matchee_id )
    end
end