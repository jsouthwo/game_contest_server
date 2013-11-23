class PlayersController < ApplicationController
    before_action only: [:new, :create] do
        ensure_user_logged_in__flash_warn_goes_to_login
    end

    before_action only: [:edit, :update] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_user_owns_player__flash_danger_goes_to_root
        end
    end

    before_action only: [:destroy] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_user_owns_player__flash_danger_goes_to_root
        end
    end


    # /contests/:contest_id/players/new
    def new
        contest = Contest.find(params[:contest_id])
        @player = contest.players.build
    end

    # /contests/:contest_id/players/new
    def create
        contest = Contest.find(params[:contest_id])
        @player = contest.players.build(acceptable_params)
        @player.user = current_user
        if @player.save
            flash[:success] = 'Player created'
            redirect_to @player
        else
=begin
            errors = @player.errors.to_a
            errors.each do |e|
                puts e.to_s
            end
            puts
=end
            flash.now[:danger] = 'Invalid input'
            render :new
        end
    end

# WILL LOOK THE SAME AS OTHER MODELS
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
        contest = @player.contest
        @player = Player.find(params[:id])
        flash[:success] = "#{@player.name} deleted"
        @player.destroy
        File.delete(@player.file_location)
        redirect_to contest_players_path(contest)
    end

    def show
        @player = Player.find(params[:id])
    end

    def index
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
