<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="db/dbconn.jsp"%>
	<div id="section-contents">
		<h1>고객목록</h1>
		<div style="position: relative; height: 33px;">
			<div style="width: 500px; float: left;">
				<input class="search-input">
				<select>
					<option>고객명</option>
					<option>휴대폰번호</option>
					<option>판매자</option>
					<option>주소</option>
					<option>일련번호</option>
					<option>개통모델</option>
				</select>
				<input type="button" value="검색" class="search-btn">
			</div>
			<div style="width: 500px; position: absolute; right: 70px;">
				<input class="search-input">
				<select>
					<option>고객명</option>
					<option>휴대폰번호</option>
					<option>판매자</option>
					<option>주소</option>
					<option>일련번호</option>
					<option>개통모델</option>
				</select>
				<input type="button" value="선택수정" class="search-btn" style="width: 80px">
			</div>
		</div>

		<table>
			<tr style="position: relative;">
				<th>번호</th>
				<th>고객명</th>
				<th>생년월일</th>
				<th>휴대폰번호</th>
				<th style="width: 200px;">주소</th>
				<th>개통모델</th>
				<th>일련번호</th>
				<th>개통일자</th>
				<th>판매자</th>
				<th>통신사</th>
				<th>개통상태</th>
				<th>
					<input type="button" value="삭제" class="search-btn" style="position: absolute; bottom: 50px; right: 10px">
					선택
				</th>
			</tr>
			<%
			int thisPage = 0; //현재페이지
			int showList = 0; //목록에 보여줄 고객번호(rownum)

			/* getParameter("page")가 null 이거나 1일때 rownum 1~20만 보이게 */
			if (request.getParameter("pageNo") == null || "1".equals(request.getParameter("pageNo"))) {
				thisPage = 1;
			} else {
				thisPage = Integer.parseInt(request.getParameter("pageNo"));
			}
			showList = thisPage * 20;

			/* String sql = "select rownum, t.* from (SELECT cus_name, TO_CHAR(cus_birth,'yy/mm/dd') as cus_birth,cus_phone,cus_addr ,product_no,product_pkno ,TO_CHAR(sell_date,'YY/MM/DD') as sell_date,SALES_NAME,STATUS,telecom FROM djl_cus_info c LEFT JOIN djl_sell s ON c.cus_no = s.cus_no) t"; */
			String sql = "select * from (select rownum as rn, t.* from (SELECT cus_name, TO_CHAR(cus_birth,'yy/mm/dd') as cus_birth,cus_phone,cus_addr ,product_no,product_pkno ,TO_CHAR(sell_date,'YY/MM/DD') as sell_date,SALES_NAME,STATUS,telecom FROM djl_cus_info c LEFT JOIN djl_sell s ON c.cus_no = s.cus_no) t ) where rn>"
					+ (showList - 20) + " and rn<=" + showList;

			ResultSet srs = stmt.executeQuery(sql);

			while (srs.next()) {
			%>
			<tr>
				<td style="width: 50px; max-width: 50px"><%=srs.getString("rn")%></td>
				<td style="width: 150px; max-width: 150px"><%=srs.getString("cus_name")%></td>
				<td><%=srs.getString("cus_birth")%></td>
				<td><%=srs.getString("cus_phone")%></td>
				<td style="text-align: left;">
					<%
					if (srs.getString("cus_addr") == null) {
						out.print("");
					} else {
						out.print(srs.getString("cus_addr"));
					}
					;
					%>
				</td>
				<td style="width: 100px; max-width: 100px">
					<%
					if (srs.getString("product_no") == null) {
						out.print("");
					} else {
						out.print(srs.getString("product_no"));
					}
					;
					%>
				</td>
				<td style="width: 100px; max-width: 100px">
					<%
					if (srs.getString("product_pkno") == null) {
						out.print("");
					} else {
						out.print(srs.getString("product_pkno"));
					}
					;
					%>
				</td>
				<td style="width: 100px; max-width: 100px">
					<%
					if (srs.getString("sell_date") == null) {
						out.print("");
					} else {
						out.print(srs.getString("sell_date"));
					}
					;
					%>
				</td>
				<td style="width: 100px; max-width: 100px">
					<%
					if (srs.getString("sales_name") == null) {
						out.print("");
					} else {
						out.print(srs.getString("sales_name"));
					}
					;
					%>
				</td>
				<td style="width: 70px; max-width: 70px">
					<%
					if (srs.getString("telecom") == null) {
						out.print("");
					} else {
						out.print(srs.getString("telecom"));
					}
					;
					%>
				</td>
				<td style="width: 100px; max-width: 100px">
					<%
					if (srs.getString("status") == null) {
						out.print("");
					} else {
						out.print(srs.getString("status"));
					}
					;
					%>
				</td>
				<td>
					<input type="checkbox">
				</td>
			</tr>
			<%
			}
			%>
		</table>
		<div style="text-align: center; height: 20px; display: flex; justify-content: center;">
			<%

			%>

			<a style="margin: 5px;" href="main.jsp?pageNo=1">1</a>
			<a style="margin: 5px;" href="main.jsp?pageNo=2">2</a>
		</div>
	</div>
	<!-- section contents -->
</body>
</html>