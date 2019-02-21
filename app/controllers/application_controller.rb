class ApplicationController < ActionController::API

    def current_user
        c=User.find(params[:current_user_id])
        # binding.pry
    end

    # if params[:id]
    #     @current_user = User.find(params[:id])
    # else
    #     @current_user = User.new
    # end

   
end
