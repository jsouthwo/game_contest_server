class ContestsController < ApplicationController
    before_action only: [:new, :create] do
        ensure_user_logged_in
    end

    def new
        @contest = current_user.contests.build
    end

    def create
        @contest = current_user.contests.build(acceptable_params)
        if @contest.save
            flash[:success] = 'Contest created'
            redirect_to @contest
        else
            render :new
        end
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
