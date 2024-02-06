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
	width: 750px;
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
	margin-top:10px;
	font-size: 15px;
	height: 30px;
	cursor: pointer;
	font-weight: bold;
	background-color: white;
	border: none;
	color: maroon;
	box-sizing: border-box;
	padding:3px;
}
</style>
</head>
<body>

	<%@ include file="db/dbconn.jsp"%>


	<!-- 설정 스크린 -->
	<div id="cont" style="width: 830px; margin-left: 30px; margin-right: 30px;">
		<h3>
			유저목록::
			<span style="font-size: 14px; color: navy;">유저아이디 클릭시 상세보기</span>
		</h3>
		<div>
			<input id="keyword" name="keyword">
			<select id="keyword-type" name="keyword-type">
				<option value="user_id">아이디</option>
				<option value="user_name">이름</option>
			</select>
			<input type="button" value="검색" onclick="fn_search()">
		</div>
		<table>
			<tr>
				<th style="width: 50px; max-width: 50px;"></th>
				<th style="width: 100px; max-width: 100px;">가입일자</th>
				<th style="width: 80px; max-width: 80px;">아이디</th>
				<th style="width: 80px; max-width: 80px;">이름</th>
				<th style="width: 100px; max-width: 100px;">연락처</th>
				<th style="width: 40px; max-width: 40px;">등급</th>
				<th style="width: 60px; max-width: 60px;">상태</th>
			</tr>

			<%
			int thisPage = 0; //현재페이지
			int showList_start = 0; //목록에 보여줄 고객번호(rownum) 시작
			int showList_end = 0; //목록에 보여줄 고객번호(rownum) 끝
			if (request.getParameter("pageNo") == null || "1".equals(request.getParameter("pageNo") == null)) {
				thisPage = 1;
			}else{
				thisPage= Integer.parseInt(request.getParameter("pageNo"));
			}
			/* 0,1페이지 1~10 / 2페이지 11~20 */
			
			showList_end = thisPage * 10;
			showList_start = showList_end-9;

			String sql = "select * from (select rownum as rn, i.* from (select * from djl_user_info  order by user_cdate asc) i) where rn>="+showList_start+" and rn<="+showList_end;
			String cntSql = "select count(*) as cnt from (select rownum as rn, i.* from (select * from djl_user_info  order by user_cdate asc) i)";
			
			if (request.getParameter("keyword") != null) {
				sql += " and "+ request.getParameter("keyword-type") + " like '%" + request.getParameter("keyword") + "%'";
				cntSql += " where "+ request.getParameter("keyword-type") + " like '%" + request.getParameter("keyword") + "%'";
			}

			ResultSet srs = stmt.executeQuery(sql);

			while (srs.next()) {
			%>
			<tr>
				<td style="width: 50px; max-width: 50px;"><%=srs.getString("rn")%></td>
				<td style="width: 110px; max-width: 110px;"><%=srs.getDate("user_cdate")%></td>
				<td style="width: 80px; max-width: 80px;">
					<div class='user' onclick="fn_userView('<%=srs.getDate("user_cdate")%>','<%=srs.getString("user_id")%>','<%=srs.getString("user_name")%>','<%=srs.getString("user_phone")%>','<%=srs.getString("user_level")%>','<%=srs.getInt("failed")%>')"><%=srs.getString("user_id")%></div>
				</td>
				<td style="width: 80px; max-width: 80px;"><%=srs.getString("user_name")%></td>
				<td style="width: 100px; max-width: 100px;"><%=srs.getString("user_phone")%></td>
				<td style="width: 40px; max-width: 40px;" oninput="fn_level(this.value)"><%=srs.getString("user_level")%></td>
				<td style="width: 60px; max-width: 60px;">
					<%
					if (srs.getInt("failed") > 4) {
						out.print("잠금");
					} else {
						out.print("활성화");
					} ;
					%>
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

	<!-- 상세보기 -->
	<div id="cont" style="width: 300px;">
		<h3>상세보기</h3>
		<div style="border-bottom: 1px solid #ccc; padding-bottom: 20px;">
			<table class="detailView" style="width: 280px;">
				<tr>
					<th>가입일자</th>
					<td>
						<input class="inputInput" id="user_cdate" disabled="disabled">
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input class="inputInput" id="user_id_fake" disabled>
						<input id="user_id" hidden='hidden'>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input class="inputInput" id="user_name" style="border: 1px solid green;">
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						<input class="inputInput" id="user_phone" maxlength="11" style="border: 1px solid green;">
					</td>
				</tr>
				<tr>
					<th>
						<div>등급</div>
						<div style="font-size: 11px;">A:관리자 U:일반</div>
					</th>
					<td>
						<input class="inputInput" style="width: 50px; float: left; border: 1px solid green;" id="user_level" maxlength="1">
						<input class="inputInput" id="user_level_kor" style="width: 80px; float: left;" disabled="disabled">
					</td>
				</tr>
			</table>
			
		</div>
		<div style="margin-top: 15px; text-align: center" hidden='hidden' id="selectBtn">
			<input type="button" value="비밀번호초기화" onclick="fn_user('user_resetPwd')" class="resetPwd">
			<input type="button" value="회원수정" onclick="fn_user('user_update')">
			<input type="button" value="회원삭제" onclick="fn_user('user_delete')">
		</div>
	</div>


	<%
	conn.close();
	%>
</body>
</html>
<script>
    var kor = /^[ㄱ-ㅎㅏ-ㅣ가-힣]+$/;
    var koreng = /^[가-힣a-zA-Z]+$/;
    var number = /^[0-9]+$/;

    var level = "";
    
    /* 페이지 이동 */
    function movePage(page) {
        location.href = "main.jsp?section=admin_menu&menu=admin_user_set&pageNo=" + page;
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

    function fn_search() {
        $(function () {
            console.log($("#keyword-type").val());
            console.log($("#keyword").val());
            location.href = "main.jsp?section=admin_menu&menu=admin_user_set&keyword-type="
                    + $("#keyword-type").val()
                    + "&keyword="
                    + $("#keyword").val();
        });
    }

    /* 등급 입력시마다 한국어 등급 변경 */
    $(function () {
        $("#user_level").on("propertychange change paste input", function () {
            if ($("#user_level").val() == "A") {
                $("#user_level_kor").val("관리자");
            } else if ($("#user_level").val() == "U") {
                $("#user_level_kor").val("일반");
            } else {
                $("#user_level_kor").val("");
            }
        });
    });

    /* 유저아이디 클릭시 상세보기 */
    function fn_userView(user_cdate, user_id, user_name, user_phone,user_level, failed) {
        if ("A" == user_level) {
            level = "관리자";
        } else if ('U' == user_level) {
            level = "일반";
        }
        $(function () {
            $("#selectBtn").show();
            $("#user_cdate").val(user_cdate);
            $("#user_id_fake").val(user_id);
            $("#user_id").val(user_id);
            $("#user_name").val(user_name);
            $("#user_phone").val(user_phone);
            $("#user_level").val(user_level);
            $("#user_level_kor").val(level);
        })
    }
    /* 상세보기 내 버튼클릭시 */
    function fn_user(setType) {
        var user_name_val = document.querySelector("#user_name").value;
        var user_phone_val = document.querySelector("#user_phone").value;
        var user_level_val = document.querySelector("#user_level").value;

        /* 회원 수정시 */
        if (setType == 'user_update') {
            if (user_name_val == "") {
                alert("이름을 입력해주세요.");
            } else if (/[^가-힣]/g.test(user_name_val)) {
                alert("이름을 제대로 입력해주세요.")
                return;
            } else if (user_phone_val.length != 11) {
                alert("휴대폰 번호는 -제외 11자리를 입력해주세요.");
                return;
            } else if (/[^0-9]/g.test(user_phone_val)) {
                alert("휴대폰 번호를 제대로 입력해주세요.");
                return;
            } else if (/[^0-9]/g.test(user_phone_val)) {
                alert("휴대폰 번호를 제대로 입력해주세요.");
                return;
            } else if (user_level_val != "A" && user_level_val != "U") {
                alert("등급은 A와 U 중에서 한글자만 입력해주세요.");
                return;
            }
            ajax(setType);
        }
        /* 비밀번호 초기화 */
        else if (setType == 'user_resetPwd') {
            ajax(setType);
        }
        /* 회원삭제 */
        else if (setType == 'user_delete') {
            if (confirm("정말로 해당 계정을 삭제하시겠습니까?")) {
                ajax(setType);
            }
        }
    }

    /* ajax */
    function ajax(setType) {
        $(function () {
            //ajax 실행            
            $.ajax({
                type : 'POST',
                url : 'ajax.jsp',
                data : {
                    user_id : $("#user_id").val(),
                    user_name : $("#user_name").val(),
                    user_phone : $("#user_phone").val(),
                    user_level : $("#user_level").val(),
                    type : setType
                },
                success : function (response) {

                    /* 비밀번호초기화시 */
                    if (setType == "user_resetPwd") {
                        if (response.trim() === "success") {
                            alert("비밀번호 초기화 완료")
                            location.reload();
                        } else {
                            alert("문제가 계속된다면 관리자에게 문의하세요.");
                        }
                    }
                    /* 유저정보수정시 */
                    else if (setType == "user_update") {
                        if (response.trim() === "success") {
                            alert("수정 완료")
                            location.reload();
                        } else {
                            alert("문제가 계속된다면 관리자에게 문의하세요.");
                        }
                    } else if (setType == "user_delete") {
                        if (response.trim() === "success") {
                            alert("계정 삭제 완료")
                            location.reload();
                        } else {
                            alert("문제가 계속된다면 관리자에게 문의하세요.");
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