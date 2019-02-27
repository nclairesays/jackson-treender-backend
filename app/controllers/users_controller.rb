class UsersController < ApplicationController
    # before_action :define_current_user
    skip_before_action :authenticate, only: [ :create, :index, :update, :get_potential_matchees ]
    

    def create
        user = User.create(user_params)
        render json: user, methods: [ :token ]
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


    def get_potential_matchees
        # binding.pry
        potential_matchees = User.get_potentials(current_user)
        render json: potential_matchees
    end

    def user_params
        params.permit( :name, :email, :password, :bio )
    end
end