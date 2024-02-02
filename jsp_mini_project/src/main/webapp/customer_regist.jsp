<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

.button {
	margin: 10px;
	margin-top: 20px;
	padding: 10px 15px;
	font-size: 17px;
	border-radius: 5px;
	background-color: rgba(0, 0, 0, 0.1);
	cursor: pointer;
	padding: 10px 15px;
}

.button:hover {
	background-color: rgba(0, 0, 0, 0.2);
}
</style>
</head>
<body>
	<%@ include file="db/dbconn.jsp"%>
	<form name="registCustomer" id="registCustomer">
		<div id="section-contents" style="height: 700px;">
			<h1>고객등록</h1>
			<div style="border: 1px solid #ccc; height: 530px; padding: 20px; background-color: white; border-radius: 10px; padding-top: 0px;">
				<div style="width: 350px; margin-rigth: 30px; float: left">
					<h4>고객정보</h4>
				</div>
				<div style="width: 700px; margin-rigth: 30px; float: left">
					<h4>판매정보</h4>
				</div>
				<div style="width: 70px; margin-rigth: 30px; float: left">
					<h4>기타</h4>
				</div>

				<div id="container1" style="height: 410px; width: 250px; margin: 0px; position: static; padding: 30px; background-color: white; text-align: left; clear: both; float: left; margin-right: 30px;">
					<div class="inputBOX">
						<label>
							<span class="explainInput"> 고객명</span>
							<input class="inputInput" name="cus_name" id="cus_name" autofocus>
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 생년월일(8자리)</span>
							<input class="inputInput" name="cus_birth" id="cus_birth" maxlength="8">
						</label>
					</div>
					<div class="inputBOX">
						<div class="inputInput" style="color: dimgrey; font-size: 12px; line-height: 15px; padding-top: 15px; height: 30px;">
							<span style="font-size: 15px; position: absolute; bottom: 37px; background-color: white"> 성별</span>
							<input type="radio" name="cus_gender" value="M" checked>
							남자
							<input type="radio" name="cus_gender" value="F">
							여자
						</div>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 휴대폰번호(-제외)</span>
							<input class="inputInput" name="cus_phone" id="cus_phone" maxlength="11">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 주소</span>
							<input class="inputInput" name="cus_addr1" id="cus_addr1">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 상세주소</span>
							<input class="inputInput" name="cus_addr2" id="cus_addr2">
						</label>
					</div>

				</div>
				<div id="container1" style="height: 410px; width: 250px; margin: 0px; position: static; padding: 30px; background-color: white; text-align: left; float: left; margin-right: 30px;">
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 개통모델</span>
							<input class="inputInput" name="product_no" id="product_no">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 일련번호</span>
							<input class="inputInput" name="product_pkno" id="product_pkno">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 색상</span>
							<input class="inputInput" name="product_color" id="product_color">
							<!-- <input class="inputInput" name="product_color" id="product_color" disabled placeholder="색상" style="font-size: 15px; color: dimgray;"> -->
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 가격</span>
							<input class="inputInput" name="product_price" id="product_price">
						</label>
					</div>
					<div class="inputBOX">
						<div class="inputInput" style="color: dimgrey; font-size: 12px; line-height: 15px; padding-top: 15px; height: 30px;">
							<span style="font-size: 15px; position: absolute; bottom: 37px; background-color: white"> 약정</span>
							<input type="radio" name="contract" value="요금할인" checked>
							요금할인
							<input type="radio" name="contract" value="기기할인">
							기기할인
						</div>
					</div>

					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 요금제</span>
							<input class="inputInput" name="mobileplan" id="mobileplan">
						</label>
					</div>
				</div>
				<div id="container1" style="height: 410px; width: 250px; margin: 0px; position: static; padding: 30px; text-align: left; float: left; margin-right: 30px;">
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 공시지원금</span>
							<input class="inputInput" name="telfund" id="telfund">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 개인지원금</span>
							<input class="inputInput" name="fund" id="fund">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 판매자</span>
							<input class="inputInput" name="sales_name" id="sales_name">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 판매일자(8자리)</span>
							<input class="inputInput" name="sell_date" id="sell_date" maxlength="8">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput-in"> 통신사</span>
							<input class="inputInput" name="telecom" id="telecom">
						</label>
					</div>
					<div class="inputBOX">
						<label>
							<span class="explainInput"> 개통상태</span>
							<input class="inputInput" name="status" id="status" value="개통완료">
						</label>
					</div>
				</div>
				<div id="container1" style="height: 450px; width: 620px; margin: 0px; position: relative; padding: 10px; background-color: white; text-align: left; float: left;">
					<div class="comment"></div>
					<div>
						<textarea class="commentTxt"></textarea>
						<input value="등록" type="button" class="commentRegist">
					</div>
				</div>
			</div>
			<div style="text-align: center;">
				<input name="type" value="registC" hidden="hidden">
				<input type="button" value="고객등록" class="button" onclick="fn_button('submit')">
				<input type="button" value="취소" class="button" onclick="fn_button('cancel')">
			</div>
		</div>
	</form>
	<%
	conn.close();
	%>

</body>

</html>
<script>
    /* 조건식 */
    var registC = document.registCustomer;
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
        if (type == "cancel") {
            if (confirm("작성중인 내용이 모두 사라집니다. 계속 하시겠습니까?")) {
                location.href = "main.jsp?section=customer_list";
            }
        } else if (type == "submit") {
            if (registC.cus_name.value == "") {
                alert("고객명을 입력해주세요");
                return;
            } else if (!koreng.test(registC.cus_name.value)) {
                alert("고객명을 제대로 입력해주세요");
                return;
            } else if (registC.cus_birth.value == "") {
                alert("생년월일을 입력해주세요");
                return;
            } else if (!number.test(registC.cus_birth.value)
                    || registC.cus_birth.value.length != 8) {
                alert("생년월일을 제대로 입력해주세요");
                return;
            } else if (registC.cus_phone.value == "") {
                alert("휴대폰번호를 입력해주세요");
                return;
            } else if (!number.test(registC.cus_phone.value)
                    || registC.cus_phone.value.length != 11) {
                alert("휴대폰번호를 제대로 입력해주세요");
                return;
            } else if (registC.product_no.value == "") {
                alert("개통모델을 입력해주세요");
                return;
            } else if (kor.test(registC.product_no.value)) {
                alert("개통모델을 제대로 입력해주세요");
                return;
            } else if (registC.product_pkno.value == "") {
                alert("일련번호를 입력해주세요");
                return;
            } else if (!number.test(registC.product_pkno.value)) {
                alert("일련번호는 숫자만 입력해주세요");
                return;
            } else if (registC.product_color.value == "") {
                alert("색상을 입력해주세요");
                return;
            } else if (registC.product_price.value == "") {
                alert("가격을 입력해주세요");
                return;
            } else if (registC.mobileplan.value == "") {
                alert("요금제를 입력해주세요");
                return;
            } else if (registC.telfund.value == "") {
                alert("공시지원금을 입력해주세요");
                return;
            } else if (!number.test(registC.telfund.value)) {
                alert("공시지원금은 숫자만 입력해주세요");
                return;
            } else if (registC.fund.value == "") {
                alert("개인지원금을 입력해주세요");
                return;
            } else if (!number.test(registC.fund.value)) {
                alert("개인지원금은 숫자만 입력해주세요");
                return;
            } else if (registC.sales_name.value == "") {
                alert("판매자를 입력해주세요");
                return;
            } else if (registC.sell_date.value == "") {
                alert("판매일자를 입력해주세요");
                return;
            } else if (!number.test(registC.sell_date.value)
                    || registC.sell_date.value.length != 8) {
                alert("판매일자를 제대로 입력해주세요");
                return;
            } else if (registC.telecom.value == "") {
                alert("통신사를 입력해주세요");
                return;
            } else if (registC.status.value == "") {
                alert("개통상태를 입력해주세요");
                return;
            }
            $(function () {
                var allInputData = $("#registCustomer").serialize();

                //ajax 실행            
                $.ajax({
                    type : 'POST',
                    url : 'ajax.jsp',
                    data : allInputData,
                    success : function (response) {
                         if (response.trim() === "success") {                             
                            alert("등록완료");
                            location.href="main.jsp?section=customer_list";
                        } else {
                            alert("문제가 계속된다면 관리자에게 문의하세요.");                            
                        } 
                    },
                    error : function (error) {
                        console.error('에러 발생:', error);
                    }
                });
            });

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
</script>