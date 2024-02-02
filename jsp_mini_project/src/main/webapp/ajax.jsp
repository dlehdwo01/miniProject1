<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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
	conn.close();
	return;
}

/* 회원가입-success  */
else if (type.equals("join")) {
	String user_pwd = request.getParameter("user_pwd");
	String user_name = request.getParameter("user_name");
	String user_phone = request.getParameter("user_phone");

	sql = "insert into djl_user_info values ('" + user_id + "','" + user_name + "','" + user_pwd + "','" + user_phone
	+ "','U',0)";
	stmt.executeUpdate(sql);
	out.println("success");
	conn.close();
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
	conn.close();
	return;
}

/* 비밀번호 확인 */
/* 로그인 :: 세션부여 */
else if (type.equals("login-pwd")) {
	String user_pwd = request.getParameter("user_pwd");
	sql = "select * from djl_user_info where user_id='" + user_id + "'";
	ResultSet srs = stmt.executeQuery(sql);
	srs.next();
	if (srs.getInt("failed") > 4) {
		out.println("adminCall");
	} else if (user_pwd.equals(srs.getString("user_pwd"))) {
		out.println("success");
		/* 세션부여(id,level,접속시각) */
		HttpSession sessionStatus = request.getSession(true);
		session.setAttribute("user_id", user_id);
		session.setAttribute("user_level", srs.getString("user_level"));
		Date loginDate = new Date((long) System.currentTimeMillis());
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String loginTime = dateFormat.format(loginDate);
		session.setAttribute("user_loginTime", loginTime);
	} else {
		String failedSql = "update djl_user_info set failed=failed+1 where user_id='" + user_id + "'";
		stmt.executeUpdate(failedSql);
		out.println("failed");
	}
	conn.close();
	return;
}

/* 로그아웃 :: 세션삭제 */
else if (type.equals("logout")) {
	HttpSession sessionStatus = request.getSession(false);
	if (sessionStatus != null) {
		session.invalidate();
	}
	conn.close();
	out.print("success");
	return;
}

/* 새로운 고객 등록 */
else if (type.equals("registC")){
	String cus_name=request.getParameter("cus_name");
	String cus_birth=request.getParameter("cus_birth");
	String cus_gender=request.getParameter("cus_gender");
	String cus_phone=request.getParameter("cus_phone");
	String cus_addr1=request.getParameter("cus_addr2");
	String product_no=request.getParameter("product_no");
	conn.close();
	out.print(cus_birth);
	return;
}
%>
