class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :course
	acts_as_votable
  mount_uploader :syllabus, SyllabusUploader
  validates :Comment, presence: true

	def scoreReview
    	self.get_upvotes.size - self.get_downvotes.size
  	end

  	def scoreFunny
  		self.find_votes_for(:vote_scope => 'funny').size
  	end

  	def scoreFlag
      self.get_upvotes(:vote_scope => 'flag').sum(:vote_weight) - self.get_downvotes(:vote_scope => 'flag').sum(:vote_weight)
  	end

    def getGrade(grade)
      case grade
      when 1
        return 'A'
      when 2
        return 'B'
      when 3
        return 'C'
      when 4
        return 'D'
      when 5
        return 'F'
      end
    end

end
