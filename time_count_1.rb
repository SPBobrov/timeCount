def time_fixing()
    Time.now.to_f
end

def write_to_txt(adress, data)
    file = File.new(adress, "w:UTF-8")
    file.print(data)
	file.close
end

loop do

print 'Выберите объект учета ruby - 1, english - 2, linux - 3, git - 4, tools - 5 '
obj_count = gets.chomp.to_i

time_start = time_fixing #начинаем учет выбранного

if obj_count == 1
    log_adress = "./ruby.txt"
elsif obj_count == 2
    log_adress = "./english.txt"
elsif obj_count == 3
    log_adress = "./linux.txt"
elsif obj_count == 4
    log_adress = "./git.txt"
elsif obj_count == 5
    log_adress = "./tools.txt"
else
    exit
end

write_to_txt(log_adress, time_start) #записываю начало времени учета в файл

print 'Остановить учет? Да/нет'
wish = gets.chomp.downcase

if wish == 'да' || wish == 'yes'
    time_end = time_fixing #останавливаем учет выбранного
    write_to_txt(log_adress, time_end) #записываю окончание учета в файл
    time_result = (time_end - time_start)/60/60.round(2)
    puts "Вы работали #{time_result} часов"
end




end

