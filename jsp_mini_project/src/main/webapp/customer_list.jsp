<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.pageNumber {
	margin: 5px;
	font-size: 18px;
	height: 30px;
	cursor: pointer;
	font-weight: bold;
	background-color: none;
	border: none;
	color: maroon;
	box-sizing: border-box;
}

a {
	text-decoration: none;
	color: navy;
}

/* .pageNumber:hover {
	border: 1px solid #ccc;
	
} */
</style>
</head>
<body>
	<%@ include file="db/dbconn.jsp"%>
	<div id="section-contents">
		<h1>고객목록</h1>
		<div style="position: relative; height: 33px;">
			<div style="width: 500px; float: left;">
				<input class="search-input" name="keyword" id="keyword">
				<select name="keyword-type" id="keyword-type">
					<option value="cus_name">고객명</option>
					<option value="cus_phone">휴대폰번호</option>
					<option value="sales_name">판매자</option>
					<option value="cus_addr">주소</option>
					<option value="product_pkno">일련번호</option>
					<option value="product_no">개통모델</option>
				</select>
				<input type="button" value="검색" class="search-btn" onclick="fn_searchBtn()">
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
				<th>요금제</th>
				<th>개통상태</th>
				<th>
					<input type="button" value="선택판매내역삭제" class="search-btn" style="position: absolute; bottom: 50px; right: 10px; width: 120px;" onclick="fn_deleteSell()">
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

			/* 검색x 고객 조회 */
			String sql = " from (select rownum as rn, t.* from (SELECT sell_no,deleteyn,selldeleteyn,mobileplan,c.cus_no as cus_no,cus_name, TO_CHAR(cus_birth,'yy/mm/dd') as cus_birth,cus_phone,cus_addr1,cus_addr2 ,product_no,product_pkno ,TO_CHAR(sell_date,'YY/MM/DD') as sell_date,SALES_NAME,STATUS,telecom FROM djl_cus_info c LEFT JOIN djl_sell s ON c.cus_no = s.cus_no where deleteyn='N' and selldeleteyn='N' order by sell_date) t ) ";

			/* 20명 조회 */
			String rn = " where rn>" + (showList - 20) + " and rn<=" + showList;

			/* 검색 고객 조회 */
			if (request.getParameter("keyword") != null && !"".equals(request.getParameter("keyword"))) {
				sql = " from (select rownum as rn, t.* from (SELECT sell_no,deleteyn,selldeleteyn,mobileplan,c.cus_no as cus_no,cus_name, TO_CHAR(cus_birth,'yy/mm/dd') as cus_birth,cus_phone,cus_addr1,cus_addr2 ,product_no,product_pkno ,TO_CHAR(sell_date,'YY/MM/DD') as sell_date,SALES_NAME,STATUS,telecom FROM djl_cus_info c LEFT JOIN djl_sell s ON c.cus_no = s.cus_no where deleteyn='N' and selldeleteyn='N' and "
				+ request.getParameter("keyword-type") + " like '%" + request.getParameter("keyword")
				+ "%' order by sell_date) t )";
			}

			ResultSet srs = stmt.executeQuery("select * " + sql + rn);

			while (srs.next()) {
			%>
			<tr>
				<td style="width: 50px; max-width: 50px"><%=srs.getString("rn")%></td>
				<td style="width: 100px; max-width: 100px">
					<a href="main.jsp?section=customer_view&cus_no=<%=srs.getString("cus_no")%>"><%=srs.getString("cus_name")%></a>
				</td>
				<td><%=srs.getString("cus_birth")%></td>
				<td><%=srs.getString("cus_phone")%></td>
				<td style="text-align: left;">
					<%
					if (srs.getString("cus_addr1") == null) {
						out.print("");
					} else {
						out.print(srs.getString("cus_addr1") + " ");
					} ;
					if (srs.getString("cus_addr2") == null) {
						out.print("");
					} else {
						out.print(srs.getString("cus_addr2"));
					} ;
					%>
				</td>
				<td style="width: 100px; max-width: 100px">
					<%
					if (srs.getString("product_no") == null) {
						out.print("");
					} else {
						out.print(srs.getString("product_no"));
					} ;
					%>
				</td>
				<td style="width: 100px; max-width: 100px">
					<%
					if (srs.getString("product_pkno") == null) {
						out.print("");
					} else {
						out.print(srs.getString("product_pkno"));
					} ;
					%>
				</td>
				<td style="width: 70px; max-width: 70px">
					<%
					if (srs.getString("sell_date") == null) {
						out.print("");
					} else {
						out.print(srs.getString("sell_date"));
					} ;
					%>
				</td>
				<td style="width: 100px; max-width: 100px">
					<%
					if (srs.getString("sales_name") == null) {
						out.print("");
					} else {
						out.print(srs.getString("sales_name"));
					} ;
					%>
				</td>
				<td style="width: 70px; max-width: 70px">
					<%
					if (srs.getString("telecom") == null) {
						out.print("");
					} else {
						out.print(srs.getString("telecom"));
					} ;
					%>
				</td>
				<td style="width: 120px; max-width: 120px">
					<%
					if (srs.getString("MOBILEPLAN") == null) {
						out.print("");
					} else {
						out.print(srs.getString("MOBILEPLAN"));
					} ;
					%>
				</td>
				<td style="width: 100px; max-width: 100px">
					<%
					if (srs.getString("status") == null) {
						out.print("");
					} else {
						out.print(srs.getString("status"));
					} ;
					%>
				</td>
				<td>
					<input type="checkbox" value="<%=srs.getString("sell_no")%>" name="sell_no">
				</td>
			</tr>
			<%
			}
			%>
		</table>


		<div style="text-align: center; height: 20px; display: flex; justify-content: center;">

			<%
			/* 검색 결과를 기준으로 cnt 확인 */
			String cntSql = "SELECT COUNT(*) as cnt " + sql;
			ResultSet cntResult = stmt.executeQuery(cntSql);

			int maxCnt = 0;
			if (cntResult.next()) {
				maxCnt = cntResult.getInt("cnt");
			}

			// 전체 페이지 수 계산
			int totalPageCnt = (int) Math.ceil((double) maxCnt / 20);

			// 페이지 넘버링 출력
			int startPage = (thisPage - 1) / 10 * 10 + 1;
			int endPage = Math.min(startPage + 9, totalPageCnt);

			for (int i = startPage; i <= endPage; i++) {
				if (i == thisPage) {
			%>
			<input type="button" value="<%=i%>" class="pageNumber" name="page" style="cursor: text; color: olive;">
			<%
			} else {
			%>
			<input type="button" value="<%=i%>" class="pageNumber" name="page" onclick="movePage('<%=i%>')">
			<%
			}
			}
			conn.close();
			%>


		</div>
	</div>
	<!-- section contents -->
</body>
</html>
<script>
    /* 삭제 */
    function fn_deleteSell() {
        var checkBoxes = document.querySelectorAll('input[name="sell_no"]:checked')
        checkBoxes.forEach(function(value){
        
        console.log(value);
        })
    }

    $(function () {
        // Enter 키 이벤트 처리
        $('#keyword').on('keypress', function (event) {
            if (event.which === 13) {
                fn_searchBtn();
            }
        });
        $('#keyword-type').on('keypress', function (event) {
            if (event.which === 13) {
                fn_searchBtn();
            }
        });
    });

    /* 검색 */
    function fn_searchBtn() {
        var keyword = document.querySelector("#keyword").value;
        if (keyword == "") {
            alert("최소 한 글자 이상 입력해주세요.")
        } else {
            var keywordType = document.querySelector("#keyword-type").value;
            location.href = "main.jsp?section=customer_list&keyword=" + keyword
                    + "&keyword-type=" + keywordType;
        }
    }

    function movePage(page) {
        location.href = "main.jsp?section=customer_list&pageNo=" + page;
    }
</script>