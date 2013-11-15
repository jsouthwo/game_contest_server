class ContestsController < ApplicationController
    before_action only: [:new, :create] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_contest_creator__flash_danger_goes_to_root
        end
    end

    before_action only: [:edit, :update] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_user_owns_contest__flash_danger_goes_to_root
        end
    end

    before_action only: [:index] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_contest_creator__flash_danger_goes_to_root
        end
    end

    before_action only: [:destroy] do
        unless ensure_user_logged_in__flash_warn_goes_to_login
            ensure_user_owns_contest__flash_danger_goes_to_root
        end
    end


    def new
        @contest = current_user.contests.build
    end

    def create
        @contest = current_user.contests.build(acceptable_params)
        @contest.referee = Referee.find_by_id(params[:contest][:referee])
        #@contest.referee = Referee.find(params[:contest][:referee].to_i)
        if @contest.save
            flash[:success] = 'Contest created'
            redirect_to @contest
        else
            flash.now[:danger] = 'Invalid input'
            render :new
        end
    end

    def edit
        @contest = Contest.find(params[:id])
    end

    def update
        @contest = Contest.find(params[:id])
#        puts "PARAMS: " + params.to_s
        @contest.referee = Referee.find_by_id(params[:contest][:referee])
        #@contest.referee = Referee.find(params[:contest][:referee].to_i)
        if @contest.update(acceptable_params)
            flash[:success] = 'Contest updated'
            redirect_to @contest
        else
            flash.now[:danger] = 'Invalid input'
            render :new
        end
    end

    def show
        @contest = Contest.find(params[:id])
    end

    def index
        @contests = Contest.all
    end

    def destroy
        @contest = Contest.find(params[:id])
        flash[:success] = "#{@contest.name} deleted"
        @contest.destroy
        redirect_to contests_path
    end

    private 
        def acceptable_params
            params.require(:contest).permit(:name, 
                                            :deadline, 
                                            :start, 
                                            :description, 
                                            :contest_type,
                                            :referee_id)
        end
end
