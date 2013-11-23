class RefereesController < ApplicationController
    before_action only: [:new, :create] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_contest_creator__flash_danger_goes_to_root
        end
    end

    before_action only: [:edit, :update] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_user_owns_referee__flash_danger_goes_to_root
        end
    end

    before_action only: [:destroy] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_user_owns_referee__flash_danger_goes_to_root
        end
    end

    def new
        @referee = current_user.referees.build
    end

    def create
        @referee = current_user.referees.build(acceptable_params)
        if @referee.save
            flash[:success] = 'Referee created.'
            redirect_to @referee
        else
            flash.now[:danger] = "Invalid input."
            render :new
        end
    end

    def edit
        @referee = Referee.find(params[:id])
    end

    def update
        @referee = Referee.find(params[:id])
        if @referee.update(acceptable_params)
            flash[:success] = "Successfully updated #{@referee.name}."
            redirect_to @referee
        else
            flash.now[:danger] = "Invalid input."
            render :edit
        end
    end


    def show
        @referee = Referee.find(params[:id])
    end

    def index
        @referees = Referee.all
    end

    def destroy
        @referee = Referee.find(params[:id])
        flash[:success] = "#{@referee.name} deleted"
        @referee.destroy
        File.delete(@referee.file_location)
        redirect_to referees_path
    end

    private
    def acceptable_params
        params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
    end

end
