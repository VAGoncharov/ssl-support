
#Если Сервер Тогда

Процедура Тест() экспорт
	
	Ссылки = ПолучитьСсылки();
	Результат = ОбщегоНазначения.ЗначенияРеквизитовОбъектов(Ссылки, "Поставщик, Родитель, Ссылка");
	
КонецПроцедуры


Функция ПолучитьСсылки()
    Результат = Новый Массив;// Массив из СправочникСсылка.Товары -
    Результат.Добавить(Справочники.Товары.ПустаяСсылка());
    Возврат Результат;
КонецФункции

#КонецЕсли