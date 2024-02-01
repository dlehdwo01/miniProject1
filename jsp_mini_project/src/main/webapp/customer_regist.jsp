<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="db/dbconn.jsp"%>
	<div id="section-contents">
		<h1>고객등록</h1>
		<div></div>
	</div>
	<!-- section contents -->
	<%conn.close(); %>
</body>
</html>