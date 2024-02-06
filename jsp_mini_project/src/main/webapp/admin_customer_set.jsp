<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#cont {
	border: 1px solid #ccc;
	height: 600px;
	padding: 20px;
	background-color: white;
	border-radius: 10px;
	padding-top: 0px;
	width: 200px;
	float: left;
}

a {
	display: block;
	text-align: center;
	margin-top: 20px;
	font-weight: bold;
	border: 1px solid #ccc;
	padding: 15px;
	border-radius: 10px;
	background-color: rgba(0, 0, 0, 0.0125);
}

table {
	margin-top: 10px;
	width: 850px;
	margin-right: 0px;
}

th {
	padding: 15px 10px;
	background-color: rgba(0, 0, 0, 0.025);
}

td {
	font-size: 14px;
}

.detailView th {
	background-color: white;
	border: none;
}

.detailView td {
	padding: 0px;
	border: none;
}

.detailView {
	border: none;
	margin: 0px auto;
}

.inputInput {
	margin: 5px;
	width: 150px;
	height: 30px;
	font-size: 13px;
	text-align: center;
	padding: 1px 5px;
}

.user {
	font-weight: bold;
	color: navy;
	cursor: pointer;
}

.user:hover {
	transform: scale(1.05);
}

.pageNumber {
	margin-top: 10px;
	font-size: 15px;
	height: 30px;
	cursor: pointer;
	font-weight: bold;
	background-color: white;
	border: none;
	color: maroon;
	box-sizing: border-box;
	padding: 3px;
}
</style>
</head>
<body>

	<%@ include file="db/dbconn.jsp"%>


	<!-- 설정 스크린 -->
	<div id="cont" style="width: 850px; margin-left: 30px; margin-right: 30px; padding-right: 10px;">
		<h3>
			삭제고객관리::
			<span style="font-size: 14px; color: navy;">ㅇㅇ</span>
		</h3>
		<div>
			<input id="keyword" name="keyword">
			<select id="keyword-type" name="keyword-type">
				<option value="cus_name">이름</option>
				<option value="cus_phone">휴대폰번호</option>
			</select>
			<input type="button" value="검색" onclick="fn_search()">
			<span style="float: right">
				<input type="button" value="전체선택" onclick='fn_allSelect()'>
				<input type="button" value="선택복구" onclick='fn_selectCus("restore_cus")'>
				<input type="button" value="선택삭제" onclick='fn_selectCus("clear_cus")'>
			</span>
		</div>
		<table>
			<tr>
				<th style="width: 50px; max-width: 50px;"></th>
				<th style="width: 100px; max-width: 100px;">가입일자</th>
				<th style="width: 80px; max-width: 80px;">이름</th>
				<th style="width: 50px; max-width: 50px;">성별</th>
				<th style="width: 80px; max-width: 80px;">생년월일</th>
				<th style="width: 100px; max-width: 100px;">휴대폰번호</th>
				<th style="width: 50px; max-width: 50px;">선택</th>
			</tr>

			<%
			int thisPage = 0; //현재페이지
			int showList_start = 0; //목록에 보여줄 고객번호(rownum) 시작
			int showList_end = 0; //목록에 보여줄 고객번호(rownum) 끝
			if (request.getParameter("pageNo") == null || "1".equals(request.getParameter("pageNo") == null)) {
				thisPage = 1;
			} else {
				thisPage = Integer.parseInt(request.getParameter("pageNo"));
			}
			/* 0,1페이지 1~10 / 2페이지 11~20 */

			showList_end = thisPage * 10;
			showList_start = showList_end - 9;

			String sql = "select * from (select rownum as rn, i.* from (select * from djl_cus_info where deleteyn='Y' order by cus_cdate asc) i) where rn>="
					+ showList_start + " and rn<=" + showList_end;
			String cntSql = "select count(*) as cnt from (select rownum as rn, i.* from (select * from djl_cus_info where deleteyn='Y'  order by cus_cdate asc) i)";

			if (request.getParameter("keyword") != null) {
				sql += " and " + request.getParameter("keyword-type") + " like '%" + request.getParameter("keyword") + "%'";
				cntSql += " where " + request.getParameter("keyword-type") + " like '%" + request.getParameter("keyword") + "%'";
			}

			ResultSet srs = stmt.executeQuery(sql);

			while (srs.next()) {
			%>
			<tr>
				<td style="width: 50px; max-width: 50px;"><%=srs.getString("rn")%></td>
				<td style="width: 110px; max-width: 110px;"><%=srs.getDate("cus_cdate")%></td>
				<td style="width: 80px; max-width: 80px;"><%=srs.getString("cus_name")%></td>
				<td style="width: 80px; max-width: 80px;">
					<%
					if ("M".equals(srs.getString("cus_gender"))) {
						out.print("남자");
					} else {
						out.print("여자");
					} ;
					%>
				</td>
				<td style="width: 80px; max-width: 80px;"><%=srs.getDate("cus_birth")%></td>
				<td style="width: 100px; max-width: 100px;"><%=srs.getString("cus_phone")%></td>
				<td style="width: 50px; max-width: 50px;">
					<input type="checkbox" value="<%=srs.getString("cus_no")%>" name="cus_no">
				</td>
			</tr>
			<%
			}
			%>
		</table>
		<div style="text-align: center">
			<%
			/* 최대 cnt 확인 */
			ResultSet cntResult = stmt.executeQuery(cntSql);

			int maxCnt = 0;
			if (cntResult.next()) {
				maxCnt = cntResult.getInt("cnt");
			}

			// 전체 페이지 수 계산
			int totalPageCnt = (int) Math.ceil((double) maxCnt / 10);

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
			%>
		</div>
	</div>




	<%
	conn.close();
	%>
</body>
</html>
<script>

	/* 일괄선택 */
    function fn_allSelect() {
	    $(function (){
	        $("input[type='checkbox']").prop("checked",true);
	    })        
    }

    // Enter 키 이벤트 처리    
    $(function () {
        $('#keyword').on('keypress', function (event) {
            if (event.which === 13) {
                fn_search();
            }
        });
        $('#keyword-type').on('keypress', function (event) {
            if (event.which === 13) {
                fn_search();
            }
        });
    });

    /* 검색 */
    function fn_search() {
        $(function () {
            console.log($("#keyword-type").val());
            console.log($("#keyword").val());
            location.href = "main.jsp?section=admin_menu&menu=admin_customer_set&keyword-type="
                    + $("#keyword-type").val()
                    + "&keyword="
                    + $("#keyword").val();
        });
    }

    /* 삭제 및 복구 */
    function fn_selectCus(type) {
        var cusNo = [];
        var checkBoxes = document
                .querySelectorAll('input[name="cus_no"]:checked');
        checkBoxes.forEach(function (value, index) {
            cusNo[index] = value.value;
        });
        if (type == "clear_cus") {
            if (confirm("선택된 고객들을 완전히 삭제하시겠습니까?")) {
                ajax(type, cusNo);
            }
        } else if (type == "restore_cus") {
            if (confirm("선택된 고객들을 복구시키겠습니까?")) {
                ajax(type, cusNo);
            }
        }
    }

    function ajax(selectType, cusNo) {

        $(function () {
            //ajax 실행            
            $.ajax({
                type : 'POST',
                traditional : true,
                url : 'ajax.jsp',
                data : {
                    cus_no : cusNo,
                    type : selectType
                },
                success : function (response) {

                    if (response.trim() == "success") {
                        location.reload();
                        if (selectType == "clear_cus") {
                            alert("선택된 고객들이 완전히 삭제되었습니다.")
                        } else if (selectType == "restore_cus") {
                            alert("선택된 고객들이 복구되었습니다.")
                        }
                    }
                },
                error : function (error) {
                    console.error('에러 발생:', error);
                }
            });
        })
    }
</script>