calDateFormat = "Mon/DD/yyyy";

//BLU SCURO --> #000033
//31639a
//d4d8e8
//b5c8d6

// CALENDAR COLORS
topBackground    = "#FFFFFF";         // BG COLOR OF THE TOP FRAME
bottomBackground = "#FFFFFF";         // BG COLOR OF THE BOTTOM FRAME
tableBGColor     = "#FFFFFF";         // BG COLOR OF THE BOTTOM FRAME'S TABLE
tableBorderColor = "#FFFFFF";
cellColor        = "#d4d8e8";     // TABLE CELL BG COLOR OF THE DATE CELLS IN THE BOTTOM FRAME
headingCellColor = "#31639a";         // TABLE CELL BG COLOR OF THE WEEKDAY ABBREVIATIONS
headingTextColor = "#FFFFFF";         // TEXT COLOR OF THE WEEKDAY ABBREVIATIONS
dateColor        = "#000000";          // TEXT COLOR OF THE LISTED DATES (1-28+)
focusColor       = "#000000";       // TEXT COLOR OF THE SELECTED DATE (OR CURRENT DATE)
hoverColor       = "#FF0000";       // TEXT COLOR OF A LINK WHEN YOU HOVER OVER IT
fontStyle        = "bold 8pt Verdana";           // TEXT STYLE FOR DATES
headingFontStyle = "bold 8pt Verdana";      // TEXT STYLE FOR WEEKDAY ABBREVIATIONS

// FORMATTING PREFERENCES
bottomBorder  = false;        // TRUE/FALSE (WHETHER TO DISPLAY BOTTOM CALENDAR BORDER)
tableBorder   = 0;            // SIZE OF CALENDAR TABLE BORDER (BOTTOM FRAME) 0=none

// DETERMINE BROWSER BRAND
var isNav = false;
var isIE  = false;

// ASSUME IT'S EITHER NETSCAPE OR MSIE
if (navigator.appName == "Netscape") {
	isNav = true;
}else {
	isIE = true;
}

// GET CURRENTLY SELECTED LANGUAGE
selectedLanguage = "ENG";

// PRE-BUILD PORTIONS OF THE CALENDAR WHEN THIS JS LIBRARY LOADS INTO THE BROWSER
buildCalParts();

// SET THE INITIAL VALUE OF THE GLOBAL DATE FIELD
function setDateField(dateField) {
	// ASSIGN THE INCOMING FIELD OBJECT TO A GLOBAL VARIABLE
	calDateField = dateField;

	// GET THE VALUE OF THE INCOMING FIELD
	inDate = dateField.value;

	// SET calDate TO THE DATE IN THE INCOMING FIELD OR DEFAULT TO TODAY'S DATE
	setInitialDate();

	// THE CALENDAR FRAMESET DOCUMENTS ARE CREATED BY JAVASCRIPT FUNCTIONS
	calDocTop    = buildTopCalFrame();
	calDocBottom = buildBottomCalFrame();
}

function getMonthNumberByName(monthName){
	var monthNumber = "";
	switch(monthName){
		case "Jan":monthNumber = "01";break;
		case "jan":monthNumber = "01";break;
		case "Feb":monthNumber = "02";break;
		case "feb":monthNumber = "02";break;
		case "Mar":monthNumber = "03";break;
		case "mar":monthNumber = "03";break;
		case "Apr":monthNumber = "04";break;
		case "apr":monthNumber = "04";break;
		case "May":monthNumber = "05";break;
		case "may":monthNumber = "05";break;
		case "Jun":monthNumber = "06";break;
		case "jun":monthNumber = "06";break;
		case "Jul":monthNumber = "07";break;
		case "jul":monthNumber = "07";break;
		case "Aug":monthNumber = "08";break;
		case "aug":monthNumber = "08";break;
		case "Sep":monthNumber = "09";break;
		case "sep":monthNumber = "09";break;
		case "Oct":monthNumber = "10";break;
		case "oct":monthNumber = "10";break;
		case "Nov":monthNumber = "11";break;
		case "nov":monthNumber = "11";break;
		case "Dec":monthNumber = "12";break;
		case "dec":monthNumber = "12";break;
	}
	return monthNumber;
}
// SET THE INITIAL CALENDAR DATE TO TODAY OR TO THE EXISTING VALUE IN dateField
function setInitialDate() {
	// CREATE A NEW DATE OBJECT (WILL GENERALLY PARSE CORRECT DATE EXCEPT WHEN "." IS USED AS A DELIMITER)
	// (THIS ROUTINE DOES *NOT* CATCH ALL DATE FORMATS, IF YOU NEED TO PARSE A CUSTOM DATE FORMAT, DO IT HERE)
	if(inDate != ""){
		var dateArray = inDate.split("/");
		dateArray[0] = getMonthNumberByName(dateArray[0]);
		inDate = dateArray[0] + "/" + dateArray[1] + "/" + dateArray[2];
	}

	calDate = new Date(inDate);

	// IF THE INCOMING DATE IS INVALID, USE THE CURRENT DATE
	if (isNaN(calDate)) {
		// ADD CUSTOM DATE PARSING HERE
		// IF IT FAILS, SIMPLY CREATE A NEW DATE OBJECT WHICH DEFAULTS TO THE CURRENT DATE
		calDate = new Date();
	}

	// KEEP TRACK OF THE CURRENT DAY VALUE
	calDay  = calDate.getDate();

	// SET DAY VALUE TO 1... TO AVOID JAVASCRIPT DATE CALCULATION ANOMALIES
	// (IF THE MONTH CHANGES TO FEB AND THE DAY IS 30, THE MONTH WOULD CHANGE TO MARCH
	//  AND THE DAY WOULD CHANGE TO 2.  SETTING THE DAY TO 1 WILL PREVENT THAT)
	calDate.setDate(1);
}

// POPUP A WINDOW WITH THE CALENDAR IN IT
function showCalendar(dateField) {
	// SET INITIAL VALUE OF THE DATE FIELD AND CREATE TOP AND BOTTOM FRAMES
	setDateField(dateField);
	// USE THE JAVASCRIPT-GENERATED DOCUMENTS (calDocTop, calDocBottom) IN THE FRAMESET
	calDocFrameset =  "<HTML><HEAD><TITLE>JavaScript Calendar</TITLE></HEAD>\n" +
		"<FRAMESET ROWS='65,*' FRAMEBORDER='0'>\n" +
		"  <FRAME NAME='topCalFrame' SRC='javascript:parent.opener.calDocTop' SCROLLING='no' noresize>\n" +
		"  <FRAME NAME='bottomCalFrame' SRC='javascript:parent.opener.calDocBottom' SCROLLING='no' noresize>\n" +
		"</FRAMESET>\n";

	// DISPLAY THE CALENDAR IN A NEW POPUP WINDOW
	top.newWin = window.open("javascript:parent.opener.calDocFrameset", "calWin", winPrefs);
	top.newWin.focus();
}

// CREATE THE TOP CALENDAR FRAME
function buildTopCalFrame() {
	// CREATE THE TOP FRAME OF THE CALENDAR
	var calDoc = "<HTML>" + "<HEAD>" + "<link rel='stylesheet' href='stile_calendario.css' type='text/css'>" +
		"</HEAD>" + "<BODY BGCOLOR='" + topBackground + "' topmargin=5 marginwidth=0 marginheight=0>" +
		"<FORM NAME='calControl' onSubmit='return false;'>" + "<CENTER>" +
		"<TABLE CELLPADDING=0 CELLSPACING=1 BORDER=0>" + "<TR><TD COLSPAN=7>" + "<CENTER>" +
		getMonthSelect() +
		"<INPUT NAME='year' VALUE='" + calDate.getFullYear() + "'TYPE=TEXT SIZE=4 MAXLENGTH=4 onChange='parent.opener.setYear()'>" +
		"</CENTER>" + "</TD>" + "</TR>" + "<TR>" + "<TD COLSPAN=7>" + "<INPUT class='button' " +
		"TYPE=BUTTON NAME='previousYear' VALUE='<<'    onClick='parent.opener.setPreviousYear()'><INPUT class='button' " +
		"TYPE=BUTTON NAME='previousMonth' VALUE=' < '   onClick='parent.opener.setPreviousMonth()'><INPUT class='button' " +
		"TYPE=BUTTON NAME='today' VALUE='Today' onClick='parent.opener.setToday()'><INPUT class='button' " +
		"TYPE=BUTTON NAME='nextMonth' VALUE=' > '   onClick='parent.opener.setNextMonth()'><INPUT class='button' " +
		"TYPE=BUTTON NAME='nextYear' VALUE='>>'    onClick='parent.opener.setNextYear()'>" +
		"</TD>" + "</TR>" + "</TABLE>" + "</CENTER>" + "</FORM>" + "</BODY>" + "</HTML>";
	return calDoc;
}

// CREATE THE BOTTOM CALENDAR FRAME 
// (THE MONTHLY CALENDAR)
function buildBottomCalFrame() {       
	// START CALENDAR DOCUMENT
	var calDoc = calendarBegin;
	// GET MONTH, AND YEAR FROM GLOBAL CALENDAR DATE
	month   = calDate.getMonth();
	year    = calDate.getFullYear();

	// GET GLOBALLY-TRACKED DAY VALUE (PREVENTS JAVASCRIPT DATE ANOMALIES)
	day     = calDay;
	var i   = 0;

	// DETERMINE THE NUMBER OF DAYS IN THE CURRENT MONTH
	var days = getDaysInMonth();

	// IF GLOBAL DAY VALUE IS > THAN DAYS IN MONTH, HIGHLIGHT LAST DAY IN MONTH
	if (day > days) {
		day = days;
	}

	// DETERMINE WHAT DAY OF THE WEEK THE CALENDAR STARTS ON
	var firstOfMonth = new Date (year, month, 1);

	// GET THE DAY OF THE WEEK THE FIRST DAY OF THE MONTH FALLS ON
	var startingPos  = firstOfMonth.getDay();
	days += startingPos;

	// KEEP TRACK OF THE COLUMNS, START A NEW ROW AFTER EVERY 7 COLUMNS
	var columnCount = 0;

	// MAKE BEGINNING NON-DATE CELLS BLANK
	for (i = 0; i < startingPos; i++) {
		calDoc += blankCell;
		columnCount++;
	}

	// SET VALUES FOR DAYS OF THE MONTH
	var currentDay = 0;
	var dayType    = "weekday";

	// DATE CELLS CONTAIN A NUMBER
	for (i = startingPos; i < days; i++) {
		var paddingChar = "&nbsp;";
		// ADJUST SPACING SO THAT ALL LINKS HAVE RELATIVELY EQUAL WIDTHS
		if (i-startingPos+1 < 10) {
			padding = "&nbsp;&nbsp;";
		}else {
			padding = "&nbsp;";
		}

		// GET THE DAY CURRENTLY BEING WRITTEN
		currentDay = i-startingPos+1;

		// SET THE TYPE OF DAY, THE focusDay GENERALLY APPEARS AS A DIFFERENT COLOR
		if (currentDay == day) {
			dayType = "link_calendario_oggi";
			tdClass = "link_calendario_oggi";
		}else {
			dayType = "link_calendario";
			tdClass = "link_calendario";
		}

		// ADD THE DAY TO THE CALENDAR STRING
		calDoc += "<TD class="+tdClass+" width=15% align=center>" +
		"<a class="+dayType+" href='javascript:parent.opener.returnDate(" + 
		currentDay + ")'>" +currentDay+ "</a></TD>";

		columnCount++;

		// START A NEW ROW WHEN NECESSARY
		if (columnCount % 7 == 0) {
			calDoc += "</TR><TR>";
		}
	}

	// MAKE REMAINING NON-DATE CELLS BLANK
	for (i=days; i<42; i++)  {
		calDoc += blankCell;
		columnCount++;

		// START A NEW ROW WHEN NECESSARY
		if (columnCount % 7 == 0) {
			calDoc += "</TR>";
			if (i<41) {
				calDoc += "<TR>";
			}
		}
	}
	// FINISH THE NEW CALENDAR PAGE
	calDoc += calendarEnd;
	// RETURN THE COMPLETED CALENDAR PAGE
	return calDoc;
}

// WRITE THE MONTHLY CALENDAR TO THE BOTTOM CALENDAR FRAME
function writeCalendar() {
	// CREATE THE NEW CALENDAR FOR THE SELECTED MONTH & YEAR
	calDocBottom = buildBottomCalFrame();
	// WRITE THE NEW CALENDAR TO THE BOTTOM FRAME
	top.newWin.frames['bottomCalFrame'].document.open();
	top.newWin.frames['bottomCalFrame'].document.write(calDocBottom);
	top.newWin.frames['bottomCalFrame'].document.close();
}

// SET THE CALENDAR TO TODAY'S DATE AND DISPLAY THE NEW CALENDAR
function setToday() {
	// SET GLOBAL DATE TO TODAY'S DATE
	calDate = new Date();
	// SET DAY MONTH AND YEAR TO TODAY'S DATE
	var month = calDate.getMonth();
	var year  = calDate.getFullYear();
	// SET MONTH IN DROP-DOWN LIST
	top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex = month;
	// SET YEAR VALUE
	top.newWin.frames['topCalFrame'].document.calControl.year.value = year;
	// DISPLAY THE NEW CALENDAR
	writeCalendar();
}


// SET THE GLOBAL DATE TO THE NEWLY ENTERED YEAR AND REDRAW THE CALENDAR
function setYear() {
	// GET THE NEW YEAR VALUE
	var year  = top.newWin.frames['topCalFrame'].document.calControl.year.value;
	// IF IT'S A FOUR-DIGIT YEAR THEN CHANGE THE CALENDAR
	if (isFourDigitYear(year)) {
		calDate.setFullYear(year);
		writeCalendar();
	}else {
		// HIGHLIGHT THE YEAR IF THE YEAR IS NOT FOUR DIGITS IN LENGTH
		top.newWin.frames['topCalFrame'].document.calControl.year.focus();
		top.newWin.frames['topCalFrame'].document.calControl.year.select();
	}
}

// SET THE GLOBAL DATE TO THE SELECTED MONTH AND REDRAW THE CALENDAR
function setCurrentMonth() {
	// GET THE NEWLY SELECTED MONTH AND CHANGE THE CALENDAR ACCORDINGLY
	var month = top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex;
	calDate.setMonth(month);
	writeCalendar();
}

// SET THE GLOBAL DATE TO THE PREVIOUS YEAR AND REDRAW THE CALENDAR
function setPreviousYear() {
	var year  = top.newWin.frames['topCalFrame'].document.calControl.year.value;
	if (isFourDigitYear(year) && year > 1000) {
		year--;
		calDate.setFullYear(year);
		top.newWin.frames['topCalFrame'].document.calControl.year.value = year;
		writeCalendar();
	}
}

// SET THE GLOBAL DATE TO THE PREVIOUS MONTH AND REDRAW THE CALENDAR
function setPreviousMonth() {
	var year  = top.newWin.frames['topCalFrame'].document.calControl.year.value;
	if (isFourDigitYear(year)) {
		var month = top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex;

		// IF MONTH IS JANUARY, SET MONTH TO DECEMBER AND DECREMENT THE YEAR
		if (month == 0) {
			month = 11;
			if (year > 1000) {
				year--;
				calDate.setFullYear(year);
				top.newWin.frames['topCalFrame'].document.calControl.year.value = year;
			}
		}else {
			month--;
		}
		calDate.setMonth(month);
		top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex = month;
		writeCalendar();
	}
}

// SET THE GLOBAL DATE TO THE NEXT MONTH AND REDRAW THE CALENDAR
function setNextMonth() {
	var year = top.newWin.frames['topCalFrame'].document.calControl.year.value;
	if (isFourDigitYear(year)) {
		var month = top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex;
		// IF MONTH IS DECEMBER, SET MONTH TO JANUARY AND INCREMENT THE YEAR
		if (month == 11) {
			month = 0;
			year++;
			calDate.setFullYear(year);
			top.newWin.frames['topCalFrame'].document.calControl.year.value = year;
		}else {
			month++;
		}
		calDate.setMonth(month);
		top.newWin.frames['topCalFrame'].document.calControl.month.selectedIndex = month;
		writeCalendar();
	}
}

// SET THE GLOBAL DATE TO THE NEXT YEAR AND REDRAW THE CALENDAR
function setNextYear() {
	var year  = top.newWin.frames['topCalFrame'].document.calControl.year.value;
	if (isFourDigitYear(year)){
		year++;
		calDate.setFullYear(year);
		top.newWin.frames['topCalFrame'].document.calControl.year.value = year;
		writeCalendar();
	}
}

// GET NUMBER OF DAYS IN MONTH
function getDaysInMonth()  {
	var days;
	var month = calDate.getMonth()+1;
	var year  = calDate.getFullYear();

	// RETURN 31 DAYS
	if (month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12)  {
		days=31;
	}else if (month==4 || month==6 || month==9 || month==11) {
		// RETURN 30 DAYS
		days=30;
	}else if (month==2){
		// RETURN 29 DAYS
		if (isLeapYear(year)){
			days=29;
		}else{
			// RETURN 28 DAYS
			days=28;
		}
	}
	return (days);
}

// CHECK TO SEE IF YEAR IS A LEAP YEAR
function isLeapYear (Year) {
	if (((Year % 4)==0) && ((Year % 100)!=0) || ((Year % 400)==0)) {
		return (true);
	}else {
		return (false);
	}
}

// ENSURE THAT THE YEAR IS FOUR DIGITS IN LENGTH
function isFourDigitYear(year) {
	if (year.length != 4) {
		top.newWin.frames['topCalFrame'].document.calControl.year.value = calDate.getFullYear();
		top.newWin.frames['topCalFrame'].document.calControl.year.select();
		top.newWin.frames['topCalFrame'].document.calControl.year.focus();
	}else {
		return true;
	}
}

// BUILD THE MONTH SELECT LIST
function getMonthSelect() {
	// IF FRENCH
	if (selectedLanguage == "fr") {
		monthArray = new Array('Janvier', 'F�vrier', 'Mars', 'Avril', 'Mai', 'Juin','Juillet', 'Aout', 'Septembre', 'Octobre', 'Novembre', 'D�cembre');
	}else if (selectedLanguage == "de") {
		// IF GERMAN
		monthArray = new Array('Januar', 'Februar', 'M�rz', 'April', 'Mai', 'Juni','Juli', 'August', 'September', 'Oktober', 'November', 'Dezember');
	}else if (selectedLanguage == "es") {
		// IF SPANISH
		monthArray = new Array('Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio','Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre');
	}else if (selectedLanguage == "it") {
		// IF ITALIAN
		monthArray = new Array('Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno','Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre');
	}else {
		// DEFAULT TO ENGLISH
		monthArray = new Array('January', 'February', 'March', 'April', 'May', 'June','July', 'August', 'September', 'October', 'November', 'December');
	}

	// DETERMINE MONTH TO SET AS DEFAULT
	var activeMonth = calDate.getMonth();

	// START HTML SELECT LIST ELEMENT
	monthSelect = "<SELECT NAME='month' onChange='parent.opener.setCurrentMonth()'>";

	// LOOP THROUGH MONTH ARRAY
	for (i in monthArray){
		// SHOW THE CORRECT MONTH IN THE SELECT LIST
		if (i == activeMonth) {
			monthSelect += "<OPTION SELECTED>" + monthArray[i] + "\n";
		}else {
			monthSelect += "<OPTION>" + monthArray[i] + "\n";
		}
	}
	monthSelect += "</SELECT>";

	// RETURN A STRING VALUE WHICH CONTAINS A SELECT LIST OF ALL 12 MONTHS
	return monthSelect;
}

// SET DAYS OF THE WEEK DEPENDING ON LANGUAGE
function createWeekdayList() {
	// IF FRENCH
	if (selectedLanguage == "fr") {
		weekdayList  = new Array('Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi');
		weekdayArray = new Array('Di', 'Lu', 'Ma', 'Me', 'Je', 'Ve', 'Sa');
	}else if (selectedLanguage == "de") {
		// IF GERMAN
		weekdayList  = new Array('Sonntag', 'Montag', 'Dienstag', 'Mittwoch', 'Donnerstag', 'Freitag', 'Samstag');
		weekdayArray = new Array('So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa');
	}else if (selectedLanguage == "es") {
		// IF SPANISH
		weekdayList  = new Array('Domingo', 'Lunes', 'Martes', 'Mi�rcoles', 'Jueves', 'Viernes', 'S�bado');
		weekdayArray = new Array('Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa');
	}else if (selectedLanguage == "it") {
		// IF ITALIAN
		weekdayList  = new Array('Domenica', 'Lunedi', 'Martedi', 'Mercoledi', 'Giovedi', 'Venerdi', 'Sabato');
		weekdayArray = new Array('Do', 'Lu', 'Ma', 'Me', 'Gi', 'Ve', 'Sa');
	}else {
		weekdayList  = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
		weekdayArray = new Array('Su','Mo','Tu','We','Th','Fr','Sa');
	}

	// START HTML TO HOLD WEEKDAY NAMES IN TABLE FORMAT
	var weekdays = "<TR BGCOLOR='" + headingCellColor + "'>";
	// LOOP THROUGH WEEKDAY ARRAY
	for (i in weekdayArray) {
		weekdays += "<TD class='heading' align=center>" + weekdayArray[i] + "</TD>";
	}
	weekdays += "</TR>";

	// RETURN TABLE ROW OF WEEKDAY ABBREVIATIONS TO DISPLAY ABOVE THE CALENDAR
	return weekdays;
}


// PRE-BUILD PORTIONS OF THE CALENDAR (FOR PERFORMANCE REASONS)
function buildCalParts() {
	// GENERATE WEEKDAY HEADERS FOR THE CALENDAR
	weekdays = createWeekdayList();

	// BUILD THE BLANK CELL ROWS
	blankCell = "<TD align=center bgcolor='" + cellColor + "'>&nbsp;&nbsp;&nbsp;</TD>";

	// BUILD THE TOP PORTION OF THE CALENDAR PAGE USING CSS TO CONTROL SOME DISPLAY ELEMENTS
	calendarBegin = "<HTML>" + "<HEAD>" + "<STYLE type='text/css'>" + "<!--" +
		"TD.heading { text-decoration: none; color:" + headingTextColor + "; font: " + headingFontStyle + "; }" +
		"A.focusDay:link { color: " + focusColor + "; text-decoration: none; font: " + fontStyle + "; }" +
		"A.focusDay:hover { color: " + focusColor + "; text-decoration: none; font: " + fontStyle + "; }" +
		"A.weekday:link { color: " + dateColor + "; text-decoration: none; font: " + fontStyle + "; }" +
		"A.weekday:hover { color: " + hoverColor + "; font: " + fontStyle + "; }" + "-->" +
		"</STYLE>" + "<link rel='stylesheet' href='stile_calendario.css' type='text/css'>" + "</HEAD>" +
		"<BODY BGCOLOR='" + bottomBackground + "' topmargin=5 marginwidth=0 marginheight=0>" + "<CENTER>";

	// NAVIGATOR NEEDS A TABLE CONTAINER TO DISPLAY THE TABLE OUTLINES PROPERLY
	if (isNav){
		calendarBegin += 
		"<TABLE WIDTH=200 CELLPADDING=4 CELLSPACING=1 BORDERCOLOR='" + tableBorderColor + "' BORDER=" + tableBorder + " ALIGN=CENTER BGCOLOR='" + tableBGColor + "'><TR><TD>";
	}

	// BUILD WEEKDAY HEADINGS
	calendarBegin += "<TABLE WIDTH=200 CELLPADDING=4 CELLSPACING=1 BORDER=" + tableBorder + " ALIGN=CENTER BGCOLOR='" + tableBGColor + "'>" + weekdays + "<TR>";

	// BUILD THE BOTTOM PORTION OF THE CALENDAR PAGE
	calendarEnd = "";

	// WHETHER OR NOT TO DISPLAY A THICK LINE BELOW THE CALENDAR
	if (bottomBorder) {
		calendarEnd += "<TR></TR>";
	}

	// NAVIGATOR NEEDS A TABLE CONTAINER TO DISPLAY THE BORDERS PROPERLY
	if (isNav) {
		calendarEnd += "</TD></TR></TABLE>";
	}

	// END THE TABLE AND HTML DOCUMENT
	calendarEnd +="</TABLE>" + "</CENTER>" + "</BODY>" + "</HTML>";
}

// REPLACE ALL INSTANCES OF find WITH replace
function jsReplace(inString, find, replace) {
	var outString = "";
	if (!inString) {
		return "";
	}
	// REPLACE ALL INSTANCES OF find WITH replace
	if (inString.indexOf(find) != -1) {
		// SEPARATE THE STRING INTO AN ARRAY OF STRINGS USING THE VALUE IN find
		t = inString.split(find);
		// JOIN ALL ELEMENTS OF THE ARRAY, SEPARATED BY THE VALUE IN replace
		return (t.join(replace));
	}else {
		return inString;
	}
}

// JAVASCRIPT FUNCTION -- DOES NOTHING (USED FOR THE HREF IN THE CALENDAR CALL)
function doNothing() {
}

// ENSURE THAT VALUE IS TWO DIGITS IN LENGTH
function makeTwoDigit(inValue) {
	var numVal = parseInt(inValue, 10);
	// VALUE IS LESS THAN TWO DIGITS IN LENGTH
	if (numVal < 10) {
		// ADD A LEADING ZERO TO THE VALUE AND RETURN IT
		return("0" + numVal);
	}else {
		return numVal;
	}
}

// SET FIELD VALUE TO THE DATE SELECTED AND CLOSE THE CALENDAR WINDOW
function returnDate(inDay){
	// inDay = THE DAY THE USER CLICKED ON
	calDate.setDate(inDay);

	// SET THE DATE RETURNED TO THE USER
	var day           = calDate.getDate();
	var month         = calDate.getMonth()+1;
	var year          = calDate.getFullYear();
	var monthString   = monthArray[calDate.getMonth()];
	var monthAbbrev   = monthString.substring(0,3);
	var weekday       = weekdayList[calDate.getDay()];
	var weekdayAbbrev = weekday.substring(0,3);
	outDate = calDateFormat;

	// RETURN TWO DIGIT DAY
	if (calDateFormat.indexOf("DD") != -1) {
		day = makeTwoDigit(day);
		outDate = jsReplace(outDate, "DD", day);
	}else if (calDateFormat.indexOf("dd") != -1) {
		// RETURN ONE OR TWO DIGIT DAY
		outDate = jsReplace(outDate, "dd", day);
	}

	// RETURN TWO DIGIT MONTH
	month = makeTwoDigit(month);
	outDate = jsReplace(outDate, "mm", month);

	// RETURN FOUR-DIGIT YEAR
	if (calDateFormat.indexOf("yyyy") != -1) {
		outDate = jsReplace(outDate, "yyyy", year);
	}else if (calDateFormat.indexOf("yy") != -1) {
		// RETURN TWO-DIGIT YEAR
		var yearString = "" + year;
		var yearString = yearString.substring(2,4);
		outDate = jsReplace(outDate, "yy", yearString);
	}else if (calDateFormat.indexOf("YY") != -1) {
		// RETURN FOUR-DIGIT YEAR
		outDate = jsReplace(outDate, "YY", year);
	}

	if (calDateFormat.indexOf("Month") != -1) {
		// RETURN DAY OF MONTH (Initial Caps)
		outDate = jsReplace(outDate, "Month", monthString);
	}else if (calDateFormat.indexOf("month") != -1) {
		// RETURN DAY OF MONTH (UPPERCASE LETTERS)
		outDate = jsReplace(outDate, "month", monthString.toLowerCase());
	}else if (calDateFormat.indexOf("MONTH") != -1) {
		// RETURN DAY OF MONTH (UPPERCASE LETTERS)
		outDate = jsReplace(outDate, "MONTH", monthString.toUpperCase());
	}

	if (calDateFormat.indexOf("Mon") != -1) {
		// RETURN DAY OF MONTH 3-DAY ABBREVIATION (Initial Caps)
		outDate = jsReplace(outDate, "Mon", monthAbbrev);
	}else if (calDateFormat.indexOf("mon") != -1) {
		// RETURN DAY OF MONTH 3-DAY ABBREVIATION (lowercase letters)
		outDate = jsReplace(outDate, "mon", monthAbbrev.toLowerCase());
	}else if (calDateFormat.indexOf("MON") != -1) {
		// RETURN DAY OF MONTH 3-DAY ABBREVIATION (UPPERCASE LETTERS)
		outDate = jsReplace(outDate, "MON", monthAbbrev.toUpperCase());
	}

	if (calDateFormat.indexOf("Weekday") != -1) {
		// RETURN WEEKDAY (Initial Caps)
		outDate = jsReplace(outDate, "Weekday", weekday);
	}else if (calDateFormat.indexOf("weekday") != -1) {
		// RETURN WEEKDAY (lowercase letters)
		outDate = jsReplace(outDate, "weekday", weekday.toLowerCase());
	}else if (calDateFormat.indexOf("WEEKDAY") != -1) {
		// RETURN WEEKDAY (UPPERCASE LETTERS)
		outDate = jsReplace(outDate, "WEEKDAY", weekday.toUpperCase());
	}

	if (calDateFormat.indexOf("Wkdy") != -1) {
		// RETURN WEEKDAY 3-DAY ABBREVIATION (Initial Caps)
		outDate = jsReplace(outDate, "Wkdy", weekdayAbbrev);
	}else if (calDateFormat.indexOf("wkdy") != -1) {
		// RETURN WEEKDAY 3-DAY ABBREVIATION (lowercase letters)
		outDate = jsReplace(outDate, "wkdy", weekdayAbbrev.toLowerCase());
	}else if (calDateFormat.indexOf("WKDY") != -1) {
		// RETURN WEEKDAY 3-DAY ABBREVIATION (UPPERCASE LETTERS)
		outDate = jsReplace(outDate, "WKDY", weekdayAbbrev.toUpperCase());
	}

	// SET THE VALUE OF THE FIELD THAT WAS PASSED TO THE CALENDAR
	calDateField.value = outDate;
	if((calDateField.name=="indexStartDate1") ||(calDateField.name=="indexStartDate2") ){
		calDateField.value="01/"+outDate.substr(3);
	}

	// CLOSE THE CALENDAR WINDOW
	top.newWin.close()
}