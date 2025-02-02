####################################
# Переменные
####################################

log_result = "./tc_log_result.txt" # Записываем общий результат учета по всем обектам учета 
                                   #в виде ruby-105.83 git-3.25 linux-4.4 english-7.4 tools-2.15

log_long =  "./long_log.txt"       #Записываем каждый факт учета с меткой даты-времени и комментарием (коммиты)

####################################
#Методы
####################################

#записываем хеш в текстовый файл (в частности "tc_log_result.txt")
#предыдущая запись затирается

def pty_to_txt (hs, file_adress) #file_adress в виде "file_adress.txt"

	file = File.new(file_adress, "w:UTF-8")

	hs_converting = ''
	hs.each  {|key, value| hs_converting += "#{key}-#{value} "}
		
	file.print(hs_converting)

	file.close

end

#читаем хеш из файла, возвращаем хеш

def pty_to_hs(file_adress)

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

#фиксация времени в секундах

def time_fixing()
  Time.now.to_i 
end

#записываем коммиты с комментариями

def write_to_txt(adress, data, message)
  file = File.new(adress, "a:UTF-8")
  file.print(Time.now.strftime('%m-%d-%Y %H:%M'))
  file.print(" #{message} ")
  file.puts(' ') #переводит строку в log файле
  file.print(data)
  file.puts(' ') #переводит строку в log файле
	file.close
end

#расчет прогнозной даты исходя из проектных данных

def ten_thousand(adress, weekdays_hours, hollydays_hours, target_hours, period, weekdays, hollydays)
  #current_date - текущая дата, 
  #weekdays_hours, hollydays_hours - рабочие часы в будни и праздники
  #yet_is_hours уже отработано часов
  #target_hours - целевое количество часов

  file = File.new(adress, "r:UTF-8")
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

  yet_is_hours = (hs.values.reduce(0) {|acc, v| acc +=v}).round(2)

  #среднее количество рабочих часов в день
  average_hours = (weekdays * weekdays_hours + hollydays * hollydays_hours) / period 
  #p average_hours

  # нужно дней для программы занятий в target_hours часов
  amount_days = (target_hours - yet_is_hours)/average_hours # нужно дней для программы занятий в target_hours часов
  #p amount_days

  #целевая дата
  target_date = Time.now.to_r + amount_days.round * 24*60*60

  p Time.at(target_date).strftime('%d-%m-%Y')
  
end

#расчет прогнозной даты на основе имеющихся данных

def according_to_average(file_adress, target_hours)

  date_start = Time.new(2025, 1, 1).to_i
  
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

  time_of_job = (hs.values.reduce(0) {|acc, v| acc +=v}).round(2)

  time_of_life = (Time.now.to_i - date_start)/60/60
  
  average_job_life = time_of_job/time_of_life

  target_date = Time.at(((target_hours - time_of_job) / average_job_life) * 60 *60 + Time.now.to_i).strftime('%d-%m-%Y')

  p target_date
  
end





# data = {"ruby"=>99.39, "git"=>2.75, "linux"=>3.9, "english"=>6.92, "tools"=>2.15}
# message = 'первый пробный коммит'

# write_to_txt(log_long, data, message)

####################################
#Основная программа
####################################

loop do

  print 'Начать учет/Редактировать учтенное время/Расчитать прогнозную дату/Выход 1/2/3/4 - '
  ansver1 = gets.chomp

  if ansver1 == '3'

    print 'Расчитать прогнозную дату исходя из проектных данных/исходя из имеющихся средних значений 1/2 - '
    ansver = gets.chomp

    if ansver == '1'

      print("Введите длительность периода: ")
      period = gets.chomp.to_f
      print("Введите количество рабочих дней: ")
      weekdays = gets.chomp.to_f
      print("Введите количество праздничных дней: ")
      hollydays = gets.chomp.to_f
      print("Введите рабочие часы в будни: ")
      weekdays_hours = gets.chomp.to_f
      print("Введите рабочие часы в праздники: ")
      hollydays_hours = gets.chomp.to_f
      print("Введите целевое количество часов: ")
      target_hours = gets.chomp.to_f

      ten_thousand(log_result, weekdays_hours, hollydays_hours, target_hours, period, weekdays, hollydays)

    elsif ansver == '2'

      print 'Введите целевое количество часов: '
      target_hours = gets.chomp.to_f

      according_to_average(log_result, target_hours)

    else

      exit

    end

  

  elsif ansver1 == '2'

    accounting_ten_1 = pty_to_hs(log_result)

    puts "Результары на сегодня: ruby - #{accounting_ten_1['ruby']}, git - #{accounting_ten_1['git']}, linux - #{accounting_ten_1['linux']}, english - #{accounting_ten_1['english']}, tools - #{accounting_ten_1['tools']} "

    accounting_ten_1_sum = 0 
    accounting_ten_1.each do |key, value|
      accounting_ten_1_sum += value
    end

    puts "Всего на сегодня отработано #{accounting_ten_1_sum.round(2)} часов"

    print 'Готовы ввести новые данные? Да/нет '
    is_new_data = gets.chomp.downcase

    if is_new_data == 'да' || is_new_data == 'yes' || is_new_data == 'lf' 

		
      print 'Введите количество часов ruby - '
      ruby_day = gets.chomp.to_f
      accounting_ten_1['ruby'] += ruby_day

      print 'Введите количество часов git - '
      git_day = gets.chomp.to_f
      accounting_ten_1['git'] += git_day

      print 'Введите количество часов linux - '
      linux_day = gets.chomp.to_f
      accounting_ten_1['linux'] += linux_day

      print 'Введите количество часов english - '
      english_day = gets.chomp.to_f
      accounting_ten_1['english'] += english_day

      print 'Введите количество часов tools - '
      tools_day = gets.chomp.to_f
      accounting_ten_1['tools'] += tools_day

      accounting_ten_1_sum_day = ruby_day + git_day + linux_day + english_day + tools_day
      accounting_ten_1_sum = 0 # обнуляем начальное значение, чтобы посчитать сумму часов на конец учета
      accounting_ten_1.each do |key, value|
      accounting_ten_1_sum += value
      end

      puts "Результары на сегодня: ruby - #{accounting_ten_1['ruby']}, git - #{accounting_ten_1['git']}, linux - #{accounting_ten_1['linux']}, english - #{accounting_ten_1['english']}, tools - #{accounting_ten_1['tools']} "
      pty_to_txt(accounting_ten_1, log_result)

    

    end

  elsif ansver1 == '1'
    
    print '[Выберите объект учета ruby - 1, english - 2, linux - 3, git - 4, tools - 5, закончить учет - 6] '
    obj_count = gets.chomp.to_i
      
    time_start = time_fixing #начинаем учет выбранного
  
  
    if obj_count == 1
      obj_count = 'ruby'
    elsif obj_count == 2
      obj_count = 'english'
    elsif obj_count == 3
      obj_count = 'linux'
    elsif obj_count == 4
      obj_count = 'git'
    elsif obj_count == 5
      obj_count = 'tools'
    elsif obj_count == 6 
      exit
    else
      exit
  
    end
    
    print 'Остановить учет позиции? Да/нет '
  
    wish = gets.chomp.downcase
  
    if wish == 'да' || wish == 'yes' || wish == 'lf'
      print 'Сделайте комментарий'
      message = gets.chomp
  
      time_end = time_fixing #останавливаем учет выбранного
      time_result = ((time_end - time_start) / 60.0 / 60.0).round(2) #округляется значение, которое попадет в хеш
      day_hs = pty_to_hs(log_result)
      day_hs[obj_count] += time_result 

      pty_to_txt(day_hs, log_result)

      puts "Вы работали #{time_result.round(2)} часов"
      
    end
  
    write_to_txt(log_long, day_hs, message)

  elsif ansver1 == 4

    exit

  else
    
    exit
  
  end


end



