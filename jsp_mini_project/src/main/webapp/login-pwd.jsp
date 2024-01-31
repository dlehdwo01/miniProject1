<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>대리점::직원로그인</title>
</head>
<body>
	<div id="container1">
		<div style="margin-bottom: 40px;">
			<h1>대리점::고객관리시스템</h1>
		</div>
		<div style="margin-bottom: 30px;">
			<h3>로그인</h3>
		</div>
		<div style="margin-bottom: 40px;">비밀번호를 입력해주세요.</div>

		<form name="login" onsubmit="return false">
			<div style="position: relative;">
				<label>
					<span class="explainInput"> 비밀번호</span>
					<input name="user_id" id="user_id" hidden value="<%=request.getParameter("user_id")%>">
					<input class="inputInput" name="user_pwd" id="user_pwd" type="password" autofocus>
				</label>
			</div>
			<div style="color: red; margin-top: 10px;" class='noId'></div>
			<div class="join-next">
				<input class="next buttonbox" type="button" value="다음" onclick="fn_login()">
			</div>
		</form>
	</div>
</body>

</html>
<script>
    var login = document.login;

    $(function () {
        $(".inputInput").on("focus", function () {
            $(".explainInput").animate({
                bottom : "43px",
                left : "20px",
                fontSize : "17px"
            }, 50)
        })
        $(".inputInput").on("blur", function () {
            if ($(this).val() == "") {
                $(".explainInput").animate({
                    bottom : "15px",
                    left : "30px",
                    fontSize : "20px"
                }, 100)
            }
        })
    })
    // 아이디 오입력시 애니메이션
    function fn_vibrate(target) {
        target.classList.add("vibration");
        target.style.border = '1px solid red';
        setTimeout(function () {
            target.classList.remove("vibration");
            target.style.border = '1px solid #ccc';
        }, 300);
    }

    // Enter 키 이벤트 처리
    $(function () {
        $('#user_pwd').on('keypress', function (event) {
            if (event.which === 13) {
                fn_login();
            }
        });

    });

    // 아이디 대조
    function fn_login() {
        var userId = document.querySelector("#user_id").value;
        var userPwd = document.querySelector("#user_pwd").value;
        if (login.user_id.value == "") {
            document.querySelector(".noId").innerText = "비밀번호를 입력해주세요";
            fn_vibrate(document.querySelector("#container1"));
            return;
        } else {

            //ajax 실행
            $.ajax({
                type : 'POST',
                url : 'ajax.jsp',
                data : {
                    user_id : userId,
                    user_pwd : userPwd,
                    type : 'login-pwd'
                },
                success : function (response) {
                    if (response.trim() === 'success') {
                        location.href = "main.jsp";
                        return;
                    } else if (response.trim() === 'failed') {
                        $('.noId').text('비밀번호가 일치하지 않습니다.');
                        $("#container1").addClass("vibration");
                        $("#container1").css("border", '1px solid red');
                        setTimeout(function () {
                            $("#container1").removeClass("vibration");
                            $("#container1").css("border", '1px solid #ccc');
                        }, 300);
                        return;
                    } else {
                        $('.noId').text('오류 발생');
                    }
                },
                error : function (error) {
                    console.error('에러 발생:', error);
                }
            });
        }
    }
</script>