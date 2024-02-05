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
	height: 530px;
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
</style>
</head>
<body>
	<%
	if (!"null".equals(session.getAttribute("user_level")) && request.isRequestedSessionIdValid()
			&& session.getAttribute("user_level") != null && "A".equals(session.getAttribute("user_level"))) {
	%>

	<%@ include file="db/dbconn.jsp"%>
	<div id="section-contents" style="height: 700px;">
		<h1>관리자메뉴</h1>
		<!-- 메뉴 스크린 -->
		<div id="cont">
			<a>유저관리</a> <a>미구현</a> <a>미구현</a> <a>미구현</a> <a>미구현</a> <a>미구현</a> <a>미구현</a>
		</div>

		<!-- 설정 스크린 -->
		<div id="cont" style="width: 830px; margin-left: 30px; margin-right: 30px;">
			<h3>
				유저목록::
				<span style="font-size: 14px; color: navy;">유저아이디 클릭시 상세보기</span>
			</h3>
			<div>
				<input>
				<select>
					<option>아이디</option>
					<option>이름</option>
				</select>
				<input type="button" value="검색">
			</div>
			<table>
				<tr>
					<th></th>
					<th>가입일자</th>
					<th>아이디</th>
					<th>이름</th>
					<th>연락처</th>
					<th>등급</th>
					<th>상태</th>
				</tr>

				<%
				SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy-MM-dd");
				String sql = "select * from (select rownum as rn,i.* from djl_user_info i)";
				ResultSet srs = stmt.executeQuery(sql);

				while (srs.next()) {
				%>
				<tr>
					<td style="width: 40px; max-width: 40px;"><%=srs.getString("rn")%></td>
					<td style="width: 100px; max-width: 100px;"><%=DateFormat.format(srs.getDate("user_cdate"))%></td>
					<td style="width: 80px; max-width: 80px;">
						<div class='user' onclick="fn_userView('<%=srs.getDate("user_cdate")%>','<%=srs.getString("user_id")%>','<%=srs.getString("user_name")%>','<%=srs.getString("user_phone")%>','<%=srs.getString("user_level")%>')"><%=srs.getString("user_id")%></div>
					</td>
					<td style="width: 80px; max-width: 80px;"><%=srs.getString("user_name")%></td>
					<td style="width: 100px; max-width: 100px;"><%=srs.getString("user_phone")%></td>
					<td style="width: 40px; max-width: 40px;"><%=srs.getString("user_level")%></td>
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
		</div>
		<div id="cont" style="width: 300px;">
			<h3>상세보기</h3>
			<div style="border-bottom: 1px solid #ccc; padding-bottom: 20px;">
				<table class="detailView">
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
							<input class="inputInput" id="user_name">
						</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>
							<input class="inputInput" id="user_phone" maxlength="11">
						</td>
					</tr>
					<tr>
						<th>등급</th>
						<td>
							<input class="inputInput" style=" width:50px; float: left;" id="user_level">
							<input class="inputInput" id="user_level_kor" style="width:80px; float: left;">
						</td>
					</tr>
				</table>
			</div>
			<div style="margin-top: 15px; text-align: center" hidden='hidden' id="selectBtn">
				<input type="button" value="비밀번호초기화" onclick="fn_user('user_resetPwd')">
				<input type="button" value="회원수정" onclick="fn_user('user_update')">
				<input type="button" value="회원삭제" onclick="fn_user('user_delete')">
			</div>
		</div>

	</div>
	<!-- section contents -->
	<%
	conn.close();
	} else {
	%>
	<script>
        alert("관리자 권한만 접속 가능합니다.");
        location.href="main.jsp?section=customer_list"
    </script>
	<%
	}
	%>
</body>
</html>
<script>
    /*    var kor = /^[ㄱ-ㅎㅏ-ㅣ가-힣]+$/;
       var koreng = /^[가-힣a-zA-Z]+$/;
       var number = /^[0-9]+$/;
       if(registC.check.value=="no"){
           alert("고객조회를 먼저 해주세요.")
           return;
       } else if (registC.cus_phone.value == "") {
           alert("휴대폰번호를 입력해주세요");
           return;
       } else if (!number.test(registC.cus_phone.value)
               || registC.cus_phone.value.length != 11) {
           alert("휴대폰번호를 제대로 입력해주세요");
           return;
       } */

    function fn_userView(user_cdate, user_id, user_name, user_phone, user_level) {
        var level = "";
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

    function fn_user(setType) {
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
                    else if(setType == "user_update"){
                        if (response.trim() === "success") {
                            alert("비밀번호 초기화 완료")
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