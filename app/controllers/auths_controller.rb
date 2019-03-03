class AuthsController < ApplicationController 

    skip_before_action :authenticate, only: [ :create ]
    

    def create
        user = User.find_by({ email: params[:email] })
        # binding.pry
        if user.authenticate(params[:password]) # arguments??
            
            render json: user, methods: [ :token ]
        else
            render json: { error: true, message: 'Wrong email or password'}
        end
        
    end



end