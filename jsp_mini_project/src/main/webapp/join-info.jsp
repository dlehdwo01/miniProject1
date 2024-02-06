<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>대리점::직원가입</title>

<style>
</style>
</head>

<body>
	<div id="container1" style="height: 600px">
		<div style="margin-bottom: 40px;">
			<h1>대리점::고객관리시스템</h1>
		</div>
		<div style="margin-bottom: 30px;">
			<h3>직원가입</h3>
		</div>
		<div style="margin-bottom: 40px;">아래 정보를 입력해주세요</div>
		<form name="join">
			<div style="position: relative; margin-top: 20px;">
				<input name="user_id" id="user_id" hidden="hidden" value="<%=request.getParameter("user_id")%>">
				<label>
					<span class="explainInput"> 비밀번호</span>
					<input class="inputInput" name="user_pwd" type="password" autofocus id="user_pwd">
				</label>
			</div>
			<div style="position: relative; margin-top: 20px;">
				<label>
					<span class="explainInput-in"> 비밀번호 확인</span>
					<input class="inputInput" name="user_pwdcheck" type="password" id="user_pwdCheck">
				</label>
			</div>
			<div style="position: relative; margin-top: 20px;">
				<label>
					<span class="explainInput-in"> 이름</span>
					<input class="inputInput" name="user_name" id="user_name">
				</label>
			</div>
			<div style="position: relative; margin-top: 20px;">
				<label>
					<span class="explainInput-in"> 휴대폰번호(-제외)</span>
					<input class="inputInput" name="user_phone" maxlength="11" id="user_phone">
				</label>
			</div>
			<div style="color: red; margin-top: 10px;" class='noInput'></div>
			<div class="join-next">
				<input class="prev buttonbox" type="button" value="뒤로" onclick='history.back()'>
				<input class="next buttonbox" type="button" value="다음" onclick="fn_join()">
			</div>
		</form>
	</div>
</body>

</html>
<script>
    $(function () {
        $(".inputInput").on("focus", function () {
            $(this).parent().find(".explainInput").animate({
                bottom : "43px",
                left : "20px",
                fontSize : "17px"
            }, 50)
        })
        $(".inputInput").on("blur", function () {
            if ($(this).val() == "") {
                $(this).parent().find(".explainInput").animate({
                    bottom : "15px",
                    left : "30px",
                    fontSize : "20px"
                }, 100)
            }
        })
        $(".inputInput").on("focus", function () {
            $(this).parent().find(".explainInput-in").animate({
                bottom : "43px",
                left : "20px",
                fontSize : "17px"
            }, 50)
        })
        $(".inputInput").on("blur", function () {
            if ($(this).val() == "") {
                $(this).parent().find(".explainInput-in").animate({
                    bottom : "15px",
                    left : "30px",
                    fontSize : "20px"
                }, 100)
            }
        })
    })
    
        $(function () {
        // Enter 키 이벤트 처리
        $('.inputInput').on('keypress', function (event) {
            if (event.which === 13) {
                fn_join();
            }
        });

    });
    
    function fn_vibrate(target) {
        target.classList.add("vibration");
        target.style.border= '1px solid red';
     setTimeout(function () {
        target.classList.remove("vibration");
        target.style.border= '1px solid #ccc';
    }, 300) ;
    }
    
    var join=document.join;
     function fn_join() {
         var userId =document.querySelector("#user_id").value;
        var userPwd =document.querySelector("#user_pwd").value;
        var userPwdCheck =document.querySelector("#user_pwdCheck").value;
        var userName =document.querySelector("#user_name").value;
        var userPhone =document.querySelector("#user_phone").value;
        
        if (join.user_pwd.value == "" || join.user_pwdCheck.value == "") {
            document.querySelector(".noInput").innerText ="비밀번호를 입력해주세요";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else if (join.user_pwd.value.length < 8
                || join.user_pwd.value.length > 20) {
            document.querySelector(".noInput").innerText ="비밀번호는 8자리 이상 20자리 미만으로 설정해주세요.";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else if (/[^a-zA-Z0-9]/g.test(join.user_pwd.value)) {
            document.querySelector(".noInput").innerText="비밀번호에 영문, 숫자 이외 입력은 불가능합니다.";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else if (join.user_pwd.value!=join.user_pwdCheck.value) {
            document.querySelector(".noInput").innerText="비밀번호가 서로 일치하지 않습니다.";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else if (join.user_name.value==  "") {
            document.querySelector(".noInput").innerText="이름을 입력해주세요.";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else if (/[^가-힣]/g.test(join.user_name.value)) {
            document.querySelector(".noInput").innerText="이름은 한글만 입력해주세요.";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else if (join.user_phone.value==  "") {
            document.querySelector(".noInput").innerText="휴대폰 번호를 입력해주세요.";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else if (join.user_phone.value.length!=11) {
            document.querySelector(".noInput").innerText="휴대폰 번호는 -제외 11자리를 입력해주세요.";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else if (/[^0-9]/g.test(join.user_phone.value)) {
            document.querySelector(".noInput").innerText="휴대폰 번호를 제대로 입력해주세요.";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } 
        else {

            //ajax 실행
            $.ajax({                
                type : 'POST',
                url : 'ajax.jsp',
                data : {
                    user_id : userId, 
                    user_pwd : userPwd,
                    user_name : userName,
                    user_phone : userPhone,                    
                    type : 'join'
                },
                success : function (response) {
                    if (response.trim() === 'success') {                        
                        location.href="join-success.jsp";
                        return;
                    } else {
                        $('.noId').text('오류 발생');
                        return;
                    }
                },
                error : function (error) {
                    console.error('에러 발생:', error);
                }
            });
        }
    } 
    
</script>