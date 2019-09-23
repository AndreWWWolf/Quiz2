class ReviewsController < ApplicationController
    before_action :authenticate!

    def create    
        @idea = Idea.find params[:idea_id]
        @review = Review.new review_params
        @review.user = current_user
        @review.idea = @idea
        if @review.save
            redirect_to idea_path(@review.idea_id), notice: "Thank you for the review!"
        else
            render 'ideas/show', alert: "Unable to create a review! Try again."
        end
    end

    def destroy
        @review = Review.find params[:id]
        if can? :crud, @review
            @review.destroy
            redirect_to idea_path(@review.idea_id), notice: "Review deleted!"
        else
            redirect_to ideas_path, alert: "Not Authorized!"
        end
    end

    private

    def review_params
        params.require(:review).permit(:body)
    end
end
