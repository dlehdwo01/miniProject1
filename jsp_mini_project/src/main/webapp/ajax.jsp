<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%@include file="db/dbconn.jsp"%>
<%
String user_id = request.getParameter("user_id");
String type = request.getParameter("type");
String sql = "";

/* 회원가입-id  */
if (type.equals("join-id")) {
	sql = "select * from djl_user_info where user_id='" + user_id + "'";
	ResultSet srs = stmt.executeQuery(sql);
	if (srs.next()) {
		out.println("taken");
	} else {
		out.println("available");
	}
	return;
}

/* 회원가입-go~  */
else if (type.equals("join")) {
	String user_pwd = request.getParameter("user_pwd");
	/* user_pwd : userPwd,
	 user_name : userName,
	 user_phone : userPhone,       */
	sql = "select * from djl_user_info where user_id='" + user_id + "'";
	ResultSet srs = stmt.executeQuery(sql);
	if (srs.next()) {
		out.println("taken");
	} else {
		out.println("available");
	}
	return;
}

/* 로그인 */
/* 아이디 확인 */
else if (type.equals("login-id")) {
	sql = "select * from djl_user_info where user_id='" + user_id + "'";
	ResultSet srs = stmt.executeQuery(sql);
	if (srs.next()) {
		out.println("success");
	} else {
		out.println("failed");
	}
	return;
}

/* 비밀번호 확인 */
/* 로그인 :: 세션부여 */
else if (type.equals("login-pwd")) {
	String user_pwd = request.getParameter("user_pwd");
	sql = "select * from djl_user_info where user_id='" + user_id + "'";
	ResultSet srs = stmt.executeQuery(sql);
	srs.next();
	if (user_pwd.equals(srs.getString("user_pwd"))) {
		out.println("success");
		HttpSession sessionStatus = request.getSession(true);
		session.setAttribute("user_id", user_id);
	} else {
		out.println("failed");
	}
	return;
}

/* 로그아웃 :: 세션삭제 */
else if (type.equals("logout")) {
	HttpSession sessionStatus = request.getSession(false);
	if (sessionStatus != null) {
		session.invalidate();
	}
	out.print("success");
}
%>
