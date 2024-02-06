<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.inputBOX {
	width: 250px;
	position: relative;
	margin-bottom: 30px;
}

.explainInput {
	font-size: 12px;
	bottom: 35px;
}

.explainInput-in {
	font-size: 15px;
	bottom: 12px;
}

.inputInput {
	width: 200px;
	height: 40px;
	font-size: 15px;
}

.comment {
	border: 1px solid #ccc;
	width: 615px;
	border-radius: 10px;
	height: 350px;
	padding: 5px;
	box-sizing: border-box;
	margin: 0px auto;
	overflow-y: scroll;
}

.commentTxt {
	border: 1px solid #ccc;
	width: 550px;
	border-radius: 10px;
	height: 100px;
	padding: 5px;
	box-sizing: border-box;
	margin: 5px auto;
}

.commentRegist {
	width: 60px;
	position: absolute;
	right: 15px;
	bottom: 5px;
	height: 100px;
}

.button:hover {
	background-color: rgba(0, 0, 0, 0.1);
}

th, td {
	font-size: 13px;
	padding: 10px;
}

th {
	padding: 10px 5px;
	background-color: rgba(0, 0, 0, 0.05);
}

table {
	margin: 0px auto;
}

.button {
	margin: 10px;
	margin-top: 20px;
	padding: 10px 15px;
	font-size: 17px;
	border-radius: 5px;
	background-color: rgba(0, 0, 0, 0.025);
	cursor: pointer;
	padding: 10px 15px;
	border: 1px solid #ccc;
}

.cmtTxt {
	border-bottom: 1px solid #ccc;
	margin-top: 5px;
	margin-bottom: 10px;
	padding-left: 5px;
	padding-bottom: 5px;
}
</style>
</head>
<body>
	<%@ include file="db/dbconn.jsp"%>
	<%
	SimpleDateFormat DateFormat = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat CMTDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String cus_no = request.getParameter("cus_no");
	
	String sql = "select * from djl_cus_info c left join djl_sell s on c.cus_no = s.cus_no where deleteyn='N' and c.cus_no="
			+ cus_no;
	ResultSet srs = stmt.executeQuery(sql);

	/* 고객정보 필드 */
	if (!srs.next()) {
	%>
	<script>
        alert("잘못된 접근입니다.");
        location.href = "main.jsp?section=customer_list";
    </script>
	<%
	} else {
	%>



	<form name="viewCustomer" id="viewCustomer">
		<div id="section-contents" style="height: 700px;">
			<h1>고객조회</h1>
			<div style="border: 1px solid #ccc; height: 600px; padding: 20px; background-color: white; border-radius: 10px; padding-top: 0px;">
				<div style="width: 350px; margin-rigth: 30px; float: left">
					<h4>고객정보</h4>
					<input name="cus_no" id="cus_no" value="<%=cus_no%>" hidden="hidden">
					<input name="user_id" id="user_id" value="<%=session.getAttribute("user_id")%>" hidden="hidden">
				</div>
				<div style="width: 700px; margin-rigth: 30px; float: left">
					<h4>
						판매이력::
						<span style="font-size: 12px; color: navy;">판매일자 클릭 상세보기(미구현)</span>
					</h4>
				</div>
				<div style="width: 70px; margin-rigth: 30px; float: left">
					<h4>히스토리</h4>
				</div>

				<div id="container1" style="height: 410px; width: 250px; margin: 0px; position: static; padding: 30px; background-color: white; text-align: left; clear: both; float: left; margin-right: 30px;">
					<div class="inputBOX">
						<label>
							<span class="explainInput"> 고객명</span>
							<input class="inputInput" name="cus_name" id="cus_name" value="<%=srs.getString("cus_name")%>">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput"> 생년월일(8자리)</span>
							<input class="inputInput" name="cus_birth" id="cus_birth" maxlength="8" value="<%=DateFormat.format(srs.getDate("cus_birth"))%>">
						</label>
					</div>
					<div class="inputBOX">
						<div class="inputInput" style="color: dimgrey; font-size: 12px; line-height: 15px; padding-top: 15px; height: 30px;">
							<span style="font-size: 15px; position: absolute; bottom: 37px; background-color: white"> 성별</span>
							<label>
								<input type="radio" name="cus_gender" value="M" <%if("M".equals(srs.getString("cus_gender").trim())) out.print("checked"); %>>
								남자
							</label>
							<label>
								<input type="radio" name="cus_gender" value="F" <%if("F".equals(srs.getString("cus_gender").trim())) out.print("checked"); %>>
								여자		
							</label>			
							
						</div>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput"> 휴대폰번호(-제외)</span>
							<input class="inputInput" name="cus_phone" id="cus_phone" maxlength="11" value="<%=srs.getString("cus_phone").replace("-", "")%>">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput"> 주소</span>
							<input class="inputInput" name="cus_addr1" id="cus_addr1" value="<%=srs.getString("cus_addr1")%>">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput"> 상세주소</span>
							<input class="inputInput" name="cus_addr2" id="cus_addr2" value="<%if (srs.getString("cus_addr2") == null) {
	out.print("");
} else {
	out.print(srs.getString("cus_addr2"));
}%>">
						</label>
					</div>
				</div>


				<%
				srs = stmt.executeQuery(sql);
				srs.next();
				%>
				<!-- 판매이력 -->
				<div id="container1" style="height: 450px; width: 632px; margin: 0px; position: static; padding: 10px; background-color: white; text-align: center; float: left; margin-right: 30px; overflow: scroll;">
					<%
					if (srs.getString("sell_no") != null) {
					%>
					<table>
						<tr>
							<th>판매일자</th>
							<th>모델</th>
							<th>색상</th>
							<th>일련번호</th>
							<th>통신사</th>
							<th>약정</th>
							<th>상태</th>
							<th>판매자</th>
						</tr>
						<%
						srs = stmt.executeQuery(sql);						
						while (srs.next()) {
						%>
						<tr>
							<td style="max-width: 80px; width: 80px;"><%=srs.getDate("sell_date")%>
							</td>
							<td style="max-width: 50px; width: 50px;"><%=srs.getString("product_no")%>
							</td>
							<td style="max-width: 60px; width: 60px;"><%=srs.getString("product_color")%>
							</td>
							<td style="max-width: 60px; width: 60px;"><%=srs.getString("product_pkno")%>
							</td>
							<td style="max-width: 70px; width: 70px;"><%=srs.getString("telecom")%>
							</td>
							<td style="max-width: 70px; width: 70px;"><%=srs.getString("contract")%>
							</td>
							<td style="max-width: 70px; width: 70px;"><%=srs.getString("status")%>
							</td>
							<td style="max-width: 80px; width: 80px;"><%=srs.getString("sales_name")%>
							</td>
						</tr>
						<%
						}
						%>
					</table>
					<%
					} else {
					%>
					<div style="text-align: center; margin-top: 200px; font-size: 20px;">아무것도 없어요😂</div>
					<%
					}
					
					%>

				</div>
				<!-- 코멘트이력 -->
				<div id="container1" class="reloadDIV" style="height: 450px; width: 620px; position: relative; margin: 0px; position: relative; padding: 10px; background-color: white; text-align: left; float: left;">
					<div class="comment" id="comment">
						<%
						String cmtSql = "select * from djl_cus_comment where deleteyn='N' and cus_no=" + request.getParameter("cus_no") + " order by cdate desc";
						ResultSet cmtSrs = stmt.executeQuery(cmtSql);

						if (cmtSrs.next()) {
							cmtSrs = stmt.executeQuery(cmtSql);
							while (cmtSrs.next()) {
							%>
							<div style="padding:5px;"><%=cmtSrs.getString("user_id")%>	|	<%=CMTDateFormat.format(cmtSrs.getDate("cdate"))%></div>
							<div class="cmtTxt"><%=cmtSrs.getString("cmt")%></div>
							<%
							}
						} else {
							%>
							<div style="text-align: center; margin-top: 150px; font-size: 20px;">아무것도 없어요😂</div>
							<%
							}
							%>
					</div>
					<div>
						<textarea class="commentTxt" name="cmt"></textarea>
						<input value="등록" type="button" class="commentRegist" onclick='fn_cmt()'>
					</div>
				</div>
				<div style="text-align: center;">
					<input name="type" value="registC" hidden="hidden">
					<input type="button" value="정보수정" class="button" onclick='fn_button("update")'>
					<input type="button" value="고객삭제" class="button" onclick="fn_button('delete')">
					<input type="button" value="목록으로" class="button" onclick="history.back()">
				</div>
			</div>
		</div>

	</form>
	<%
	}

	conn.close();
	%>
</body>

</html>
<script>

var viewC = document.viewCustomer;
/*     $(function () {
        $("#viewCustomer input[name='cus_gender']").on("click", function () {
            alert($("#viewCustomer input[name='cus_gender']:checked").val());
        })
    }) */

    /* 조건식 */

    var kor = /^[ㄱ-ㅎㅏ-ㅣ가-힣]+$/;
    var koreng = /^[가-힣a-zA-Z]+$/;
    var number = /^[0-9]+$/;

    // Enter 키 이벤트 처리
    $(function () {
        $('.inputInput').on('keypress', function (event) {
            if (event.which === 13) {
                fn_button('submit');
            }
        });

    });
   
    /* 버튼 클릭시 */
    function fn_button(type) {
        /* 고객삭제 */
        if (type == "delete") {
            if (confirm("해당 고객님의 정보를 모두 삭제하시겠습니까?")) {

                //ajax 실행            
                $.ajax({
                    type : 'POST',
                    url : 'ajax.jsp',
                    data : {
                        cus_no : $("#cus_no").val(),
                        type : 'delete'
                    },
                    success : function (response) {
                        if (response.trim() === "success") {
                            location.href = "main.jsp?section=customer_list";
                        } else {
                            alert("문제가 계속된다면 관리자에게 문의하세요.");
                        }
                    },
                    error : function (error) {
                        console.error('에러 발생:', error);
                    }
                });
            }
        }

        /* 고객수정 */
        else if (type == "update") {
            if (viewC.cus_name.value == "") {
                alert("고객명을 입력해주세요");
                return;
            } else if (!koreng.test(viewC.cus_name.value)) {
                alert("고객명을 제대로 입력해주세요");
                return;
            } else if (viewC.cus_birth.value == "") {
                alert("생년월일을 입력해주세요");
                return;
            } else if (!number.test(viewC.cus_birth.value)
                    || viewC.cus_birth.value.length != 8) {
                alert("생년월일을 제대로 입력해주세요");
                return;
            } else if (viewC.cus_phone.value == "") {
                alert("휴대폰번호를 입력해주세요");
                return;
            } else if (!number.test(viewC.cus_phone.value)
                    || viewC.cus_phone.value.length != 11) {
                alert("휴대폰번호를 제대로 입력해주세요");
                return;
            } else {
                //ajax 실행            
                $.ajax({
                    type : 'POST',
                    url : 'ajax.jsp',
                    data : {
                        cus_no : $("#cus_no").val(),
                        cus_name : $("#cus_name").val(),
                        cus_birth : $("#cus_birth").val(),
                        cus_gender : $("#viewCustomer input[name='cus_gender']:checked").val(),
                        cus_phone : $("#cus_phone").val(),
                        cus_addr1 : $("#cus_addr1").val(),
                        cus_addr2 : $("#cus_addr2").val(),
                        type : 'update'
                    },
                    success : function (response) {
                        if (response.trim() === "success") {
                            alert("수정완료");
                            location.reload();
                        } else {
                            alert("문제가 계속된다면 관리자에게 문의하세요.");
                        }
                    },
                    error : function (error) {
                        console.error('에러 발생:', error);
                    }
                });
            }
        }
    }

    $(function () {
        $(".inputInput").on("focus", function () {
            $(this).parent().find(".explainInput").animate({
                bottom : "35px",
                left : "20px",
                fontSize : "12px"
            }, 50)
        })
        $(".inputInput").on("blur", function () {
            if ($(this).val() == "") {
                $(this).parent().find(".explainInput").animate({
                    bottom : "12px",
                    left : "30px",
                    fontSize : "15px"
                }, 100)
            }
        })
        $(".inputInput").on("focus", function () {
            $(this).parent().find(".explainInput-in").animate({
                bottom : "35px",
                left : "20px",
                fontSize : "12px"
            }, 50)
        })
        $(".inputInput").on("blur", function () {
            if ($(this).val() == "") {
                $(this).parent().find(".explainInput-in").animate({
                    bottom : "12px",
                    left : "30px",
                    fontSize : "15px"
                }, 100)
            }
        })
    })
    
        /* 코멘트 입력 */
    function fn_cmt() {
        var cmtValue = viewC.cmt.value;

                //ajax 실행            
                $.ajax({
                    type : 'POST',
                    url : 'ajax.jsp',
                    data : {
                        cus_no : $("#cus_no").val(),
                        user_id : $("#user_id").val(),
                        cmt : cmtValue,
                        type : 'registCmt'
                    },
                    success : function (response) {
                        if (response.trim() === "success") {
                            alert("코멘트 등록 완료");
                            $(".reloadDIV").load(location.href+ " #comment");
                        } else {
                            alert("문제가 계속된다면 관리자에게 문의하세요.");
                        }
                    },
                    error : function (error) {
                        console.error('에러 발생:', error);
                    }
                });
            }
        

    
</script>