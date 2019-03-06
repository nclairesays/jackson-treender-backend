class MatchesController < ApplicationController
    # skip_before_action :authenticate, only: [ :check_for_existing_entry ]

    def index
        render json: Match.all
    end

    def show
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

    def check_for_existing_entry
        if Match.find_existing_entry(current_user, params[:matchee_id])
            filtered_entry = Match.find_existing_entry(current_user, params[:matchee_id])
            filtered_entry.update(user2_response: params[:current_user_response])
        elsif Match.find_completed_entries(current_user, params[:matchee_id]) == true
            filtered_entry = "YOU ALREADY SWIPED ON #{User.find(params[:matchee_id]).name}"
        else
            filtered_entry = Match.create(user1_id: current_user.id, user1_response: params[:current_user_response], user2_id: params[:matchee_id])
        end 
        render json: filtered_entry
    end

    def successful_matches
        matches = Match.filter_matches(current_user)           
        render json: matches
    end



    def get_potential_matchees
        # binding.pry
        potential_matchees = Match.get_potentials(current_user)
        render json: potential_matchees
    end
  
    def match_params
        params.permit( :current_user_response, :matchee_id, :current_user )
    end 

end
