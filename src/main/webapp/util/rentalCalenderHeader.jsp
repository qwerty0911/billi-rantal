<%@page import="java.util.HashSet"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.billi.model.RentalService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
RentalService rentalService = new RentalService();

/* getAttribute로 boardid받아와야함 */
HashSet<Date> disabledDate = rentalService.extractDisabledDates(20001);

%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<meta charset="UTF-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>

jQuery(function($){
    
    /*
    //config 값을 json형식으로 만든후 setDefaults로 설정할수도 있음.
     
    $.datepicker.regional['ko'] = {closeText: '닫기',dayNamesShort: ['일','월','화','수','목','금','토']};
    $.datepicker.setDefaults($.datepicker.regional['ko']);
    */
     
    $(".calander").datepicker({
        changeMonth:true,
        changeYear:true,
        yearRange:"2023:2014",
        showOn:"both",
		buttonImage:"cal.jpg",
        buttonImageOnly:true,
        dateFormat: 'yy-mm-dd',
        showOtherMonths: true,
        selectOtherMonths: true,
        showMonthAfterYear: true,
        dayNamesMin: ['일','월', '화', '수', '목', '금', '토'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
        monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
        nextText: '다음 달',
        prevText: '이전 달',
        beforeShowDay: disableAllTheseDays
    });
     
});
 
// 특정날짜들 배열
//var disabledDays = ["2023-04-17"];
var disabledDays = [];
<%
for(Date date:disabledDate){
%>
rawDate = new Date("<%=date%>");
//console.log(rawDate);
year = rawDate.getFullYear();
month = rawDate.getMonth() + 1;
day = rawDate.getDate();

formattedDate = ""+year+"-"+month+"-"+day;
disabledDays.push(formattedDate);
//console.log(formattedDate)
<%}%>
 
// 주말(토, 일요일) 선택 막기
function noWeekendsOrHolidays(date) {
    var noWeekend = jQuery.datepicker.noWeekends(date);
    return noWeekend[0] ? [true] : noWeekend;
}
 
// 일요일만 선택 막기
function noSundays(date) {
  return [date.getDay() != 0, ''];
}
 
// 이전 날짜들은 선택막기
function noBefore(date){
    if (date < new Date())
        return [false];
    return [true];
}
 
// 특정일 선택막기
function disableAllTheseDays(date) {
    var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
    for (i = 0; i < disabledDays.length; i++) {
        if($.inArray(y + '-' +(m+1) + '-' + d,disabledDays) != -1) {
            return [false];
        }
    }
    return [true];
}

</script>