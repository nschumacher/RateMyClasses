class AdminController < ApplicationController
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   def unflag
     @review = Review.find(params[:id])
     if current_user.admin? then
        @review.downvote_by current_user, vote_scope: 'flag', :vote_weight => 3, :duplicate => true
     end
     redirect_to :back
  end
end