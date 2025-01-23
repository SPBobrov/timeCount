#Реализовать: передачу учтенного времени в хеш, запись хеша в txt
#Реализовать: передачу учтенного времени в программу accounting_ten.rb


def time_fixing()
    Time.now.to_f
end

def write_to_txt(adress, data)
    file = File.new(adress, "a:UTF-8")
    file.print(data)
	file.close
end

def pty_to_txt (hs, file_adress) #file_adress в виде "file_adress.txt"

	file = File.new(file_adress, "w:UTF-8")

	hs_converting = ''
	hs.each  {|key, value| hs_converting += "#{key}-#{value} "}
		
	file.print(hs_converting)

	file.close

end

def pty_to_hs (file_adress)

	file = File.new(file_adress, "r:UTF-8")
	string = file.read
	file.close
	arr = string.split(' ')
	
	arr1 = []

	arr.each do |item| 
		arr1 << item.split('-')
	end 

	hs ={}

	arr1.each do |item|
		hs[item[0]] = item[1].to_f
	end
	
	return hs
end

loop do

print 'Выберите объект учета ruby - 1, english - 2, linux - 3, git - 4, tools - 5 '
obj_count = gets.chomp.to_i

time_start = time_fixing #начинаем учет выбранного

if obj_count == 1
    log_adress = "./ruby.txt"
    obj_count = 'ruby'
elsif obj_count == 2
    log_adress = "./english.txt"
    obj_count = 'english'
elsif obj_count == 3
    log_adress = "./linux.txt"
    obj_count = 'linux'
elsif obj_count == 4
    log_adress = "./git.txt"
    obj_count = 'git'
elsif obj_count == 5
    log_adress = "./tools.txt"
    obj_count = 'tools'
else
    exit
end

write_to_txt(log_adress, time_start) #записываю начало времени учета в файл

print 'Остановить учет? Да/нет'
wish = gets.chomp.downcase

if wish == 'да' || wish == 'yes'
    time_end = time_fixing #останавливаем учет выбранного
    time_result = (time_end - time_start)/60/60
    day_hs = pty_to_hs ("./day_log.txt")
    day_hs[obj_count] += time_result.round(2)
    pty_to_txt(day_hs, "./day_log.txt")
    puts "Вы работали #{time_result.round(2)} часов"
    write_to_txt(log_adress, time_end) #записываю окончание учета в файл
end




end

