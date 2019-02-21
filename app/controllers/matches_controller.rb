class MatchesController < ApplicationController
    # before_action :define_current_match
    # before_action :define_unresolved_matches


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

  
    def define_unresolved_matches
        if Match.filter_nils(current_user) != []
            @unresolved_matches = Match.filter_nils(current_user)
        end 
    end 

    def check_existing_entries
        #checks for existing entries, if an extry exists for that user, patch entry, if false, post entry

        if Match.filter_existing_entry(current_user, params[:matchee_id])
            filtered_entry = Match.filter_existing_entry(current_user, params[:matchee_id])
            filtered_entry.update(user2_response: params[:current_user_response])
        else
            filtered_entry = Match.create(user1_id: current_user.id, user1_response: params[:current_user_response], user2_id: params[:matchee_id])
        end 

      
        render json: filtered_entry
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
        params.permit( :user1_id, :user1_response, :user2_id, :user2_response, :current_user_response, :matchee_id)
    end 

end
