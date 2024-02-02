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
	+ "','U',0,sysdate)";
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

/* 고객 등록 */
else if (type.equals("registC")){
	try{
	/* 정보 등록 */	
	String cus_phone=request.getParameter("cus_phone");
	cus_phone=cus_phone.substring(0, 3) + "-" + cus_phone.substring(3, 7) + "-" + cus_phone.substring(7);	
		
	 sql="INSERT INTO djl_cus_info "+ 
		    " (CUS_NO, CUS_NAME, CUS_BIRTH, CUS_ADDR1, CUS_ADDR2,CUS_PHONE, CUS_GENDER, CUS_CDATE,DELETEYN) "+
		    " VALUES ( "+
		        " DJL_CUS_NO_SEQ.NEXTVAL, "+
		        " '"+request.getParameter("cus_name")+"',"+
		        "TO_DATE('"+request.getParameter("cus_birth")+"', 'YYYYMMDD'),"+
		        "'"+request.getParameter("cus_addr1")+"',"+ 
		        "'"+request.getParameter("cus_addr2")+"',"+
		        "'"+cus_phone+"',"+
		        "'"+request.getParameter("cus_gender")+"',"+
		        "sysdate,"+
		        "'N'"+
		    ")";
	 stmt.executeUpdate(sql);
	 
	 /* 고객NO SELECT -> SELL 레코드 추가 */
	sql="select * from djl_cus_info where cus_name='"+request.getParameter("cus_name")+"' and cus_birth='"+request.getParameter("cus_birth")+"'";
	ResultSet srs=stmt.executeQuery(sql);
	String cus_no="";
	 if(srs.next()){
		 cus_no=srs.getString("cus_no");
	 }	 
	
	 String sellSql="INSERT INTO DJL_SELL "+			
			"VALUES ("+
			cus_no+","+
			"'"+request.getParameter("sales_name")+"',"+
			"'"+request.getParameter("product_no")+"',"+
			"'"+request.getParameter("product_pkno")+"',"+
			"'"+request.getParameter("product_color")+"',"+
			"'"+request.getParameter("product_price")+"',"+
			"TO_DATE('"+request.getParameter("sell_date")+"','YYYYMMDD'),"+
			"'"+request.getParameter("status")+"',"+
			"'"+request.getParameter("telecom")+"',"+
			"'"+request.getParameter("mobileplan")+"',"+
			"'"+request.getParameter("telfund")+"',"+
			"'"+request.getParameter("fund")+"',"+
			"'"+request.getParameter("contract")+"',djl_sell_no_seq.nextval)";
	 stmt.executeUpdate(sellSql);	
	conn.close(); 
	out.print("success");
	} catch(Exception e){
		out.print("error");
	}	
	return;
}
%>
