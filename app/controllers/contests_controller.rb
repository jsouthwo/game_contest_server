class ContestsController < ApplicationController
    before_action only: [:new, :create] do
        ensure_user_logged_in
    end

    def new
        @contest = current_user.contests.build
    end

    def create
        @contest = current_user.contests.build(acceptable_params)
        # @contest.referee = Referee.find(params[:contest][:referee])
        if @contest.save
            flash[:success] = 'Contest created'
            redirect_to @contest
        else
            render :new
        end
    end

    def edit
        @contest = Contest.find(params[:id])
    end

    def update
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
