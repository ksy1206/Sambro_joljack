<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
	String member_no="";
	boolean isSession = true;
	
	if (session.getAttribute("member_no") != null) {
	   
		member_no = session.getAttribute("member_no").toString();
	  
	} else {
	    isSession = false;
	    session.removeAttribute("sessionData");
	}
%>
<!DOCTYPE html>
<html>
<head>

<title>출석체크</title>
<meta charset="utf-8" />
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<link href="<%=cp%>/css/bootstrap.min.css" rel="stylesheet">
<script src="<%=cp%>/js/bootstrap.js"></script>

<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/cmdQR/login.do";
	</script>
</c:if>

<script type="text/javascript">
	
	$(document).ready(function(){
		
	});//end document
	
	function move_memu(data){
		if(data == '01'){
			location.href="<%=cp%>/cmdQR/pro_main.do";
		} else if (data == '02'){
			location.href="<%=cp%>/noticeQR/pro_main.do";
		} else if (data == '03'){
			$("#popupCheck").popup("open");	
		} else if (data == '04'){
			location.href="<%=cp%>/cmdQR/pro_bus.do";
		}
	}
	
	function popupConfirm(){
		location.href="<%=cp%>/cmdQR/logOut.do";
	}
	
	function popupClose(){
		$("#popupCheck").popup("close");
	}
	
	function add_notice(){
		
		var notice_writer = <%=member_no%>
		var class_code = $("#class_code").val()
		var notice_title = $("#notice_title").val()
		var notice_content = $("#notice_content").val()
		var notice_deadline = $("#notice_deadline").val()
		
		if(class_code == '' || class_code == null){
			alert("과목을 선택해 주세요.");
			return false;
		}
		if(notice_title == '' || notice_title == null){
			alert("제목을 입력해 주세요.");
			return false;
		}
		if(notice_content == '' || notice_content == null){
			alert("내용을 입력해 주세요.");
			return false;
		}
		if(notice_deadline == '' || notice_deadline == null){
			alert("마감 날자를 입력해 주세요.");
			return false;
		}

		var params = "notice_writer="+notice_writer+"&class_code="+class_code+"&notice_title="+notice_title+"&notice_content="+notice_content+"&notice_deadline="+notice_deadline;
		
	    $.ajax({
	        type        : "POST" 
	      , async       : false
	      , url         : "/noticeQR/insert_notice.do"
	      , data        : params
	      , dataType    : "json"
	      , timeout     : 30000  
	      , cache       : false    
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	               alert( "작업 도중 오류가 발생하였습니다. " );
	                
	      }
	      , success     : function(data) {
	    	  location.href="<%=cp%>/noticeQR/pro_main.do";
	      }
		});
	}

</script>
</head>

<body>
<div data-role="page" style="background-color: #fff;">
	<div data-role="header" style="background-color: #0054FF; color: #ffffff;">
		<p style="font-size:24px; margin-top: 1em; margin-bottom: 1em; margin-left: 1em;">
			공지사항
		</p>
	</div>
	
	<div data-role="content">
		<div style="width: 100%;" align="center">
			<img src="../img/timetable_default.jpg" style="width:15%;" onclick="move_memu('01')">&nbsp;
			<img src="../img/notice.jpg" style="width:15%;" onclick="move_memu('02')">&nbsp;&nbsp;&nbsp;
			<img src="../img/default_sc.jpg" style="width:15%;">&nbsp;&nbsp;&nbsp;
			<img src="../img/default_bus.jpg" style="width:15%;" onclick="move_memu('04')">&nbsp;&nbsp;&nbsp;
			<img src="../img/logOut_default.jpg" style="width:15%;" onclick="move_memu('03')">
		</div>

		<div>
		  <fieldset class="ui-field-contain">
		    <select name="class_code" id="class_code">
		       <option value="">과목을 선택해 주세요.</option>
		       <option value="01">네트워크</option>
		       <option value="02">기업탐구</option>
		       <option value="03">Web</option>
		       <option value="04">응용</option>
		       <option value="05">프로젝트</option>
		       <option value="06">App</option>
		    </select>
		   </fieldset>
		   
		   <input type="text" name="notice_title" id="notice_title" placeholder="제목">
		   
		   <textarea name="notice_content" id="notice_content" placeholder="내용" style="height:200px !important; resize: none !important; wrap: hard;"></textarea>
		   
		   <label for="bday">마감날짜</label>
		   <input type="date" name="notice_deadline" id="notice_deadline">
		   
		   <div align="center">
		     <input type="button" class="btn btn-primary" value="등록" onclick="add_notice()" >
		   </div>
		</div>
  </div>

	   	<!-- 팝업 -->
	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
	    	<img src="../img/logOut_popup.jpg">
			<p id="">로그아웃 하시겠습니까?</p>
			<div id="" class="ui-grid-a" align="center">
				<div class="ui-block-a">
					<input class="btn btn-default" type="button" value="취소" onclick="popupClose()">
				</div>
				<div class="ui-block-b">
					<input class="btn btn-info" type="button" value="확인" onclick="popupConfirm()">
				</div>
			</div>
	  	</div>    
	 </div>
</div>

	
</body>
</html>