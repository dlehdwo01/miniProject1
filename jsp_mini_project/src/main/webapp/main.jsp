<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>대리점::고객관리시스템</title>
<style>
th {
	background-color: rgba(120, 120, 180, 0.2);
}

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


	<div id="container">
		<div id="bg">
			<div>
				<div style="height: 100px;">
					<input type="button" value="로그아웃" class="logout-btn" onclick="fn_logout()">
					<span id="header-status">
						아이디:
						<%=session.getAttribute("user_id")%>
						<span style="font-weight: bold; font-size: 15px; color: #ccc;">|</span>
						등급 :
						<%
						if ("A".equals(session.getAttribute("user_level"))) {
							out.print("관리자");
						} else if ("U".equals(session.getAttribute("user_level"))) {
							out.print("일반");
						}
						%>
						<span style="font-weight: bold; font-size: 15px; color: #ccc;">|</span>
						접속일시 :
						<%=session.getAttribute("user_loginTime")%>
					</span>
				</div>
			</div>
			<div id="header-menu">
				<span class="menu" onclick='fn_loadPage("customer_list")'>고객목록</span>
				<span class="menu" onclick='fn_loadPage("customer_regist")'>고객등록</span>
				<span class="menu" onclick="fn_loadPage('inventory_management')">재고관리</span>
				<span class="menu" onclick="fn_loadPage('admin_menu')">관리자메뉴</span>
			</div>
			<div id="section">
				<%
				if ("main".equals(request.getParameter("section"))) {
				%>
				<%@include file="customer_list.jsp"%>
				<%
				
				} else if ("customer_regist".equals(request.getParameter("section"))) {
				%>
				<%@include file="customer_regist.jsp"%>
				<%
				
				} else if ("customer_list".equals(request.getParameter("section"))) {
				%>
				<%@include file="customer_list.jsp"%>
				<%
				
				} else if ("inventory_management".equals(request.getParameter("section"))) {
				%>
				<%@include file="inventory_management.jsp"%>
				<%
				
				} else if ("admin_menu".equals(request.getParameter("section"))) {
				%>
				<%@include file="admin_menu.jsp"%>
				<%
				
				} else if ("customer_view".equals(request.getParameter("section"))) {
				%>
				<%@include file="customer_view.jsp"%>
				<%
				
				}
				%>



			</div>
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

    var user_id ="<%=session.getAttribute("user_id")%>";

    function fn_loadPage(page) {
        location.href = "main.jsp?section=" + page;
    }
    function fn_logout() {
        if (user_id == null) {
            location.href = "login-id.jsp";
        }
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