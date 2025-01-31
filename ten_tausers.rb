#реализовать задание периодов, например недельный период 6 дней рабочих 1 выходной +
#вахтовый период 30 дней рабочих 30 выходных + 
#сделать пояснения для выводимых данных
#сделать оконный ввод
#сохранять результаты


def ten_thousand(weekdays_hours, hollydays_hours, yet_is_hours, target_hours, period, weekdays, hollydays)
  #current_date - текущая дата, 
  #weekdays_hours, hollydays_hours - рабочие часы в будни и праздники
  #yet_is_hours уже отработано часов
  #target_hours - целевое количество часов

  #среднее количество рабочих часов в день
  average_hours = (weekdays * weekdays_hours + hollydays * hollydays_hours) / period 
  #p average_hours

  # нужно дней для программы занятий в target_hours часов
  amount_days = (target_hours - yet_is_hours)/average_hours # нужно дней для программы занятий в target_hours часов
  #p amount_days

  #целевая дата
  target_date = Time.now.to_r + amount_days.round * 24*60*60

  #Собираем данные для последующего сохранения и анализа
  result = {'Длительность периода' => period, 'Количество рабочих дней' => weekdays,
   'Количество праздничных дней' => hollydays, 'Рабочие часы в будни' => weekdays_hours,
    'Рабочие часы в праздники' => hollydays_hours, 'Количество уже отработанных часов' => yet_is_hours,
    'Целевое количество часов' => target_hours, 'Средний рабочий день (в часах)' => average_hours,
    "Нужно дней для программы занятий в #{target_hours} часов" => amount_days.round(1), 'Целевая дата' => target_date }

  #открываем файл
  file = File.new("./file.txt", "a:UTF-8")

  #пишем в файл
  file.print("#{result}\n\r")
  file.close

  

  p Time.at(target_date).strftime('%a %b %e %Y')
  
end

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
print("Введите количество уже отработанных часов: ")
yet_is_hours = gets.chomp.to_f
print("Введите целевое количество часов: ")
target_hours = gets.chomp.to_f

ten_thousand(weekdays_hours, hollydays_hours, yet_is_hours, target_hours, period, weekdays, hollydays)

