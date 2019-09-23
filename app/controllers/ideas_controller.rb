class IdeasController < ApplicationController
    before_action :find_id, only: [:show, :destroy, :edit, :update]
    before_action :authenticate!, except: [:show, :index]
    before_action :authorize!, only: [:destroy, :edit, :update]
    def new
        @idea = Idea.new
    end

    def create
        @idea = Idea.new idea_params
        @idea.user = current_user
        if @idea.save
            redirect_to @idea, notice: "Your thought is out there for the world to see!"
        else
            render :new, alert: "We simply cannot put out something like that for the world! Please try something a little less brazen."
        end
    end

    def index
        @ideas = Idea.order(created_at: :desc)
    end

    def show
        @review = Review.new
    end
    
    def destroy
        @idea.destroy
        redirect_to ideas_path, notice: "That thing is outta here!"
    end
    
    def edit
    end
    
    def update
        if @idea.update idea_params
            redirect_to @idea, notice: "Now the world is ready for v2.0, or v2.0.1. Either way, idea updated!"
        else
            redirect_to ideas_path, alert: "Syntax Error: you crazy! Try again, we cannot update your idea like that!"
        end
    end

    private

    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def find_id
        @idea = Idea.find params[:id]
    end

    def authorize!
        redirect_to ideas_path, alert: "Not Authorized!" unless can? :crud, @idea
    end
end
