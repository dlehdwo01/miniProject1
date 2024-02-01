<%@ page import="java.sql.*"%>

<%
Connection conn;
Statement stmt = null;

Class.forName("oracle.jdbc.driver.OracleDriver");
/*  String db_url = "jdbc:oracle:thin:@localhost:1521:orcl";
String db_id = "system";
String db_pw = "test1234"; */
 String db_url = "jdbc:oracle:thin:@tempdb.ccxwnfpmkcwn.ap-northeast-2.rds.amazonaws.com:1521:orcl";
String db_id = "admin";
String db_pw = "test12#$";
conn = DriverManager.getConnection(db_url, db_id, db_pw);
stmt = conn.createStatement();
%>
