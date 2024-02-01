<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	/* int thisPage = 10;
	int maxPage = (int) Math.ceil((double) 331 / 20); //최대 페이지 수
	int startPage = (thisPage / 10 * 10) + 1;
	int endPage = Math.min(startPage + 9,maxPage); */
	int totalDataCount=230;
	int thisPage=13;
	
	
	// 전체 페이지 수 계산
    int totalPageCount = (int) Math.ceil((double) totalDataCount / 20);

    // 페이지 넘버링 출력
    int startPage = (thisPage - 1) / 10 * 10 + 1;
    int endPage = Math.min(startPage + 9, totalPageCount);

    for (int i = startPage; i <= endPage; i++) {
        if (i == thisPage) {
            out.println("<b>" + i + "</b> ");
        } else {
            out.println("<a href=\"main.jsp?pageNo=" + i + "\">" + i + "</a> ");
        }
    }
	%>


	<script>
console.log('<%=startPage%>');
console.log('<%=endPage%>');
    </script>
</body>
</html>