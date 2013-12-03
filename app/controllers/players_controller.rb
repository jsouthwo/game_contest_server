class PlayersController < ApplicationController
    before_action :ensure_user_logged_in__flash_warn_goes_to_login, only: [:new, :create]

    before_action only: [:edit, :update, :destroy] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_user_owns_player__flash_danger_goes_to_root
        end
    end

    # /contests/:contest_id/players/new
    def new
        contest = Contest.find(params[:contest_id])
        @player = contest.players.build
    end

    def create
        contest = Contest.find(params[:contest_id])
        @player = contest.players.build(acceptable_params)
        @player.user = current_user
        if @player.save
            flash[:success] = 'Player created'
            redirect_to @player
        else
            flash.now[:danger] = 'Invalid input'
            render :new
        end
    end

    def edit
        @player = Player.find(params[:id])
    end

    def update
        @player = Player.find(params[:id])
        if @player.update(acceptable_params)
            flash[:success] = "Successfully updated #{@player.name}."
            redirect_to @player
        else
            flash.now[:danger] = "Invalid input."
            render :edit
        end
    end

    def destroy
        @player = Player.find(params[:id])
        flash[:success] = "#{@player.name} deleted"
        @player.destroy
        File.delete(@player.file_location)
        redirect_to contest_players_path(@player.contest)
    end

    def show
        @player = Player.find(params[:id])
        @matches = @player.player_matches
        @wins = 0
        @losses = 0
        @matches.each do |match|
            if match.result.downcase == "win"
                @wins += 1
            elsif match.result.downcase == "loss"
                @losses += 1
            end
        end

    end

    def index
        @contest = Contest.find(params[:contest_id])
        @players = Player.all
    end

    private 
    def acceptable_params
        params.require(:player).permit(:name, 
                                       :description, 
                                       :downloadable, 
                                       :playable,
                                       :contest_id,
                                       :user_id,
                                       :upload)
    end
end
