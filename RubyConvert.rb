load 'inc/params.inc.rb'
#load 'inc/functions.inc.rb'


#read database from file
database = File.readlines(MAB_TXT)

#delete empty values from array
database.each do |value|
	database.delete(value) if value.strip == ''
end


#field names only
field_names = database.map do |value|
	value[0...NUM]
end

#field values only
string_end = database.length
field_values = database.map do |value|
	value[NUM...string_end]
end

#combine
nv = Array.new
n = field_names.count {|b| /^#{BEG}/.match(b)}


arr = Array.new
i = 0
k = 0
for j in 0..field_names.count do
	if /^#{BEG}/.match(field_names[j]) then
		i += 1 unless k == 0
		arr[i] = Array.new
		arr[i].push({field_names[j] => field_values[j]})
	else
		arr[i].push({field_names[j] => field_values[j]})
	end
	k +=1
end
i = nil
k = nil


#read dictionary from file
dict_file = File.readlines(DICT_TXT)

dict = Array.new
dict_file.each do |line|
	dict.push({line.gsub(/(^.{#{NUM}})(.*$)/, '\1').strip => line.gsub(/(^.{#{NUM}}\s*#{DICT_SEP})(.*$)/, '\2').strip})
end

puts dict

#convert




#write result in file #warning: no result yet
filename = 'conversion.txt'
regexp = '/^' + BEG + '/'
File.open("#{filename}", "w+") do |f|
	database.each do |line|
	f.write("\r\n") if regexp.match(line) and line != database[0] 			
	f.write(line)	
	end
end
regexp = nil
f = nil
filename = nil