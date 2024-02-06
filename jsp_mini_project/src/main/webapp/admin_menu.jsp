<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#cont {
	border: 1px solid #ccc;
	height: 530px;
	padding: 20px;
	background-color: white;
	border-radius: 10px;
	padding-top: 0px;
	width: 200px;
	float: left;
}

a {
	display: block;
	text-align: center;
	margin-top: 20px;
	font-weight: bold;
	border: 1px solid red;
	padding: 15px;
	border-radius: 10px;
	background-color: rgba(0, 0, 0, 0.0125);
	text-decoration: none;
	color: NAVY;
}

table {
	margin-top: 10px;
}

th {
	padding: 15px 10px;
	background-color: rgba(0, 0, 0, 0.025);
}

td {
	font-size: 14px;
}

.detailView th {
	background-color: white;
	border: none;
}

.detailView td {
	padding: 0px;
	border: none;
}

.detailView {
	border: none;
	margin: 0px auto;
}

.inputInput {
	margin: 5px;
	width: 150px;
	height: 30px;
	font-size: 13px;
	text-align: center;
	padding: 1px 5px;
}

.user {
	font-weight: bold;
	color: navy;
	cursor: pointer;
}

.user:hover {
	transform: scale(1.05);
}
</style>
</head>
<body>
	<%
	if (!"null".equals(session.getAttribute("user_level")) && request.isRequestedSessionIdValid()
			&& session.getAttribute("user_level") != null && "A".equals(session.getAttribute("user_level"))) {
	%>
	<div id="section-contents" style="height: 700px;">
		<h1>관리자메뉴</h1>
		<!-- 메뉴 스크린 -->
		<div id="cont">
			<a href="main.jsp?section=admin_menu&menu=admin_user_set" style="border: 1px solid #ccc">유저관리</a>
			<a href="main.jsp?section=admin_menu&menu=admin_customer_set" style="border: 1px solid #ccc">삭제고객관리</a>

		</div>

		<!-- include Files(start) -->
		<%
		/* 유저관리 */
		if ("admin_user_set".equals(request.getParameter("menu")) || request.getParameter("menu") == null) {
		%>
		<%@ include file="admin_user_set.jsp"%>
		<%
		}
		else if("admin_customer_set".equals(request.getParameter("menu"))){
			%>
		 <%@ include file="admin_customer_set.jsp"%>
		<%	
		}
		%>
		<!-- include Files(end) -->



	</div>
	<!-- section contents -->
	<%
	} else {
	%>
	<script>
        alert("관리자 권한만 접속 가능합니다.");
        location.href = "main.jsp?section=customer_list"
    </script>
	<%
	}
	%>
</body>
</html>