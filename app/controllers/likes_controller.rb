class LikesController < ApplicationController
    before_action :find_id
    before_action :authenticate!
    before_action :like!

    def create
        @like = Like.new(user_id: current_user.id, idea_id: @idea.id )
        if @like.save
            redirect_to @idea, notice: "Thumb in the air!"
        else
            redirect_to ideas_path, notice: "Try again!"
        end
    end

    def destroy
        @like = @idea.likes.find_by(user_id: current_user.id)
        @like.destroy
        redirect_to @idea, notice: "Poof! gone."
    end

    private

    def find_id
        @idea = Idea.find params[:idea_id]
    end

    def like!
        redirect_to ideas_path, alert: "Trying to like your own idea? what is next, buying follows? You cannot do that!" unless can? :like, @idea
    end
end
