class ApplicationController < ActionController::API

    def current_user
        User.find(params[:user_id])
    end

    # if params[:id]
    #     @current_user = User.find(params[:id])
    # else
    #     @current_user = User.new
    # end
end
