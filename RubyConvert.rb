#load 'inc/params.inc.rb'
#load 'inc/functions.inc.rb'
MAB_TXT = '../mab/mab4DS.txt'
BEG = '###'											#parameter: sign that indicates begin of set of data	
NUM = 4												#parameter: length of field name


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
#puts field_names.count {|b| /^#{BEG}/.match(b)}
#puts field_names.count do |b| /^#{BEG}/.match(b) end


arr = Array.new
i = 0
k = 0
for j in 0..field_names.count do
	if /^#{BEG}/.match(field_names[j]) != nil then
		i += 1 unless k == 0
		arr[i] = Array.new
		arr[i].push({field_names[j] => field_values[j]})
	else
		arr[i].push({field_names[j] => field_values[j]})
	end
	k +=1
end


#read dictionary from file


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