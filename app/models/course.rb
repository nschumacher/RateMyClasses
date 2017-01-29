class Course < ActiveRecord::Base
	has_many :reviews
	has_many :questions
	has_many :answers

	searchkick word_start: [:courseNum, :name, :department, :fullName, :departmentFull]

	# this tells searchkick what data to index for searching
	def search_data
		{
			courseNum: courseNum,
			name: name,
			department: department,
			fullName: fullName,
			departmentFull: departmentFull
		}
	end

	ratyrate_rateable "difficulty", "workload", "enjoyment"

	def average_rate
	    ratings = Rate.where(rateable_id: self.id)
	    total = 0
	    count = 0
	    ratings.each do |rate|
	    	if (rate.dimension.eql? "difficulty") || (rate.dimension.eql? "workload")	then
	    		rating = rate.stars;
	    		case rating
	    			when 1
	    				total = total + 5;
	    				count = count + 1;
	    				next;
	    			when 2
	    				total = total + 4;
	    				count = count + 1;
	    				next;
	    			when 3
	    				total = total + 3;
	    				count = count + 1;
	    				next;
	    			when 4
	    				total = total + 2;
	    				count = count + 1;
	    				next;
	    			when 5
	    				total = total + 1;
	    		      	count = count + 1;
	    				next;
	    		end
	    	else
	      		total = total + rate.stars
	    	end
	      count = count + 1
	    end

	    if count != 0
	      return total/count
	    else
	      return 0
	    end
	end

	def averageGrade
		total = 0
		puts "Begining of average Grade func"
		count = 0
		if self.reviews == nil then
			return nil
		end
		self.reviews.each do |r|
			puts "Looping through reviews"
			puts r.GradeReceived
			if !(r.GradeReceived == nil) then
				count = count + 1
				total = total + r.GradeReceived
			end
		end

		if count == 0 then
			return nil
		end

		avgG = total/count
		puts "avg"
		puts avgG

		case avgG
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
