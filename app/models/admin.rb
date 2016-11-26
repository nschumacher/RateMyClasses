class Admin < ActiveRecord::Base
	def scoreFlag
      self.get_upvotes(:vote_scope => 'flag').sum(:vote_weight) - self.get_downvotes(:vote_scope => 'flag').sum(:vote_weight)
  	end

end
