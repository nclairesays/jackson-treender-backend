class ApplicationController < ActionController::API

    before_action :authenticate

    def decode_token(token)
        JWT.decode(token, 'jackson') # check on this...
        # binding.pry
    end

    def current_user   
        # User.find(46) 
        # binding.pry
       
        begin 
            
            method, token = request.headers['Authorization'].split(' ')
            # binding.pry

            payload, header = decode_token(token)
            # binding.pry

            User.find(payload["user_id"])
     

           
        rescue 
            # binding.pry
            nil
        end
    end



    def authenticate
        # binding.pry
        if !current_user
            render json: { error: true, message: 'Please Login'}
        end
    end
   
end
