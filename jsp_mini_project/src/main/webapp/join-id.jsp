<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<link rel="stylesheet" href="css.css">
<meta charset="UTF-8">
<title>대리점::직원가입</title>

<style>
.vibration {
	animation: vibration 0.1s infinite;
}

@
keyframes vibration {from { transform:rotate(1deg);
	
}

to {
	transform: rotate(-1deg);
}
}
</style>
</head>

<body>
	<div id="container1">
		<div style="margin-bottom: 40px;">
			<h1>대리점::고객관리시스템</h1>
		</div>
		<div style="margin-bottom: 30px;">
			<h3>직원가입</h3>
		</div>
		<div style="margin-bottom: 40px;">사용하실 아이디를 입력하세요</div>
		<form name="join" onsubmit="return false">
			<div style="position: relative;">
				<label>
					<span class="explainInput"> 아이디</span>
					<input class="inputInput" name="user_id" id="user_id">
				</label>
			</div>
			<div style="color: red; margin-top: 10px;" class='noId'></div>
			<div class="join-next">
				<input class="prev buttonbox" type="button" value="뒤로" onclick="history.back()">
				<input class="next buttonbox" type="button" value="다음" onclick="fn_idCheck()">
			</div>
		</form>
	</div>
</body>

</html>
<script>
    var join = document.join;

    $(function () {
        $(".inputInput").on("click", function () {
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
        });
    })
    $(function () {
        // Enter 키 이벤트 처리
        $('#user_id').on('keypress', function (event) {
            if (event.which === 13) {
                fn_idCheck();
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
    
     function fn_idCheck() {
        var userId =document.querySelector("#user_id").value;
        if (join.user_id.value == "") {
            document.querySelector(".noId").innerText ="아이디를 입력해주세요";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else if (join.user_id.value.length < 5
                || join.user_id.value.length > 16) {
            document.querySelector(".noId").innerText ="아이디는 5글자 이상 16글자 미만으로 입력해주세요";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else if (/[^a-zA-Z0-9]/g.test(join.user_id.value)) {
            document.querySelector(".noId").innerText="영문, 숫자 이외 입력은 불가능합니다.";
            fn_vibrate(document.querySelector("#container1"));            
            return;
        } else {

            //ajax 실행
            $.ajax({                
                type : 'POST',
                url : 'ajax.jsp', // checkUsername.jsp 파일의 경로
                data : {
                    user_id : userId, type : 'join'
                },
                success : function (response) {
                    if (response.trim() === 'taken') {
                        $('.noId').text('이미 사용 중인 아이디입니다.');
                        $("#container1").addClass("vibration");
                        $("#container1").css("border",'1px solid red');
                        setTimeout(function () {
                            $("#container1").removeClass("vibration");
                            $("#container1").css("border",'1px solid #ccc');
                        }, 300);                        
                        return;
                    } else if (response.trim() === 'available') {
                        location.href = "join-info.jsp?user_id=" + userId;
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