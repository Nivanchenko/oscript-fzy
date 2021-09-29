Перем ОсновнойЦветТекста Экспорт; 
Перем ОсновнойЦветФона Экспорт;
Перем ВыбраннаяСтрока Экспорт;
Перем ВыводитьПодсказку Экспорт;

Перем НастройкиУправления;
Перем ПоследнееПоложениеКурсора;
Перем ДанныеНаЭкране;
Перем Поиск;
Перем РежимВвода;
Перем РезультатВыбора;
Перем ВыборСделан;
Перем ВыбратьКлюч;
Перем СмещениеСписка;
Перем ВысотаСписка;

Процедура ИнициализацияУправления()

	НастройкиУправления = Новый Соответствие();

	НастройкиУправления.Вставить(27, Новый Действие(ЭтотОбъект, "ОтменитьВыбор")); //ESC
	НастройкиУправления.Вставить(82, Новый Действие(ЭтотОбъект, "ИскатьВНайденном")); //r
	НастройкиУправления.Вставить(73, Новый Действие(ЭтотОбъект, "РежимВвода")); //i
	НастройкиУправления.Вставить(75, Новый Действие(ЭтотОбъект, "ВыборВверх")); //k
	НастройкиУправления.Вставить(74, Новый Действие(ЭтотОбъект, "ВыборВниз")); //j
	НастройкиУправления.Вставить(38, Новый Действие(ЭтотОбъект, "ВыборВверх")); //Стрелка вверх
	НастройкиУправления.Вставить(40, Новый Действие(ЭтотОбъект, "ВыборВниз")); //Стрелка вниз
	НастройкиУправления.Вставить(13, Новый Действие(ЭтотОбъект, "ВыбратьИзСписка")); //Enter

КонецПроцедуры

Процедура ВыбратьИзСписка() Экспорт

	РезультатВыбора = Поиск.РезультатПоиска[ВыбраннаяСтрока][?(ВыбратьКлюч = Истина, "Ключ", "Текст")];
	ВыборСделан = Истина;
	
КонецПроцедуры

Процедура ВыборВверх() Экспорт
	ВыбраннаяСтрока = МИН(ВыбраннаяСтрока+1, Поиск.РезультатПоиска.Количество() - 1);	
	Если ВыбраннаяСтрока > ВысотаСписка + СмещениеСписка Тогда
		СмещениеСписка = СмещениеСписка + 1;
	КонецЕсли;
КонецПроцедуры

Процедура ВыборВниз() Экспорт
	ВыбраннаяСтрока = МАКС(ВыбраннаяСтрока - 1, 0);
	Если ВыбраннаяСтрока <  СмещениеСписка Тогда
		СмещениеСписка = СмещениеСписка - 1;
	КонецЕсли;
КонецПроцедуры

Процедура РежимВвода() Экспорт
	РежимВвода = Истина;
КонецПроцедуры

Процедура ОтменитьВыбор() Экспорт
	ВыборСделан = Истина;
	РезультатВыбора = Неопределено;	
КонецПроцедуры

Процедура ИскатьВНайденном() Экспорт
	Поиск.ИскатьВНайденном = Не Поиск.ИскатьВНайденном;	
КонецПроцедуры

Процедура ПриСозданииОбъекта(_Поиск)
	ВыводитьПодсказку = Истина;
	СмещениеСписка = 0;
	ВыбратьКлюч = Ложь;
	ВыбраннаяСтрока = 0;
	РежимВвода = Истина;
	Поиск = _Поиск;
	ОсновнойЦветТекста = Консоль.ЦветТекста;
	ОсновнойЦветФона = Консоль.ЦветФона;
	ДанныеНаЭкране = Новый Массив();
	ЗапомнитьПоложениеКурсора();
	ИнициализацияУправления();	
КонецПроцедуры

Процедура ОтрисоватьЭкран() Экспорт
	Очистить();	
	Консоль.ВидимостьКурсора(РежимВвода);
	НижняяСтрока = Высота() - 1;
	ВысотаСписка = Высота() - 3;

	УказательВвода = ?(Поиск.ИскатьВНайденном = Истина, ">>", "> ");
	ВывестиТекстПоКоординатам(УказательВвода, НижняяСтрока, 1, ЦветКонсоли.Красный);

	ТекстНайденоВсего = СтрШаблон("Найдено %1 из %2", Поиск.НайденоВсего, Поиск.ВсегоВПоиске);
	ВывестиТекстПоКоординатам(ТекстНайденоВсего, НижняяСтрока - 1, 1);

	Если Поиск.НайденоВсего > 0 Тогда
		Для Счетчик = 0 По МИН(ВысотаСписка, Поиск.НайденоВсего) Цикл
			СтрокаСУчетомСмещения = Счетчик + СмещениеСписка;
			СтрокаНайденного = Поиск.РезультатПоиска[СтрокаСУчетомСмещения];
			ВывестиТекстПоКоординатам(СтрокаНайденного.Текст, НижняяСтрока - 2 - Счетчик, 1,, ?(СтрокаСУчетомСмещения = ВыбраннаяСтрока, ЦветКонсоли.Синий, Неопределено));
		КонецЦикла;
	КонецЕсли;

	Если ВыводитьПодсказку Тогда
		ТекстПодсказки = СтрШаблон("Смещение %1; ТекСтрока %2", СмещениеСписка, ВыбраннаяСтрока);
		ВывестиТекстПоКоординатам(ТекстПодсказки, 1, Ширина() - СтрДлина(ТекстПодсказки));
	КонецЕсли;
КонецПроцедуры

Процедура ОбработатьНажатие()
	НажатаяКнопка = Консоль.Прочитать();

	Действие = НастройкиУправления[НажатаяКнопка];
	Если НЕ Действие = Неопределено Тогда
		Действие.Выполнить();
	КонецЕсли;
КонецПроцедуры

Функция ОжидатьВводПоКоординатам(Верх, Лево)
	УстановитьКурсор(Верх, Лево);
	Возврат Консоль.ПрочитатьСтроку();
КонецФункции

Процедура ОбработатьВвод()

	ВведенныйТекст = ОжидатьВводПоКоординатам(Высота() - 1, 3);

	Поиск.НайтиЗначенияИлиКлючи(ВведенныйТекст);

	ВыбраннаяСтрока = 0;

	РежимВвода = Ложь;
	
КонецПроцедуры

Функция НачатьВыбор(Ключи = Ложь) Экспорт

	ВыбратьКлюч = Ключи;

	ВыборСделан = Ложь;
	РезультатВыбора = Неопределено;

	Пока НЕ ВыборСделан Цикл
		
		ОтрисоватьЭкран();

		Если РежимВвода = Истина Тогда
			ОбработатьВвод();
		Иначе
			ОбработатьНажатие();
		КонецЕсли;

	КонецЦикла;

	Консоль.Очистить();

	Возврат РезультатВыбора;
	
КонецФункции

Процедура ЗапомнитьПоложениеКурсора()
	Если ПоследнееПоложениеКурсора = Неопределено Тогда
		ПоследнееПоложениеКурсора = Новый Структура("Верх, Лево");
	КонецЕсли;
	ПоследнееПоложениеКурсора.Верх = Консоль.КурсорВерх;
	ПоследнееПоложениеКурсора.Лево = Консоль.КурсорЛево;
КонецПроцедуры

Процедура ВернутьКурсор()
	УстановитьКурсор(ПоследнееПоложениеКурсора.Верх, ПоследнееПоложениеКурсора.Лево);
КонецПроцедуры

Процедура УстановитьКурсор(Верх = 1, Лево = 1, Относительно = Ложь) Экспорт
	Если Относительно = Истина Тогда
		Консоль.КурсорВерх = ПоследнееПоложениеКурсора.Верх + Верх;
		Консоль.КурсорЛево = ПоследнееПоложениеКурсора.Лево + Лево;	
	Иначе
		Консоль.КурсорВерх = Верх;
		Консоль.КурсорЛево = Лево;	
	КонецЕсли;
КонецПроцедуры

Процедура Очистить() Экспорт
	Консоль.Очистить();	
КонецПроцедуры

Функция Высота() Экспорт
	Возврат Консоль.Высота;	
КонецФункции

Функция Ширина() Экспорт
	Возврат Консоль.Ширина;	
КонецФункции

Процедура УстановитьЦвета(ЦветТекста = Неопределено, ЦветФона = Неопределено)

	Консоль.ЦветТекста = ?(ЦветТекста = Неопределено, ОсновнойЦветТекста, ЦветТекста);
	Консоль.ЦветФона = ?(ЦветФона = Неопределено, ОсновнойЦветФона, ЦветФона);
	
КонецПроцедуры

Функция ВывестиТекстПоКоординатам(Текст, Верх, Лево, ЦветТекста = Неопределено, ЦветФона = Неопределено) Экспорт
	ЗапомнитьПоложениеКурсора();
	УстановитьКурсор(Верх, Лево);
	УстановитьЦвета(ЦветТекста, ЦветФона);
	Консоль.Вывести(Текст);
	УстановитьЦвета();
	ВернутьКурсор();
	Возврат ЭтотОбъект;	
КонецФункции

Функция ВывестиТекстОтносительно(Текст, Верх = 0, Лево = 0, ЦветТекста = Неопределено, ЦветФона = Неопределено) Экспорт
	ЗапомнитьПоложениеКурсора();
	УстановитьКурсор(Верх, Лево, Истина);
	УстановитьЦвета(ЦветТекста, ЦветФона);
	Консоль.Вывести(Текст);
	УстановитьЦвета();
	ВернутьКурсор();
	Возврат ЭтотОбъект;	
КонецФункции
