class PagesController < ApplicationController
  respond_to :html, :json
  def home
    @courses = Course.all
  end

  def contact
  end

  def privacypolicy
  end

  def results
  end
  
  def about
  end

 def Course_Profile
      @course = Course.find(params[:id])
      #@rev = Rate.where(rateable_id: params[:id]).select("review")      
      #@userreviews = @userprofile.userreviews.all
      #@userreview = @userprofile.userreviews.build
  end
  
  def admin
    @reviews = Review.all
    @answers = Answer.all
  end


end
