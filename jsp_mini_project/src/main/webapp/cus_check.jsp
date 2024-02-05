<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>고객확인</title>
<style>
#container1 {
	margin: 0px;
	background-color: white;
	width: 750px;
	padding: 10px;
	heigth: 500px;
}

table, td, th {
	font-size: 13px;
}

table {
	margin: 0px;
	auto;
}

th {
	background-color: rgba(0, 0, 0, 0.05);
}

td, th {
	width: 40px;
	max-width: 40px;
}

.ment {
	color: navy;
	margin-bottom: 5px;
	font-weight: bold;
}
</style>
</head>
<body style="background-color: rgb(230, 230, 230, 0.7);">
	<%@include file="db/dbconn.jsp"%>
	<div id="container1">
		<%
		String sql = "select * from djl_cus_info where cus_name='" + request.getParameter("cus_name") + "' and cus_birth='"
				+ request.getParameter("cus_birth") + "' and  cus_gender='" + request.getParameter("cus_gender") + "'";
		ResultSet srs = stmt.executeQuery(sql);
		if (srs.next()) {
		%>

		<div class="ment">해당 고객은 현재 등록된 고객입니다.</div>
		<div class="ment">기등록된 고객이라면 아래 목록 중 이름을 클릭, 신규등록은 신규등록을 클릭해주세요</div>
		<input type="button" value="신규 등록" style="margin-top: 10px;" onclick="fn_newCus('<%=request.getParameter("cus_name")%>','<%=request.getParameter("cus_birth")%>','<%=request.getParameter("cus_gender")%>')">

		<div id="container1" style="width: 700px; height: 250px; margin: 20px auto; padding: 10px;">
			<table>
				<tr>
					<th style="width: 70px; max-width: 70px;">고객등록일</th>
					<th>고객명</th>
					<th style="width: 70px; max-width: 70px;">생년월일</th>
					<th>성별</th>
					<th style="width: 100px; max-width: 100px;">휴대폰번호</th>
					<th style="width: 130px; max-width: 130px;">주소</th>
				</tr>
				<%
				srs = stmt.executeQuery(sql);
				while (srs.next()) {
				%>
				<tr>
					<td><%=srs.getDate("cus_cdate")%></td>
					<td onclick="cus_info('<%=srs.getString("cus_name")%>','<%=srs.getString("cus_birth")%>','<%=srs.getString("cus_gender")%>','<%=srs.getString("cus_no")%>','<%=srs.getString("cus_phone")%>','<%=srs.getString("cus_addr1")%>','<%=srs.getString("cus_addr2")%>')" style="cursor: pointer; font-weight: bold;"><%=srs.getString("cus_name")%></td>
					<td><%=srs.getDate("cus_birth")%></td>
					<td>
						<%
						if ("M".equals(srs.getString("cus_gender"))) {
							out.print("남자");
						} else {
							out.print("여자");
						} ;
						%>
					</td>
					<td><%=srs.getString("cus_phone")%></td>
					<td><%=srs.getString("cus_addr1")%>
						<%
						if (srs.getString("cus_addr2") == null) {
							out.print("");
						} else {
							out.print(srs.getString("cus_addr2"));
						} ;
						%>
					</td>
				</tr>
			<%
			}
				%>
				</table>
				<%
			} else {
			%>
			<div class="ment" style="margin-top: 30px;">등록된 고객이 없습니다.</div>
			<input type="button" value="신규등록" onclick="fn_newCus('<%=request.getParameter("cus_name")%>','<%=request.getParameter("cus_birth")%>','<%=request.getParameter("cus_gender")%>')">
			<%
			}
			%>
		</div>

	</div>
</body>
</html>
<script>
var inputElements = opener.document.querySelectorAll('.inputInput');	
var excludeIds = ["cus_name", "cus_birth", "male", "female"];


	/* 기고객 등록시 */
	/* disabled input박스를 모두 abled로, #container1 의 배경을 white로, 고객명,생년월일,성별은 모두 disabled로 */
    function cus_info(cus_name,cus_birth,cus_gender,cus_no, cus_phone, cus_addr1, cus_addr2) {
        opener.document.querySelectorAll('#container1').forEach(function(e){
            e.style.backgroundColor="white";
        })
        if(cus_addr2==null){cus_addr2=".";};
        opener.document.registCustomer.check.value = "ok";
        opener.document.registCustomer.cus_no.value = cus_no;
        opener.document.registCustomer.cus_phone.value = cus_phone.replace(/-/g,"");
        opener.document.registCustomer.cus_addr1.value = cus_addr1;
        opener.document.registCustomer.cus_addr2.value = cus_addr2;        

        inputElements.forEach(function (e) {  
                    e.disabled = false;                      
        });
        opener.document.querySelector("#cusCheck").disabled = true;
        
        opener.document.querySelector("#cus_name").disabled = true;
        opener.document.querySelector("#cus_birth").disabled = true;
        opener.document.querySelector("#male").disabled = true;
        opener.document.querySelector("#female").disabled = true;
        opener.document.querySelector('#contract1').disabled = false;
        opener.document.querySelector('#contract2').disabled = false;
        
        /* 실제값 */
        opener.document.registCustomer.cus_name2.value = cus_name;
        opener.document.registCustomer.cus_birth2.value = cus_birth;
        opener.document.registCustomer.cus_gender2.value = cus_gender;
        window.close();
    }

	/* 신규등록시 */
	/* disabled input박스를 모두 abled로, #container1 의 배경을 white로, 고객명,생년월일,성별은 모두 disabled로 */
    function fn_newCus(cus_name,cus_birth,cus_gender) {
        opener.document.querySelectorAll('#container1').forEach(function(e){
            e.style.backgroundColor="white";
        })
         opener.document.querySelector("#cusCheck").disabled = true;
        
        opener.document.registCustomer.check.value = "ok";
        opener.document.querySelector("#cus_name").disabled = true;
        opener.document.querySelector("#cus_birth").disabled = true;
        opener.document.querySelector("#male").disabled = true;
        opener.document.querySelector("#female").disabled = true;
        opener.document.querySelector('#contract1').disabled = false;
        opener.document.querySelector('#contract2').disabled = false;        
        
        inputElements.forEach(function (e) {    
                if (excludeIds.indexOf(e.id) === -1) {
                    e.disabled = false;
                }       
        });
        /* 실제값 */
        opener.document.registCustomer.cus_name2.value = cus_name;
        opener.document.registCustomer.cus_birth2.value = cus_birth;
        opener.document.registCustomer.cus_gender2.value = cus_gender;
        window.close();
        };
        
        

    
</script>