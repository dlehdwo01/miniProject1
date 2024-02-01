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
}

</style>
</head>
<body>
	<%@ include file="db/dbconn.jsp"%>
	<div id="section-contents" style="height: 700px;">
		<h1>고객등록</h1>
		<div>asdf</div>
		<div id="container1" style="height: 400px; width: 250px; margin: 0px; position: static; padding: 30px; background-color: white; text-align: left; float: left; margin-right: 30px;">
			<div class="inputBOX">
				<label>
					<span class="explainInput"> 고객명</span>
					<input class="inputInput" name="cus_name" id="cus_name" autofocus>
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 생년월일</span>
					<input class="inputInput" name="cus_birth" id="cus_birth" autofocus>
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 휴대폰번호</span>
					<input class="inputInput" name="cus_phone" id="cus_phone" autofocus>
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 주소</span>
					<input class="inputInput" name="cus_addr" id="cus_addr" autofocus>
				</label>
			</div>

		</div>
		<div id="container1" style="height: 400px; width: 250px; margin: 0px; position: static; padding: 30px; background-color: white; text-align: left; float: left; margin-right: 30px;">
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 개통모델</span>
					<input class="inputInput" name="product_no" id="product_no" autofocus>
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 일련번호</span>
					<input class="inputInput" name="product_pkno" id="product_pkno" autofocus>
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 개통일자</span>
					<input class="inputInput" name="sell_date" id="sell_date" autofocus>
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 판매자</span>
					<input class="inputInput" name="sales_name" id="sales_name" autofocus>
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 통신사</span>
					<input class="inputInput" name="telecom" id="telecom" autofocus>
				</label>
			</div>
		</div>
		<div id="container1" style="height: 400px; width: 250px; margin: 0px; position: static; padding: 30px; background-color: white; text-align: left; float: left; margin-right: 30px;">
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"></span>
					<input class="inputInput" name="product_no" id="product_no" disabled placeholder="색상" style="font-size: 15px; color: dimgray;">
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 가격</span>
					<input class="inputInput" name="product_pkno" id="product_pkno" autofocus>
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 공시지원금</span>
					<input class="inputInput" name="sell_date" id="sell_date" autofocus>
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 요금제</span>
					<input class="inputInput" name="sales_name" id="sales_name" autofocus>
				</label>
			</div>
			<div class="inputBOX">
				<label>
					<span class="explainInput-in"> 지원금액</span>
					<input class="inputInput" name="telecom" id="telecom" autofocus>
				</label>
			</div>
		</div>
		<div id="container1" style="height: 400px; width: 600px; margin: 0px; position: static; padding: 30px; background-color: white; text-align: left; float: left; margin-right: 30px;">
		<div></div>
		
		</div>
	</div>


</body>

</html>
<script>
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