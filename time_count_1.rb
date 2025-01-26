
#Нужно сделать округление данные вносимых в хеш

####################################
#Методы
####################################


def time_fixing()
  Time.now.to_i #поменял с .to_f для секунд не нужно это
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

####################################
#Основной цикл
####################################

####################################
#Переменные
####################################

log = "./day_log.txt"

####################################
#Основная программа
####################################

accounting_ten_1 = pty_to_hs(log)

puts "Результары на сегодня: ruby - #{accounting_ten_1['ruby']}, git -
 #{accounting_ten_1['git']}, linux - #{accounting_ten_1['linux']}, english
  - #{accounting_ten_1['english']}, tools - #{accounting_ten_1['tools']} "

accounting_ten_1_sum = 0 # обнуляем начальное значение, чтобы посчитать сумму часов на начало учета
accounting_ten_1.each do |key, value|
	accounting_ten_1_sum += value
end

puts "Всего #{accounting_ten_1_sum.round(2)}"

puts "Осталось до цели #{10000 - accounting_ten_1_sum} "

print 'Готовы начать учет? Да/нет '
is_new_data = gets.chomp.downcase

if is_new_data == 'да' || is_new_data == 'yes'



loop do

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

  if wish == 'да' || wish == 'yes'

    time_end = time_fixing #останавливаем учет выбранного
    time_result = (time_end - time_start) / 60.0 / 60.0
    day_hs = pty_to_hs (log)
    day_hs[obj_count] += time_result.round(2) #округляется значение, которое попадет в хеш
    pty_to_txt(day_hs, log)
    puts "Вы работали #{time_result.round(2)} часов"
    
  end

end

end