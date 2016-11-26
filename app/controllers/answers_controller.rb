class AnswersController < ApplicationController
	  before_action :set_question, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
  # GET /questions
  # GET /questions.json
  def index
    @answers = Answer.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @answer = Answer.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to :back, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { redirect_to :back, alert: 'Answer cannot be empty.' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to :back, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
     @answer = Answer.find(params[:id])
     if current_user.voted_up_on? @answer then
        @answer.unvote_by current_user
     else
        @answer.upvote_by current_user
     end
     redirect_to :back
  end

  def downvote
     @answer = Answer.find(params[:id])
     if current_user.voted_down_on? @answer then
        @answer.unvote_by current_user
     else
        @answer.downvote_by current_user
     end
     redirect_to :back
  end

  def flag
     @answer = Answer.find(params[:id])
     if current_user.voted_on? @answer, vote_scope: 'flag' then
        @answer.unvote_by current_user, vote_scope: 'flag'
     else
        @answer.upvote_by current_user, vote_scope: 'flag'
     end
     redirect_to :back
  end

  def unflag
     @answer = Answer.find(params[:id])
     if current_user.admin? then
        @answer.downvote_by current_user, vote_scope: 'flag', :vote_weight => 3, :duplicate => true
     end
     redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:answer, :userID, :question_id)
    end
end
