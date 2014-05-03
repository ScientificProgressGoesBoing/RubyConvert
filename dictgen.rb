#load 'inc/params.inc.rb'
#load 'inc/functions.inc.rb'
MAB_TXT = './mab/mab4DS.txt'
BEG = '###'											#parameter: sign that indicates begin of set of data	
NUM = 4												#parameter: length of field name

database = File.readlines(MAB_TXT)


#delete empty values from array
database.each do |value|
	database.delete(value) if value.strip == ''
end

#puts database.kind_of?(Array)

#field names only
field_names = database.map do |value|
	value[0...NUM]
end


#save generated dictionary stub in file
Dir.mkdir('tmp') unless Dir.exists?('tmp')
filename = 'tmp/dictgen.txt'
regexp = '/^' + BEG + '/'
File.open("#{filename}", "w+") do |f|
	field_names.each do |line|
	f.write("\r\n") if regexp.match(line) and line != database[0] 					# ('/^' + BEG + '/').match(line)
	f.write(line)	
	end
end


#write unique field names in file
filename = 'conversion.txt'
regexp = '/^' + BEG + '/'
File.open("#{filename}", "w+") do |f|
	database.each do |line|
	f.write("\r\n") if regexp.match(line) and line != database[0] 					# ('/^' + BEG + '/').match(line)
	f.write(line)	
	end
end


#get field name count
field_name_count = field_names.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}	#field_names.uniq.inject({}) {|a, e| a.merge({e => field_names.count(e)})}
																						#inject = inject the result of the block into the parameter given to inject()
#write field name count in file
filename = 'tmp/count_field_names.txt'
File.open("#{filename}", "w+") do |f|
	field_name_count.each do |line|
	f.write("\r\n") if line != field_name_count[0] 											
	f.write(line)	
	end
end

regexp = nil
f = nil
filename = nil




