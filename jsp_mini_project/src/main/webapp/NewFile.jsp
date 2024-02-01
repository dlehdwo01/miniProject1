<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
double a=1.2424;
a=(int)Math.ceil(a);


%>
<script>
console.log('<%=a%>');
</script>
</body>
</html>