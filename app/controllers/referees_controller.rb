class RefereesController < ApplicationController
    def new
        @referee = current_user.referees.build.new
    end

    def create
        @referee = current_user.referees.build.new(acceptable_params))
    end

=begin
    def create
    end

    def create
    end
=end

    private
        def acceptable_params
            params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
        end

end
