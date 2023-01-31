<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<h2>commentTest</h2>
comment: <input type="text" name="comment"><br>
<button id="sendBtn" type="button">SEND</button>
<button id="modBtn" type="button">수정</button>
<div id="commentList"></div>
<div id="replyForm" style="display:none">
    <input type="text" name="replyComment"/>
    <button id="wrtRepBtn" type="button">등록</button>
</div>
<script>
    let bno = 1715;
    let showList = function(bno){
        $.ajax({
            type:'GET',       // 요청 메서드
            url: '/ch4/comments?bno=' +bno,  // 요청 URI
            success : function(result){
                $("#commentList").html(toHtml(result)); //서버로부터 응답이 도착하면 호출될 함수
            },
            error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        }); // $.ajax()

    }

    $(document).ready(function(){
            showList(bno);

        //수정
        $("#commentList").on("click", ".modBtn", function() {
            let cno = $(this).parent().attr("data-cno");

            let comment = $("span.comment", $(this).parent()).text();

            //1. comment의 내용을 input에 뿌려주기
            $("input[name=comment]").val(comment);
            //2. cno전달하기
            $("#modBtn").attr("data-cno", cno);
        });
        $("#modBtn").click(function(){

            let cno = $(this).attr("data-cno");
            let comment = $("input[name=comment]").val();

            if(comment.trim()==''){
                alert("댓글을 입력해주세요");
                $("input[name=comment]").focus()
                return
            }
            $.ajax({
                type:'PATCH',       // 요청 메서드
                url: '/ch4/comments/'+cno,  // 요청 URI /ch4/comments/10
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({cno:cno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert("result ="+result);       // result는 서버가 전송한 데이터
                    showList(bno);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        });



        //send에 click이벤트 걸고
        $("#sendBtn").click(function(){

            let comment = $("input[name=comment]").val();
            if(comment.trim()==''){
                alert("댓글을 입력해주세요");
                $("input[name=comment]").focus()
                return
            }
            $.ajax({
                type:'POST',       // 요청 메서드
                url: '/ch4/comments?bno='+bno,  // 요청 URI /ch4/comments?bno=1085
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert("result ="+result);       // result는 서버가 전송한 데이터
            showList(bno); //showList를 요청했지만 결과는 아직 오지 않은 상태에서 아래의 삭제이벤트 실행, 이벤트가 걸리지 않게 됨
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        });

        //답글등록
        $("#wrtRepBtn").click(function(){

            let comment = $("input[name=replyComment]").val();
            let pcno = $("#replyForm").parent().attr("data-pcno"); //답글의 부모
            if(comment.trim()==''){
                alert("댓글을 입력해주세요");
                $("input[name=comment]").focus()
                return
            }
            $.ajax({
                type:'POST',       // 요청 메서드
                url: '/ch4/comments?bno='+bno,  // 요청 URI /ch4/comments?bno=1085
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert("result ="+result);       // result는 서버가 전송한 데이터
                    showList(bno); //showList를 요청했지만 결과는 아직 오지 않은 상태에서 아래의 삭제이벤트 실행, 이벤트가 걸리지 않게 됨
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
            $("#replyForm").css("display", "none");
            $("input[name=replyComment]").val('')
            $("#replyForm").appendTo("body");
        });

        //대댓글(답글)
        $("#commentList").on("click", ".replyBtn", function(){
            //1. replyForm을 옮기고
            $("#replyForm").appendTo($(this).parent());
            //2. 답글을 입력할 폼을 보여주고,
            $("#replyForm").css("display", "block");

        });


        //삭제
        //삭제버튼에 이벤트를 거는데??!?
        //ajax는 비동기 방식이라 요청을 한 다음 결과가 오기전에 이 함수들이 실행됨 따라서 alert창이 보여지지 않음
        //이 경우에는 고정된 요소에 이벤트를 걸어줘야한다
        // $(".delBtn").click(function(){
        $("#commentList").on("click", ".delBtn", function(){ //commentList안에 있는 delBtn에다가 click이벤트를 검(동적으로 생성되는 요소에 이벤트)
            let cno = $(this).parent().attr("data-cno");
            let bno = $(this).parent().attr("data-bno");
            $.ajax({
                type:'DELETE', //요청메서드
                url : '/ch4/comments/'+cno+'?bno='+bno, //요청 URI
                success : function(result){
                    alert(result)
                    showList(bno); //삭제한 후 목록 갱신을 위해
                },
                error : function(){alert("error")} //에러가 발생했을 때, 호출될 함수
            }); //$.ajax()
        });


    });

    //comments라는 배열이 들어온 것을 li태그를 이용해 ul을 구성한 다음 넣을 것임
    let toHtml = function(comments){
        let tmp = "<ul>";

        comments.forEach(function(comment){
            tmp += '<li data-cno='+comment.cno //댓글번호
            tmp += ' data-pcno='+comment.pcno //부모댓글 번호
            tmp += ' data-bno=' +comment.bno + '>'
            if(comment.cno!=comment.pcno)
                tmp += 'ㄴ'
            tmp += ' commenter=<span class="commenter">' + comment.commenter + '</span>' //span을 넣어야 작성자만 읽어올 때 편리
            tmp += ' comment=<span class="comment">' + comment.comment + '</span>'
            tmp += ' up_date=' + comment.up_date
            tmp += '<button class="delBtn">삭제</button>'
            tmp += '<button class="modBtn">수정</button>'
            tmp += '<button class="replyBtn">답글</button>'
            tmp += '</li>'
        })
        return tmp + "</ul>";
    }


</script>
</body>
</html>