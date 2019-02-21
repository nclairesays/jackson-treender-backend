class MatchesController < ApplicationController
    # before_action :define_current_match
    before_action :define_existing_matches


    def create
        match = Match.create(match_params)
        render json: match
    end

    def index
        render json: Match.all
    end

    def show
        render json: current_match
    end


    def update
        current_match.update(match_params)
        render json: current_match
    end

    def destroy
        current_match.destroy
        render json: current_match
    end


    def define_existing_matches
        if Match.filter_nils(current_user) != []
            @existing_matches = Match.filter_nils(current_user)
        else
            @existing_matches = nil
        end 
    end 

    def existing_matches
        @exisiting_matches
    end

    # def define_current_match
    #     # if current_user once we do auths??
    #     if params[:user_id]
    #         @current_match = Match.find(params[:id])
            
    #     else
    #         @current_match = Match.new
    #     end
    # end

    # def current_match
    #     @current_match
    # end

    def match_params
        params.permit( :user1_id, :user1_response, :user2_id, :user2_response)
    end 

end
