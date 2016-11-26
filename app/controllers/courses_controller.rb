class CoursesController < ApplicationController
	respond_to :html, :json
	def index
		@courses = Course.all
	end

	def show
		@course = Course.find(params[:id])
		@reviews = Review.where(course_id: @course.id)
	end

	def new
		@course = Course.new
	end
		
	def course_params
		params.require(:course).permit(:description)
	end

	def update
		@course = Course.find(params[:id])
    	@course.update(course_params)
    	respond_with @course
		#respond_to do |format|
		#	if @course.update(params(:course => :description))
		#		format.html { redirect_to @course, notice: "Descrption was successfully updated. Who did that? DEEZ NUTZ HAH GOTEM HAHA HAHAHA HAHAHA"}
		#		format.json { respond_with_bip(@course)}
		#	else
		#		format.html { render actions: 'edit' }
		#		format.json { respond_with_bip(@course) }
		#	end
		#end
	end

	def search
		if params[:search].present?
			# pads search results with zeros if necessary
			currentparams = params[:search]
			newparams = ""
			intcount = 0
			pos = 0
			if (currentparams =~ /\d/)
				while(pos < currentparams.length && pos < 8)
					newparams[pos] = currentparams[pos]
					if (currentparams[pos] =~ /\d/)
						intcount += 1
					end
					pos += 1
				end
				if (intcount < 4)
					newparams[pos] = "0"
					pos += 1
					newparams[pos] = "0"
				end
				@courses = Course.search(newparams, page: params[:page], per_page: 10)
			else
				# uses normal search results if no integers
				#  are present in the search params
				@courses = Course.search(params[:search], page: params[:page], per_page: 10)
			end
		else
			@courses = nil
		end
	end

	def update_lastedited
		@course = Course.find(params[:id])
		date = Time.now
		date.strftime("%B %e, %Y")
		@course.update_column(:lastEdited, date)
    	redirect_to :back
	end
end

