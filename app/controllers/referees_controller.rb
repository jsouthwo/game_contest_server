class RefereesController < ApplicationController
    def new
        @referee = current_user.referees.build  #.new
    end

    def create
        @referee = current_user.referees.build(acceptable_params)
        if @referee.save
            flash[:success] = 'Referee created.'
            redirect_to @referee
        else
            render :new
        end
    end

    def show
        @referee = Referee.find(params[:id])
    end

    def index
        @referees = Referee.all
    end

    def destroy
=begin from users_controller.rb
        @user = User.find(params[:id])
        if current_user?(@user) then # Don't let admin delete self
            flash[:danger] = "Admin may not delete self."
            redirect_to root_path
        else
            flash[:success] = "#{@user.username} deleted"
            @user.destroy
            redirect_to users_path
        end
=end
    end

    private
        def acceptable_params
            params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
        end

end
