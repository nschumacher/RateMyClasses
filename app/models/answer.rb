class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :course
	acts_as_votable
	validates :answer, presence: true
	
	def scoreAnswer
    	self.get_upvotes.sum(:vote_weight) - self.get_downvotes.sum(:vote_weight)
  	end

  	def scoreFlag
  		self.get_upvotes(:vote_scope => 'flag').sum(:vote_weight) - self.get_downvotes(:vote_scope => 'flag').sum(:vote_weight)
  	end
end
