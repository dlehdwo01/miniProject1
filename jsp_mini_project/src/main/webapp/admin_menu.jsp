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
	border: 1px solid #ccc;
	padding: 15px;
	border-radius: 10px;
	background-color: rgba(0, 0, 0, 0.0125);
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
	<%@ include file="db/dbconn.jsp"%>
	<div id="section-contents" style="height: 700px;">
		<h1>관리자메뉴</h1>
		<!-- 메뉴 스크린 -->
		<div id="cont">
			<a>유저관리</a> <a>미구현</a> <a>미구현</a> <a>미구현</a> <a>미구현</a> <a>미구현</a> <a>미구현</a>
		</div>

		<!-- 설정 스크린 -->
		<div id="cont" style="width: 830px; margin-left: 30px; margin-right: 30px;">
			<h3>
				유저목록::
				<span style="font-size: 14px; color: navy;">유저아이디 클릭시 상세보기</span>
			</h3>
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
					<th></th>
					<th>가입일자</th>
					<th>아이디</th>
					<th>이름</th>
					<th>연락처</th>
					<th>등급</th>
					<th>상태</th>
				</tr>

				<%
				SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy-MM-dd");
				String sql = "select * from (select rownum as rn,i.* from djl_user_info i)";
				ResultSet srs = stmt.executeQuery(sql);

				while (srs.next()) {
				%>
				<tr>
					<td style="width: 40px; max-width: 40px;"><%=srs.getString("rn")%></td>
					<td style="width: 100px; max-width: 100px;"><%=DateFormat.format(srs.getDate("user_cdate"))%></td>
					<td style="width: 80px; max-width: 80px;">
						<div class='user' onclick="fn_userView('<%=srs.getString("user_id")%>')"><%=srs.getString("user_id")%></div>
					</td>
					<td style="width: 80px; max-width: 80px;"><%=srs.getString("user_name")%></td>
					<td style="width: 100px; max-width: 100px;"><%=srs.getString("user_phone")%></td>
					<td style="width: 40px; max-width: 40px;"><%=srs.getString("user_level")%></td>
					<td style="width: 60px; max-width: 60px;">
						<%
						if (srs.getInt("failed") > 4) {
							out.print("잠금");
						} else {
							out.print("활성화");
						} ;
						%>
					</td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
		<div id="cont" style="width: 300px;">
			<h3>상세보기</h3>
			<div style="border-bottom: 1px solid #ccc; padding-bottom: 20px;">
				<table class="detailView">
					<tr>
						<th>가입일자</th>
						<td>
							<input class="inputInput" id="user_cdate">
						</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>
							<input class="inputInput" id="user_id_fake" disabled>
							<input id="user_id" hidden='hidden'>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input class="inputInput" id="user_name">
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input class="inputInput" id="user_phone">
						</td>
					</tr>
					<tr>
						<th>등급</th>
						<td>
							<input class="inputInput" id="user_level">
						</td>
					</tr>
				</table>
			</div>
			<input type="button" value="회원수정">
			<input type="button" value="회원삭제">
		</div>

	</div>
	<!-- section contents -->
	<%
	conn.close();
	%>
</body>
</html>
<script>
    function fn_userView(user_id) {
        console.log(user_id);
        $(function () {
            //ajax 실행            
            $.ajax({
                type : 'POST',
                url : 'ajax.jsp',
                data : {
                    user_id : user_id,                   
                    type : 'admin_userView'
                },
                success : function (user_cdate,user_id,user_name,user_phone,user_level) {
                    alert(user_cdate+user_id+user_name+user_phone+user_level);
                },
                error : function (error) {
                    console.error('에러 발생:', error);
                }
            });
        });

    }
</script>