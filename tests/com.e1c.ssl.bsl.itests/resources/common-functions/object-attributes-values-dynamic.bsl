
#Если Сервер Тогда

Процедура Тест() экспорт
	
	Ссылка = ПолучитьСсылку();
	Результат = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, "Поставщик, Родитель, Ссылка");
	
КонецПроцедуры


Функция ПолучитьСсылку()
    Возврат Справочники.Товары.ПустаяСсылка();
КонецФункции

#КонецЕсли
