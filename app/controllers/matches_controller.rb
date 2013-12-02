class MatchesController < ApplicationController
    ## Aren't currently supporting all actions
    def show
        @match = Match.find(params[:id])
    end

    def index
        ## Probably not correct
        @matches = Match.all
    end

end
