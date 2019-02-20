class Match < ApplicationRecord

    def index
        render json: Match.all
    end

    def show 
        show_match = Match.all.find(params[:id])
            
        render json: showMatch
    end

    def update
        current_match.update(match_params)
        render json: current_match
    end

    def destroy
        current_match.destroy
        render json: current_match
    end

    def define_current_match
        if params[:id]
            @current_match = Match.find(params[:id])
        else
            @current_match = Match.new
        end
    end

    def current_match
        @current_match
    end

    def match_params
        params.permit(:id, :user1, :user1_response, :user2, :user2_response)
    end


end
