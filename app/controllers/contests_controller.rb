class ContestsController < ApplicationController
    before_action only: [:new, :create, :edit, :update] do
        ensure_user_logged_in
    end
=begin

    before_action only: [:destroy] do
        ensure_admin
    end
=end

    def new
        @contest = current_user.contests.build
    end

    def create
        @contest = current_user.contests.build(acceptable_params)
        @contest.referee = Referee.find(params[:contest][:referee])
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
        @contest.referee = Referee.find(params[:contest][:referee])
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
#            referee = Referee.find(params[:contest][:referee])
#            puts referee
            params.require(:contest).permit(:name, 
                                            :deadline, 
                                            :start, 
                                            :description, 
                                            :contest_type)#,
                                            #:referee)
#            end
        end
end
