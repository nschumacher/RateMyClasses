# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'httparty'
=begin
responce = HTTParty.get(URI.parse(URI.encode("http://api.purdue.io/odata/Instructors")))
for i in responce["value"]
	Instructor.create("name" => i["Name"], "email" => i["Email"])
end
=end

responce = HTTParty.get(URI.parse(URI.encode("http://api.purdue.io/odata/Subjects")))
for r in responce["value"]
    
    s = "http://api.purdue.io/odata/Courses?$filter=Subject/Abbreviation eq '"
    s << r["Abbreviation"]
    s << "'&$orderby=Number asc"
    
    identity = Department.create("abbreviation" => r["Abbreviation"], "name" => r["Name"])
    
    s = URI.encode(s)
    s = URI.parse(s)
    c = HTTParty.get(s)
    for v in c["value"]
        if v["Number"][0] != ""
            number = v["Number"].to_i
            if number < 45000
                Course.create( "courseNum" => v["Number"], "name" => v["Title"], "departmentID" => identity.id, "fullName" => r["Abbreviation"]+v["Number"], "department" => r["Abbreviation"], "departmentFull" => r["Name"])
            end
        end
    end
end
