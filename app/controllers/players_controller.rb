class PlayersController < ApplicationController
    def new
        @player = current_user.players.build
    end

    def create
        @player = current_user.players.build(acceptable_params)
#        @contest.referee = Referee.find_by_id(params[:contest][:referee])
#        @contest.referee = Referee.find(params[:contest][:referee].to_i)
        if @player.save
            flash[:success] = 'Player created'
            redirect_to @player
        else
            flash.now[:danger] = 'Invalid input'
            render :new
        end
    end


    private 
        def acceptable_params
            params.require(:player).permit(:name, 
                                            :description, 
#                                            :downloadable, 
#                                            :playable,
                                            :contest_id)
        end
end
