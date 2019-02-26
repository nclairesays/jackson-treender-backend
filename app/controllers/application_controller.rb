class ApplicationController < ActionController::API

    before_action :authenticate

    def decode_token(token)
        JWT.decode(token, 'jackson') # check on this...
    end

    def current_user     
        begin 
            method, token = request.headers['Authorization'].split(' ')
            payload, header = decode_token(token)
            
            User.find(payload["user_id"])
        rescue 
            nil
        end
    end


    # def current_user
    #     c=User.find(params[:current_user_id])
    #     # binding.pry
    # end

    def authenticate
        if !current_user
            render json: { error: true, message: 'Please Login'}
        end
    end
   
end
