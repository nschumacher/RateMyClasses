class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_course, only: [:edit, :update, :show, :create, :new]
  before_action :authenticate_user!
  before_action :check_user,  only: [:edit, :update, :destroy]

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.course_id = @cid.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to @cid, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @cid, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to pages_admin_path, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
     @review = Review.find(params[:id])
     if current_user.voted_up_on? @review then
        @review.unvote_by current_user
     else
        @review.upvote_by current_user
     end
     redirect_to :back
  end

  def downvote
     @review = Review.find(params[:id])
     if current_user.voted_down_on? @review then
        @review.unvote_by current_user
     else
        @review.downvote_by current_user
     end
     redirect_to :back
  end

  def funnyvote
     @review = Review.find(params[:id])
     if current_user.voted_on? @review, vote_scope: 'funny' then
        @review.unvote_by current_user, vote_scope: 'funny'
     else
        @review.upvote_by current_user, vote_scope: 'funny'
     end
     redirect_to :back
  end

  def flag
     @review = Review.find(params[:id])
     if current_user.voted_on? @review, vote_scope: 'flag' then
        @review.unvote_by current_user, vote_scope: 'flag', :duplicate => true
     else
        @review.upvote_by current_user, vote_scope: 'flag', :duplicate => true
     end
     redirect_to :back
  end

  def unflag
     @review = Review.find(params[:id])
     if current_user.admin? then
        @review.downvote_by current_user, vote_scope: 'flag', :vote_weight => 3, :duplicate => true
     end
     redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_course
      @cid = Course.find(params[:course_id])
    end

    def check_user
      unless (@review.user == current_user) || (current_user.admin?)
        redirect_to root_url, alert: "Sorry, this review belongs to someone else."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:UserID, :CourseID, :Comment, :HelpfulCount, :Unhelpful, :FunnyCount, :FlagCount, :Instructor, :TAs, :GradeReceived, :HoursAWeek, :TextbookRequired, :AttendanceRequired, :Semester, :YearTaken, :DepartmentID, :syllabus)
    end
end
