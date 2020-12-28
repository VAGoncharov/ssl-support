

// Возвращает Истина, если функциональная подсистема существует в конфигурации.
// Предназначена для реализации вызова необязательной подсистемы (условного вызова).
// У функциональной подсистемы снят флажок "Включать в командный интерфейс".
// См. также ОбщегоНазначенияПереопределяемый.ПриОпределенииОтключенныхПодсистем
// и ОбщегоНазначенияКлиент.ПодсистемаСуществует для вызова из клиентского кода.
//
// Параметры:
//  ПолноеИмяПодсистемы - Строка - полное имя объекта метаданных подсистема
//                        без слов "Подсистема." и с учетом регистра символов.
//                        Например: "СтандартныеПодсистемы.ВариантыОтчетов".
//
// Пример:
//  Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ВариантыОтчетов") Тогда
//      МодульВариантыОтчетов = ОбщегоНазначения.ОбщийМодуль("ВариантыОтчетов");
//      МодульВариантыОтчетов.<Имя метода>();
//  КонецЕсли;
//
// Возвращаемое значение:
//  Булево - Истина, если подсистема существует.
//
Функция ПодсистемаСуществует(ПолноеИмяПодсистемы) Экспорт
    
    Возврат Истина;
    
КонецФункции

// Возвращает ссылку на общий модуль или модуль менеджера по имени.
//
// Параметры:
//  Имя - Строка - имя общего модуля.
//
// Возвращаемое значение:
//  ОбщийМодуль, МодульМенеджераОбъекта - общий модуль.
//
// Пример:
//	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ОбновлениеКонфигурации") Тогда
//		МодульОбновлениеКонфигурации = ОбщегоНазначения.ОбщийМодуль("ОбновлениеКонфигурации");
//		МодульОбновлениеКонфигурации.<Имя метода>();
//	КонецЕсли;
//
//	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПолнотекстовыйПоиск") Тогда
//		МодульПолнотекстовыйПоискСервер = ОбщегоНазначения.ОбщийМодуль("ПолнотекстовыйПоискСервер");
//		МодульПолнотекстовыйПоискСервер.<Имя метода>();
//	КонецЕсли;
//
Функция ОбщийМодуль(Имя) Экспорт
	
	Если Метаданные.ОбщиеМодули.Найти(Имя) <> Неопределено Тогда
		Модуль = Вычислить(Имя); // ВычислитьВБезопасномРежиме не требуется, т.к. проверка надежная.
	ИначеЕсли СтрЧислоВхождений(Имя, ".") = 1 Тогда
		Возврат СерверныйМодульМенеджера(Имя);
	Иначе
		Модуль = Неопределено;
	КонецЕсли;
	
	Если ТипЗнч(Модуль) <> Тип("ОбщийМодуль") Тогда
		ВызватьИсключение СтрШаблон(НСтр("ru = 'Общий модуль ""%1"" не найден.'"), Имя);
	КонецЕсли;
	
	Возврат Модуль;
	
КонецФункции


// Возвращает серверный модуль менеджера по имени объекта.
Функция СерверныйМодульМенеджера(Имя)
	ОбъектНайден = Ложь;
	
	ЧастиИмени = СтрРазделить(Имя, ".");
	Если ЧастиИмени.Количество() = 2 Тогда
		
		ИмяВида = ВРег(ЧастиИмени[0]);
		ИмяОбъекта = ЧастиИмени[1];
		
		Если ИмяВида = ВРег("Константы") Тогда
			Если Метаданные.Константы.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("РегистрыСведений") Тогда
			Если Метаданные.РегистрыСведений.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("РегистрыНакопления") Тогда
			Если Метаданные.РегистрыНакопления.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("РегистрыБухгалтерии") Тогда
			Если Метаданные.РегистрыБухгалтерии.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("РегистрыРасчета") Тогда
			Если Метаданные.РегистрыРасчета.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("Справочники") Тогда
			Если Метаданные.Справочники.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("Документы") Тогда
			Если Метаданные.Документы.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("Отчеты") Тогда
			Если Метаданные.Отчеты.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("Обработки") Тогда
			Если Метаданные.Обработки.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("БизнесПроцессы") Тогда
			Если Метаданные.БизнесПроцессы.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("ЖурналыДокументов") Тогда
			Если Метаданные.ЖурналыДокументов.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("Задачи") Тогда
			Если Метаданные.Задачи.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("ПланыСчетов") Тогда
			Если Метаданные.ПланыСчетов.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("ПланыОбмена") Тогда
			Если Метаданные.ПланыОбмена.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("ПланыВидовХарактеристик") Тогда
			Если Метаданные.ПланыВидовХарактеристик.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		ИначеЕсли ИмяВида = ВРег("ПланыВидовРасчета") Тогда
			Если Метаданные.ПланыВидовРасчета.Найти(ИмяОбъекта) <> Неопределено Тогда
				ОбъектНайден = Истина;
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
	Если Не ОбъектНайден Тогда
		ВызватьИсключение СтрШаблон(
			НСтр("ru = 'Объект метаданных ""%1"" не найден,
			|либо для него не поддерживается получение модуля менеджера.'"), Имя);
	КонецЕсли;
	
	Модуль = Вычислить(Имя); // ВычислитьВБезопасномРежиме не требуется, т.к. проверка надежная.
	
	Возврат Модуль;
КонецФункции


// Структура, содержащая значения реквизитов, прочитанные из информационной базы по ссылке на объект.
//
// Если необходимо зачитать реквизит независимо от прав текущего пользователя,
// то следует использовать предварительный переход в привилегированный режим.
//
// Параметры:
//  Ссылка    - ЛюбаяСсылка - объект, значения реквизитов которого необходимо получить.
//            - Строка      - полное имя предопределенного элемента, значения реквизитов которого необходимо получить.
//  Реквизиты - Строка - имена реквизитов, перечисленные через запятую, в формате
//                       требований к свойствам структуры.
//                       Например, "Код, Наименование, Родитель".
//            - Структура, ФиксированнаяСтруктура - в качестве ключа передается
//                       псевдоним поля для возвращаемой структуры с результатом, а в качестве
//                       значения (опционально) фактическое имя поля в таблице.
//                       Если ключ задан, а значение не определено, то имя поля берется из ключа.
//            - Массив, ФиксированныйМассив - имена реквизитов в формате требований
//                       к свойствам структуры.
//  ВыбратьРазрешенные - Булево - если Истина, то запрос к объекту выполняется с учетом прав пользователя, и в случае,
//                                    - если есть ограничение на уровне записей, то все реквизиты вернутся
//                                      со значением Неопределено;
//                                    - если нет прав для работы с таблицей, то возникнет исключение.
//                              - если Булево - Ложь, то возникнет исключение при отсутствии прав на таблицу
//                                или любой из реквизитов.
//
// Возвращаемое значение:
//  Структура - содержит имена (ключи) и значения затребованных реквизитов.
//            - если в параметр Реквизиты передана пустая строка, то возвращается пустая структура.
//            - если в параметр Ссылка передана пустая ссылка, то возвращается структура,
//              соответствующая именам реквизитов со значениями Неопределено.
//            - если в параметр Ссылка передана ссылка несуществующего объекта (битая ссылка),
//              то все реквизиты вернутся со значением Неопределено.
//
Функция ЗначенияРеквизитовОбъекта(Ссылка, Знач Реквизиты, ВыбратьРазрешенные = Ложь) Экспорт
	
	// Если передано имя предопределенного. 
	Если ТипЗнч(Ссылка) = Тип("Строка") Тогда 
		
		
	Иначе // Если передана ссылка.
		
		Попытка
			ПолноеИмяОбъектаМетаданных = Ссылка.Метаданные().ПолноеИмя(); 
		Исключение
			ВызватьИсключение НСтр("ru = 'Неверный первый параметр Ссылка: 
			                             |- Значение должно быть ссылкой или именем предопределенного элемента'");	
		КонецПопытки;
		
	КонецЕсли;
	
	// Разбор реквизитов, если второй параметр Строка.
	Если ТипЗнч(Реквизиты) = Тип("Строка") Тогда
		Если ПустаяСтрока(Реквизиты) Тогда
			Возврат Новый Структура;
		КонецЕсли;
		
		// Удаление пробелов.
		Реквизиты = СтрЗаменить(Реквизиты, " ", "");
		// Преобразование параметра в массив полей.
		Реквизиты = СтрРазделить(Реквизиты, ",");
	КонецЕсли;
	
	// Приведение реквизитов к единому формату.
	СтруктураПолей = Новый Структура;
	Если ТипЗнч(Реквизиты) = Тип("Структура")
		Или ТипЗнч(Реквизиты) = Тип("ФиксированнаяСтруктура") Тогда
		
		СтруктураПолей = Реквизиты;
		
	ИначеЕсли ТипЗнч(Реквизиты) = Тип("Массив")
		Или ТипЗнч(Реквизиты) = Тип("ФиксированныйМассив") Тогда
		
		Для Каждого Реквизит Из Реквизиты Цикл
			
			Попытка
				ПсевдонимПоля = СтрЗаменить(Реквизит, ".", "");
				СтруктураПолей.Вставить(ПсевдонимПоля, Реквизит);
			Исключение 
				// Если псевдоним не является ключом.
				
				// Поиск ошибки доступности полей.
				Результат = НайтиОшибкуДоступностиРеквизитовОбъекта(ПолноеИмяОбъектаМетаданных, Реквизиты);
				Если Результат.Ошибка Тогда 
					ВызватьИсключение СтрШаблон(
						НСтр("ru = 'Неверный второй параметр Реквизиты: %1'"), Результат.ОписаниеОшибки);
				КонецЕсли;
				
				// Не удалось распознать ошибку, проброс первичной ошибки.
				ВызватьИсключение;
			
			КонецПопытки;
		КонецЦикла;
	Иначе
		ВызватьИсключение СтрШаблон(
			НСтр("ru = 'Неверный тип второго параметра Реквизиты: %1'"), Строка(ТипЗнч(Реквизиты)));
	КонецЕсли;
	
	// Подготовка результата (после выполнения запроса переопределится).
	Результат = Новый Структура;
	
	// Формирование текста запроса к выбираемым полям.
	ТекстЗапросаПолей = "";
	Для каждого КлючИЗначение Из СтруктураПолей Цикл
		
		ИмяПоля = ?(ЗначениеЗаполнено(КлючИЗначение.Значение),
						КлючИЗначение.Значение,
						КлючИЗначение.Ключ);
		ПсевдонимПоля = КлючИЗначение.Ключ;
		
		ТекстЗапросаПолей = 
			ТекстЗапросаПолей + ?(ПустаяСтрока(ТекстЗапросаПолей), "", ",") + "
			|	" + ИмяПоля + " КАК " + ПсевдонимПоля;
		
		
		// Предварительное добавление поля по псевдониму в возвращаемый результат.
		Результат.Вставить(ПсевдонимПоля);
		
	КонецЦикла;
	
	// Если предопределенного нет в ИБ.
	// - приведение результата к отсутствию объекта в ИБ или передаче пустой ссылки.
	Если Ссылка = Неопределено Тогда 
		Возврат Результат;
	КонецЕсли;
	
	ТекстЗапроса = 
		"ВЫБРАТЬ " + ?(ВыбратьРазрешенные, "РАЗРЕШЕННЫЕ", "") + "
		|" + ТекстЗапросаПолей + "
		|ИЗ
		|	" + ПолноеИмяОбъектаМетаданных + " КАК Таблица
		|ГДЕ
		|	Таблица.Ссылка = &Ссылка
		|";
	
	// Выполнение запроса.
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.Текст = ТекстЗапроса;
	
	Попытка
		Выборка = Запрос.Выполнить().Выбрать();
	Исключение
		
		// Если реквизиты были переданы строкой, то они уже конвертированы в массив.
		// Если реквизиты - массив, оставляем без изменений.
		// Если реквизиты - структура - конвертируем в массив.
		// В остальных случаях уже было бы выброшено исключение.
		Если Тип("Структура") = ТипЗнч(Реквизиты) Тогда
			Реквизиты = Новый Массив;
			Для каждого КлючИЗначение Из СтруктураПолей Цикл
				ИмяПоля = ?(ЗначениеЗаполнено(КлючИЗначение.Значение),
							КлючИЗначение.Значение,
							КлючИЗначение.Ключ);
				Реквизиты.Добавить(ИмяПоля);
			КонецЦикла;
		КонецЕсли;
		
		// Поиск ошибки доступности полей.
		Результат = НайтиОшибкуДоступностиРеквизитовОбъекта(ПолноеИмяОбъектаМетаданных, Реквизиты);
		Если Результат.Ошибка Тогда 
			ВызватьИсключение СтрШаблон(
				НСтр("ru = 'Неверный второй параметр Реквизиты: %1'"), Результат.ОписаниеОшибки);
		КонецЕсли;
		
		// Не удалось распознать ошибку, проброс первичной ошибки.
		ВызватьИсключение;
		
	КонецПопытки;
	
	// Заполнение реквизитов.
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Значение реквизита, прочитанного из информационной базы по ссылке на объект.
//
// Если необходимо зачитать реквизит независимо от прав текущего пользователя,
// то следует использовать предварительный переход в привилегированный режим.
//
// Параметры:
//  Ссылка    - ЛюбаяСсылка - объект, значения реквизитов которого необходимо получить.
//            - Строка      - полное имя предопределенного элемента, значения реквизитов которого необходимо получить.
//  ИмяРеквизита       - Строка - имя получаемого реквизита.
//  ВыбратьРазрешенные - Булево - если Истина, то запрос к объекту выполняется с учетом прав пользователя, и в случае,
//                                    - если есть ограничение на уровне записей, то возвращается Неопределено;
//                                    - если нет прав для работы с таблицей, то возникнет исключение.
//                              - если Булево - Ложь, то возникнет исключение при отсутствии прав на таблицу
//                                или любой из реквизитов.
//
// Возвращаемое значение:
//  Произвольный - зависит от типа значения прочитанного реквизита.
//               - если в параметр Ссылка передана пустая ссылка, то возвращается Неопределено.
//               - если в параметр Ссылка передана ссылка несуществующего объекта (битая ссылка),
//                 то возвращается Неопределено.
//
Функция ЗначениеРеквизитаОбъекта(Ссылка, ИмяРеквизита, ВыбратьРазрешенные = Ложь) Экспорт
	
	Если ПустаяСтрока(ИмяРеквизита) Тогда 
		ВызватьИсключение НСтр("ru = 'Неверный второй параметр ИмяРеквизита: 
		                             |- Имя реквизита должно быть заполнено'");
	КонецЕсли;
	
	Результат = ЗначенияРеквизитовОбъекта(Ссылка, ИмяРеквизита, ВыбратьРазрешенные);
	Возврат Результат[СтрЗаменить(ИмяРеквизита, ".", "")];
	
КонецФункции 

// Значения реквизитов, прочитанные из информационной базы для нескольких объектов.
//
//  Если необходимо зачитать реквизит независимо от прав текущего пользователя,
//  то следует использовать предварительный переход в привилегированный режим.
//
// Параметры:
//  Ссылки - Массив - массив ссылок на объекты одного типа.
//                          Значения массива должны быть ссылками на объекты одного типа.
//                          если массив пуст, то результатом будет пустое соответствие.
//  Реквизиты - Строка - имена реквизитов перечисленные через запятую, в формате требований к свойствам
//                             структуры. Например, "Код, Наименование, Родитель".
//  ВыбратьРазрешенные - Булево - если Истина, то запрос к объектам выполняется с учетом прав пользователя, и в случае,
//                                    - если какой-либо объект будет исключен из выборки по правам, то этот объект
//                                      будет исключен и из результата;
//                              - если Булево - Ложь, то возникнет исключение при отсутствии прав на таблицу
//                                или любой из реквизитов.
//
// Возвращаемое значение:
//  Соответствие - список объектов и значений их реквизитов:
//   * Ключ - ЛюбаяСсылка - ссылка на объект;
//   * Значение - Структура - значения реквизитов:
//    ** Ключ - Строка - имя реквизита;
//    ** Значение - Произвольный - значение реквизита.
//
Функция ЗначенияРеквизитовОбъектов(Ссылки, Знач Реквизиты, ВыбратьРазрешенные = Ложь) Экспорт
	
	Если ПустаяСтрока(Реквизиты) Тогда 
		ВызватьИсключение НСтр("ru = 'Неверный второй параметр Реквизиты: 
		                             |- Поле объекта должно быть указано'");
	КонецЕсли;
	
	Если СтрНайти(Реквизиты, ".") <> 0 Тогда 
		ВызватьИсключение НСтр("ru = 'Неверный второй параметр Реквизиты: 
		                             |- Обращение через точку не поддерживается'");
	КонецЕсли;
	
	ЗначенияРеквизитов = Новый Соответствие;
	Если Ссылки.Количество() = 0 Тогда
		Возврат ЗначенияРеквизитов;
	КонецЕсли;
	
	ПерваяСсылка = Ссылки[0];
	
	Попытка
		ПолноеИмяОбъектаМетаданных = ПерваяСсылка.Метаданные().ПолноеИмя();
	Исключение
		ВызватьИсключение НСтр("ru = 'Неверный первый параметр Ссылки: 
		                             |- Значения массива должны быть ссылками'");
	КонецПопытки;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ " + ?(ВыбратьРазрешенные, "РАЗРЕШЕННЫЕ", "") + "
		|	Ссылка КАК Ссылка, " + Реквизиты + "
		|ИЗ
		|	" + ПолноеИмяОбъектаМетаданных + " КАК Таблица
		|ГДЕ
		|	Таблица.Ссылка В (&Ссылки)";
	Запрос.УстановитьПараметр("Ссылки", Ссылки);
	
	Попытка
		Выборка = Запрос.Выполнить().Выбрать();
	Исключение
		
		// Удаление пробелов.
		Реквизиты = СтрЗаменить(Реквизиты, " ", "");
		// Преобразование параметра в массив полей.
		Реквизиты = СтрРазделить(Реквизиты, ",");
		
		// Поиск ошибки доступности полей.
		Результат = НайтиОшибкуДоступностиРеквизитовОбъекта(ПолноеИмяОбъектаМетаданных, Реквизиты);
		Если Результат.Ошибка Тогда 
			ВызватьИсключение СтрШаблон(
				НСтр("ru = 'Неверный второй параметр Реквизиты: %1'"), Результат.ОписаниеОшибки);
		КонецЕсли;
		
		// Не удалось распознать ошибку, проброс первичной ошибки.
		ВызватьИсключение;
		
	КонецПопытки;
	
	Пока Выборка.Следующий() Цикл
		Результат = Новый Структура(Реквизиты);
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
		ЗначенияРеквизитов[Выборка.Ссылка] = Результат;
	КонецЦикла;
	
	Возврат ЗначенияРеквизитов;
	
КонецФункции

// Значения реквизита, прочитанного из информационной базы для нескольких объектов.
//
//  Если необходимо зачитать реквизит независимо от прав текущего пользователя,
//  то следует использовать предварительный переход в привилегированный режим.
//
// Параметры:
//  МассивСсылок       - Массив - массив ссылок на объекты одного типа.
//                                Значения массива должны быть ссылками на объекты одного типа.
//  ИмяРеквизита       - Строка - например, "Код".
//  ВыбратьРазрешенные - Булево - если Истина, то запрос к объектам выполняется с учетом прав пользователя, и в случае,
//                                    - если какой-либо объект будет исключен из выборки по правам, то этот объект
//                                      будет исключен и из результата;
//                              - если Булево - Ложь, то возникнет исключение при отсутствии прав на таблицу
//                                или любой из реквизитов.
//
// Возвращаемое значение:
//  Соответствие - Ключ - ссылка на объект, Значение - значение прочитанного реквизита.
//      * Ключ     - ссылка на объект,
//      * Значение - значение прочитанного реквизита.
//
Функция ЗначениеРеквизитаОбъектов(МассивСсылок, ИмяРеквизита, ВыбратьРазрешенные = Ложь) Экспорт
	
	Если ПустаяСтрока(ИмяРеквизита) Тогда 
		ВызватьИсключение НСтр("ru = 'Неверный второй параметр ИмяРеквизита: 
		                             |- Имя реквизита должно быть заполнено'");
	КонецЕсли;
	
	ЗначенияРеквизитов = ЗначенияРеквизитовОбъектов(МассивСсылок, ИмяРеквизита, ВыбратьРазрешенные);
	Для каждого Элемент Из ЗначенияРеквизитов Цикл
		ЗначенияРеквизитов[Элемент.Ключ] = Элемент.Значение[ИмяРеквизита];
	КонецЦикла;
		
	Возврат ЗначенияРеквизитов;
	
КонецФункции

// Возвращает менеджер объекта по полному имени объекта метаданных.
// Ограничение: не обрабатываются точки маршрутов бизнес-процессов.
//
// Параметры:
//  ПолноеИмя - Строка - полное имя объекта метаданных. Пример: "Справочник.Организации".
//
// Возвращаемое значение:
//  СправочникМенеджер, ДокументМенеджер, ОбработкаМенеджер, РегистрСведенийМенеджер - менеджер объекта.
// 
// Пример:
//  МенеджерСправочника = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени("Справочник.Организации");
//  ПустаяСсылка = МенеджерСправочника.ПустаяСсылка();
//
Функция МенеджерОбъектаПоПолномуИмени(ПолноеИмя) Экспорт
    
    Перем КлассОМ, ИмяОМ, Менеджер;
    
    ЧастиИмени = СтрРазделить(ПолноеИмя, ".");
    
    Если ЧастиИмени.Количество() >= 2 Тогда
        КлассОМ = ЧастиИмени[0];
        ИмяОМ   = ЧастиИмени[1];
    Иначе 
        Менеджер = Неопределено;
    КонецЕсли;
    
    Если      ВРег(КлассОМ) = "ПЛАНОБМЕНА" Тогда
        Менеджер = ПланыОбмена;
        
    ИначеЕсли ВРег(КлассОМ) = "СПРАВОЧНИК" Тогда
        Менеджер = Справочники;
        
    ИначеЕсли ВРег(КлассОМ) = "ДОКУМЕНТ" Тогда
        Менеджер = Документы;
        
    ИначеЕсли ВРег(КлассОМ) = "ЖУРНАЛДОКУМЕНТОВ" Тогда
        Менеджер = ЖурналыДокументов;
        
    ИначеЕсли ВРег(КлассОМ) = "ПЕРЕЧИСЛЕНИЕ" Тогда
        Менеджер = Перечисления;
        
    ИначеЕсли ВРег(КлассОМ) = "ОТЧЕТ" Тогда
        Менеджер = Отчеты;
        
    ИначеЕсли ВРег(КлассОМ) = "ОБРАБОТКА" Тогда
        Менеджер = Обработки;
        
    ИначеЕсли ВРег(КлассОМ) = "ПЛАНВИДОВХАРАКТЕРИСТИК" Тогда
        Менеджер = ПланыВидовХарактеристик;
        
    ИначеЕсли ВРег(КлассОМ) = "ПЛАНСЧЕТОВ" Тогда
        Менеджер = ПланыСчетов;
        
    ИначеЕсли ВРег(КлассОМ) = "ПЛАНВИДОВРАСЧЕТА" Тогда
        Менеджер = ПланыВидовРасчета;
        
    ИначеЕсли ВРег(КлассОМ) = "РЕГИСТРСВЕДЕНИЙ" Тогда
        Менеджер = РегистрыСведений;
        
    ИначеЕсли ВРег(КлассОМ) = "РЕГИСТРНАКОПЛЕНИЯ" Тогда
        Менеджер = РегистрыНакопления;
        
    ИначеЕсли ВРег(КлассОМ) = "РЕГИСТРБУХГАЛТЕРИИ" Тогда
        Менеджер = РегистрыБухгалтерии;
        
    ИначеЕсли ВРег(КлассОМ) = "РЕГИСТРРАСЧЕТА" Тогда
        
        Если      ЧастиИмени.Количество() = 2 Тогда
            Менеджер = РегистрыРасчета;
            
        ИначеЕсли ЧастиИмени.Количество() = 4 Тогда
            КлассПодчиненногоОМ = ЧастиИмени[2];
            ИмяПодчиненногоОМ = ЧастиИмени[3];
            
            Если ВРег(КлассПодчиненногоОМ) = "ПЕРЕРАСЧЕТ" Тогда 
                Менеджер = РегистрыРасчета[ИмяОМ].Перерасчеты;
                ИмяОм = ИмяПодчиненногоОМ;
                
            Иначе 
                Менеджер = Неопределено;
            КонецЕсли;
            
        Иначе
            Менеджер = Неопределено;
        КонецЕсли;
        
    ИначеЕсли ВРег(КлассОМ) = "БИЗНЕСПРОЦЕСС" Тогда
        Менеджер = БизнесПроцессы;
        
    ИначеЕсли ВРег(КлассОМ) = "ЗАДАЧА" Тогда
        Менеджер = Задачи;
        
    ИначеЕсли ВРег(КлассОМ) = "КОНСТАНТА" Тогда
        Менеджер = Константы;
        
    ИначеЕсли ВРег(КлассОМ) = "ПОСЛЕДОВАТЕЛЬНОСТЬ" Тогда
        Менеджер = Последовательности;
        
    Иначе
        Менеджер = Неопределено;
    КонецЕсли;
    
    Если Менеджер = Неопределено Тогда
        ВызватьИсключение "";
    КонецЕсли;
    
    Попытка
        Возврат Менеджер[ИмяОМ];
    Исключение
        ВызватьИсключение;
    КонецПопытки;
    
КонецФункции

// Возвращает менеджер объекта по ссылке на объект.
// Ограничение: не обрабатываются точки маршрутов бизнес-процессов.
// См. также ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени.
//
// Параметры:
//  Ссылка - ЛюбаяСсылка - объект, менеджер которого требуется получить.
//
// Возвращаемое значение:
//  СправочникМенеджер, ДокументМенеджер, ОбработкаМенеджер, РегистрСведенийМенеджер - менеджер объекта.
//
// Пример:
//  МенеджерСправочника = ОбщегоНазначения.МенеджерОбъектаПоСсылке(СсылкаНаОрганизацию);
//  ПустаяСсылка = МенеджерСправочника.ПустаяСсылка();
//
Функция МенеджерОбъектаПоСсылке(Ссылка) Экспорт
    
    ИмяОбъекта = Ссылка.Метаданные().Имя;
    ТипСсылки = ТипЗнч(Ссылка);
    
    Если Справочники.ТипВсеСсылки().СодержитТип(ТипСсылки) Тогда
        Возврат Справочники[ИмяОбъекта];
        
    ИначеЕсли Документы.ТипВсеСсылки().СодержитТип(ТипСсылки) Тогда
        Возврат Документы[ИмяОбъекта];
        
    ИначеЕсли БизнесПроцессы.ТипВсеСсылки().СодержитТип(ТипСсылки) Тогда
        Возврат БизнесПроцессы[ИмяОбъекта];
        
    ИначеЕсли ПланыВидовХарактеристик.ТипВсеСсылки().СодержитТип(ТипСсылки) Тогда
        Возврат ПланыВидовХарактеристик[ИмяОбъекта];
        
    ИначеЕсли ПланыСчетов.ТипВсеСсылки().СодержитТип(ТипСсылки) Тогда
        Возврат ПланыСчетов[ИмяОбъекта];
        
    ИначеЕсли ПланыВидовРасчета.ТипВсеСсылки().СодержитТип(ТипСсылки) Тогда
        Возврат ПланыВидовРасчета[ИмяОбъекта];
        
    ИначеЕсли Задачи.ТипВсеСсылки().СодержитТип(ТипСсылки) Тогда
        Возврат Задачи[ИмяОбъекта];
        
    ИначеЕсли ПланыОбмена.ТипВсеСсылки().СодержитТип(ТипСсылки) Тогда
        Возврат ПланыОбмена[ИмяОбъекта];
        
    ИначеЕсли Перечисления.ТипВсеСсылки().СодержитТип(ТипСсылки) Тогда
        Возврат Перечисления[ИмяОбъекта];
    Иначе
        Возврат Неопределено;
    КонецЕсли;
    
КонецФункции

// Выполняет поиск проверяемых выражений среди реквизитов объекта метаданных.
// 
// Параметры:
//  ПолноеИмяОбъектаМетаданных - Строка - полное имя проверяемого объекта.
//  ПроверяемыеВыражения       - Массив - имена полей или проверяемые выражения объекта метаданных.
// 
// Возвращаемое значение:
//  Структура - Результат проверки.
//  * Ошибка         - Булево - Найдена ошибка.
//  * ОписаниеОшибки - Строка - Описание найденных ошибок.
//
// Пример:
//  
// Реквизиты = Новый Массив;
// Реквизиты.Добавить("Номер");
// Реквизиты.Добавить("Валюта.НаименованиеПолное");
//
// Результат = ОбщегоНазначения.НайтиОшибкуДоступностиРеквизитовОбъекта("Документ._ДемоЗаказПокупателя", Реквизиты);
//
// Если Результат.Ошибка Тогда
//     ВызватьИсключение Результат.ОписаниеОшибки;
// КонецЕсли;
//
Функция НайтиОшибкуДоступностиРеквизитовОбъекта(ПолноеИмяОбъектаМетаданных, ПроверяемыеВыражения)
	
	МетаданныеОбъекта = Метаданные.НайтиПоПолномуИмени(ПолноеИмяОбъектаМетаданных);
	
	Если МетаданныеОбъекта = Неопределено Тогда 
		Возврат Новый Структура("Ошибка, ОписаниеОшибки", Истина, 
			СтрШаблон(
				НСтр("ru = 'Ошибка получения метаданных ""%1""'"), ПолноеИмяОбъектаМетаданных));
	КонецЕсли;

	// Разрешение вызова из безопасного режима внешней обработки или расширения.
	// Информация о доступности полей источника схемы при проверке метаданных не является секретной.
	УстановитьОтключениеБезопасногоРежима(Истина);
	УстановитьПривилегированныйРежим(Истина);
	
	Схема = Новый СхемаЗапроса;
	Пакет = Схема.ПакетЗапросов.Добавить(Тип("ЗапросВыбораСхемыЗапроса"));
	Оператор = Пакет.Операторы.Получить(0);
	
	Источник = Оператор.Источники.Добавить(ПолноеИмяОбъектаМетаданных, "Таблица");
	ТекстОшибки = "";
	
	Для Каждого ТекущееВыражение Из ПроверяемыеВыражения Цикл
		
		Если Не ПолеИсточникаСхемыЗапросаДоступно(Источник, ТекущееВыражение) Тогда 
			ТекстОшибки = ТекстОшибки + Символы.ПС + СтрШаблон(
				НСтр("ru = '- Поле объекта ""%1"" не найдено'"), ТекущееВыражение);
		КонецЕсли;
		
	КонецЦикла;
		
	Возврат Новый Структура("Ошибка, ОписаниеОшибки", Не ПустаяСтрока(ТекстОшибки), ТекстОшибки);
	
КонецФункции


// Используется в НайтиОшибкуДоступностиРеквизитовОбъекта.
// Выполняет проверку доступности поля проверяемого выражения в источнике оператора схемы запроса.
//
Функция ПолеИсточникаСхемыЗапросаДоступно(ИсточникОператора, ПроверяемоеВыражение)
	
	ЧастиИмениПоля = СтрРазделить(ПроверяемоеВыражение, ".");
	ДоступныеПоля = ИсточникОператора.Источник.ДоступныеПоля;
	
	ТекущаяЧастьИмениПоля = 0;
	Пока ТекущаяЧастьИмениПоля < ЧастиИмениПоля.Количество() Цикл 
		
		ТекущееПоле = ДоступныеПоля.Найти(ЧастиИмениПоля.Получить(ТекущаяЧастьИмениПоля)); 
		
		Если ТекущееПоле = Неопределено Тогда 
			Возврат Ложь;
		КонецЕсли;
		
		// Инкрементация следующей части имени поля и соответствующего списка доступности полей.
		ТекущаяЧастьИмениПоля = ТекущаяЧастьИмениПоля + 1;
		ДоступныеПоля = ТекущееПоле.Поля;
		
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

