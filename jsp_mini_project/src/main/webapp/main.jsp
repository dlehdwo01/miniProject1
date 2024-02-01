<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>대리점::고객관리시스템</title>
<style>
td {
	max-width: 200px;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden
}
</style>
</head>
<body style="background-color: rgb(230, 230, 230, 0.7);">
	<%
	if (!"null".equals(session.getAttribute("user_id")) && request.isRequestedSessionIdValid()
			&& session.getAttribute("user_id") != null) {
		/* !"null".equals(session.getAttribute("user_id")) && request.isRequestedSessionIdValid()
		&& session.getAttribute("user_id") != null */
	%>

	<%@ include file="db/dbconn.jsp"%>

	<div id="container">
		<div id="bg">
			<div>
				<div style="height: 100px;">
					<input type="button" value="로그아웃" class="logout-btn" onclick="fn_logout()">
					<span id="header-status">
						아이디: asdasdasdasdasd
						<span style="font-weight: bold; font-size: 15px; color: #ccc;">|</span>
						등급 : asdasdasdasd
						<span style="font-weight: bold; font-size: 15px; color: #ccc;">|</span>
						접속일시 : 20213132131321
					</span>
				</div>
			</div>
			<div id="header-menu">
				<span class="menu">고객목록</span>
				<span class="menu">재고관리</span>
				<span class="menu">관리자메뉴</span>
			</div>
			<div id="section"></div>
			<!-- section -->
		</div>
		<!-- bg -->
	</div>
	<!-- container -->
	<%
	} else {
	%>
	<script>
        alert("세션이 만료되었습니다.");
        location.href = "login-id.jsp";
    </script>
	<%
	}
	%>
</body>
</html>
<script>
    var user_id ='<%=session.getAttribute("user_id")%>';
    

    function fn_logout() {
        if (confirm("정말 로그아웃 하시겠습니까?")) {

            //ajax 실행
            $.ajax({
                type : 'POST',
                url : 'ajax.jsp',
                data : {
                    type : 'logout'
                },
                success : function (response) {
                    if (response.trim() === 'success') {
                        location.href = "login-id.jsp";
                        return;
                    }
                },
                error : function (error) {
                    console.error('에러 발생:', error);
                }
            });
        }
    }
</script>