class PlayersController < ApplicationController

    # /contests/:contest_id/players/new
    def new
        contest = Contest.find(params[:contest_id])
        @player = contest.players.build
    end

    # /contests/:contest_id/players/new
    def create
        contest = Contest.find(params[:contest_id])
        @player = contest.players.build(acceptable_params)
        if @player.save
            flash[:success] = 'Player created'
            redirect_to @player
        else
            flash.now[:danger] = 'Invalid input'
            render :new
        end
    end

=begin WILL LOOK THE SAME AS OTHER MODELS
    def edit

    end

    def update
    end
=end

    private 
        def acceptable_params
            params.require(:player).permit(:name, 
                                            :description, 
#                                            :downloadable, 
#                                            :playable,
                                            :contest_id)
        end
end
