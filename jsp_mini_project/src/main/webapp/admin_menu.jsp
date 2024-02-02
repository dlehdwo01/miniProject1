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
	border: 1px solid #ccc;
	padding: 10px;
	border-radius: 10px;
}

table {
	margin-top: 10px;
}

th {
	background-color: rgba(0, 0, 0, 0.025);
}
</style>
</head>
<body>
	<%@ include file="db/dbconn.jsp"%>
	<div id="section-contents" style="height: 620px;">
		<h1>관리자메뉴</h1>
		<!-- 메뉴 스크린 -->
		<div id="cont">
			<!-- <div id="cont" style="clear: both; height: 500px; width: 160px; margin-top: 10px; background-color: rgba(0, 0, 0, 0.05);"></div> -->

			<a>유저관리</a>
			<a>상품관리</a>
			<a>미구현</a>
			<a>미구현</a>
			<a>미구현</a>
			<a>미구현</a>
		</div>

		<!-- 설정 스크린 -->
		<div id="cont" style="width: 1000px; margin-left: 30px;">
			<h3>유저목록</h3>
			<div>
				<input>
				<select>
					<option>아이디</option>
					<option>이름</option>
				</select>
				<input type="button" value="검색">
			</div>
			<table>
				<tr>
					<th>순번</th>
					<th>가입일자</th>
					<th>아이디</th>
					<th>이름</th>
					<th>연락처</th>
					<th>등급</th>
					<th>상태</th>
				</tr>

				<%
				String sql = "select * from djl_user_info";
				ResultSet srs = stmt.executeQuery(sql);

				while (srs.next()) {
				%>
				<tr>
				<%-- <td><%=srs.getString() %></td> --%>
				</tr>	
				<%
				}
				%>
			</table>





		</div>





	</div>
	<!-- section contents -->
	<%
	conn.close();
	%>
</body>
</html>