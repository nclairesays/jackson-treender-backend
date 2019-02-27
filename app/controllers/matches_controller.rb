class MatchesController < ApplicationController
    skip_before_action :authenticate, only: [ :check_for_existing_entry ]

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
        #checks for existing entries, if an extry exists for that user, update entry, if false, create entry
        # current_user = params[:current_user]
       
        binding.pry
  
        if Match.find_existing_entry(current_user, params[:matchee_id])
            filtered_entry = Match.find_existing_entry(current_user, params[:matchee_id])
            filtered_entry.update(user2_response: params[:current_user_response])
        else
            #make sure to include a conditinoal where you cannot be rematched twice if both slots are filled (Front end)
            filtered_entry = Match.create(user1_id: current_user.id, user1_response: params[:current_user_response], user2_id: params[:matchee_id])
        end 

        render json: filtered_entry
    end

    def user_matches
        matches = Match.filter_matches(current_user)
        render json: matches
    end



    # def get_potential_matchees
    #     #if you cannot find an existing entry, then .. render ALL users, BUT the 
    #     # if you can find existing entry, then render all BUT  those existing entries
    #     # need to fix this logic
    #     random = User.all.
    #         # where mapped entry is not current user
    #         user
    #     }
    #     # binding.pry
       
    #     render json: potential_matchees

    # end

  
    def match_params
        params.permit( :current_user_response, :matchee_id, :current_user )
    end 

end
