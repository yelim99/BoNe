<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
$(function() {
	
	// 빈 하트 누르면 빨간하트로, 빨간하트 한번 더 누르면 빈 하트로 바뀜
	// 찜 목록에 반영해야 함
	$('.heart').click(function() {
		
		let ino = $(this).attr('id');
		// 로그인 체크 해서 unickname 넘겨줘야 할 듯.
		
		console.log("heart-click");
		
		if ($(this).attr('src') == "${myctx}/images/heart.png") {
			console.log("빈 하트 클릭"+ino);
			
			$.ajax({
				url:'heart.do',
				type:'get',
				data:{ino:ino},
				success: function(res){
					// alert(JSON.stringify(res));
					if(res.result>0){
						console.log("찜 추가 성공");
					}
					
				},
				error: function(err){
					alert('error: '+err.status);
				}
				
			});
			// 꽉 찬 하트로 이미지 변경
			$(this).attr("src", "${myctx}/images/full_heart.png");
			
		}
		else {
			console.log("꽉 찬 하트 클릭"+ino);
			
			$.ajax({
				url:'removeHeart.do',
				type:'get',
				data:{ino:ino},
				success:function(res){
					// alert(JSON.stringify(res));
					if(res.result>0){
						console.log("찜 삭제 성공");
					}
				},
				error: function(err){
					alert('error: '+err.status);
				}
			});
			// 빈 하트로 이미지 변경
			$(this).attr("src", "${myctx}/images/heart.png");
			
		}
		
	})
	
})
</script>

<script type="text/javascript">
	let win = null;
	function open_chat() {
		win = window.open("${myctx}/room", "room", "width=450, height=500, left=200, top=200");
		// var url='${myctx}/chat?unickname='+value;
		// win = window.open(url, "chat", "width=400, height=440, left=300, top=200");
	} 
</script>

<style>
.t1{
	margin-bottom:100px;
	text-align:center;
	padding:30px;
	font-family: 'omyu_pretty';
	font-size: 1.25em;
}
.t2{
	background-color:rgb(255, 251, 224);
	padding:20px;
	text-align:left;
	height:300px;
	width:49%;
	float:left;
	border-radius:20px;
	margin-bottom: 30px;
}
.t3{
	background-color:rgb(243, 232, 166);
	padding:20px;
	text-align:left;
	height:300px;
	width:49%;
	float:right;
	border-radius:20px;
	margin-bottom: 30px;
}

.t2, .t3, .t4, .t5 {
		overflow-y: scroll;
		-ms-overflow-style: none; /* 인터넷 익스플로러 */
		scrollbar-width: none; /* 파이어폭스 */
	}
	
.t2::-webkit-scrollbar {
	    display: none; /* 크롬, 사파리, 오페라, 엣지 */
	}
	
.t3::-webkit-scrollbar {
	    display: none; /* 크롬, 사파리, 오페라, 엣지 */
	}
	
.t4::-webkit-scrollbar {
	    display: none; /* 크롬, 사파리, 오페라, 엣지 */
	}
	
.t5::-webkit-scrollbar {
	    display: none; /* 크롬, 사파리, 오페라, 엣지 */
	}

.t4{
	background-color:rgb(243, 232, 166);
	padding:20px;
	text-align:left;
	height:300px;
	width:49%;
	float:left;
	border-radius:20px;
	margin-bottom: 30px;
}
.t5{
	background-color:rgb(255, 251, 224);
	padding:20px;
	text-align:left;
	height:300px;
	width:49%;
	float:right;
	border-radius:20px;
	margin-bottom: 30px;
}
.t6{
	clear: both;
	background-color:rgb(255, 251, 224);
	padding:20px;
	text-align:left;
	height:250px;
	margin-bottom:30px;
	border-radius:20px;
	
}

a{
	float:right;
	color:inherit;
}
.i1{
	height:150px;
	width:100%;
	float:left;
	margin-right:20px;
	clear:both;
	background-color:gray;
	padding: 50%;
}

.i2{
	height:160px;
	width:320px;
	float:left;
	margin-left: 20px;
	margin-right:15px;
	clear:both;
	/* background-color:gray; */
	display: inline-block;
}


.i2 img { width: 150px; }

.i3{
	height:100%;
	width:150px;
	float:left;
	margin-right:40px;
	clear:both;
	background-color:gray;
	display: inline-block;
}


span.ingredient {
    color: #f00;
}  
/* .map-frame{
  text-align: center;
  margin: 50px 0;
} */

.map-content{
  width:35%;
  margin: auto;
  border-radius:10px;
  overflow: hidden;
}

.addrInfo { float:left; }
.addrInfo input { margin-top: 8px; padding: 5px; margin-right: 13px;}
.addrInfo button { float:right; margin-top: 8px; }

#reviewbtn { padding: 3px; font-size: 0.9em; }

#petT {
	/* line-height: 0.3; */
	font-size: 0.9em;
}
#petT td { padding: 3px; }
#petT .r {
	text-align: center;
	font-weight: bold;	
}
#petT .p {
	padding-left: 2px;
}

#pimg { width: 100%; }

.heart { width: 20px; }

#wishT td {padding: 3px;}

#usedC { color: #5D5D5D; font-weight: bold; }

#usedT { margin-top: 10px; }
#usedT td { padding: 5px; }


.nick a { width: 100%; margin: 0 auto; }

#menu { font-family: 'KOTRAHOPE'; font-size:2.2em; }

.row {
	height: 50px;
	padding-top: 9px;
}

.review {
	float:left;
}
.review:hover {
	text-decoration: none;
	color: black;
	font-weight: bold;
}
.name, .wdate {
	text-align: center;
}
div.text-center {
	color: #5D5D5D; 
	font-weight: bold; 
}

#rdiv a { width: 100%; margin: 0 auto; text-align: center; }

#open_c:hover { cursor: pointer; font-weight:bold; }
#open_c { float: left; }
</style>

<div class="t1">
	<div align="center" class="col-md-8 offset-md-2 my-4" >
		<h2 id="menu">'${loginUser.nickname}'님 마이페이지 </h2>
	</div>
	
<!-- 	<div class="nick" onclick="open_chat()" id="open_c">
	 	채팅하기
	 </div> -->
	
	<a href="${myctx}/general/user/editG">회원정보수정</a>
	<br><br>

	<div class="t2">
		<table class="table table-borderless" id="petT">
			<tr>
				<td colspan="2" style="font-size: 1.1em;"><b>내 반려동물 정보</b></td>
				<td style="vertical-align: middle;"><a href="${myctx}/general/user/petinfo">더보기</a></td>
			</tr>
			<c:if test="${mypet eq null}">
				<tr>
					<td> 반려동물 정보가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${mypet ne null}">
				<tr>
					<td></td>
					<td style="width: 20%;" class="r">이름</td>
					<td style="width: 40%;" class="p">${mypet.pname}</td>
				</tr>
				<tr>
					<td rowspan="5" style="width: 40%;">
						<img id="pimg" src="${myctx}/resources/pet_upload/${mypet.image}" onerror="this.style.display='none'">
					</td>
					<td class="r">종류</td>
					<td class="p">${mypet.species1}</td>
				</tr>
				<tr>
					<td class="r">세부 종</td>
					<td class="p">${mypet.species2}</td>
				</tr>
				<tr>
					<td class="r">성별</td>
					<td class="p">${mypet.gender}</td>
				</tr>
				<tr>
					<td class="r">생년월일</td>
					<td class="p">${mypet.bday}</td>
				</tr>
				<tr>
					<td class="r">몸무게</td>
					<td class="p">${mypet.weight} kg</td>
				</tr>
				<tr>
					<td></td>
					<td style="width: 20%;" class="r">특이사항</td>
					<td colspan="2" style="width: 80%;" class="p">${mypet.particulars}</td>
				</tr>
			</c:if>
		</table>
	</div>
		
	<div class="t3">
		<b style="font-size: 1.1em;">찜 목록</b>
		<br>
		<!-- 찜 개수 만큼 반복문 돌기 -->
		
		<c:forEach var="wish" items="${wishList}">
			<div class="wish" style="clear:both;">
				<table class="table table-borderless" id="wishT">
					<tr>
						<td rowspan="2" style="width: 5%;">
							
							<c:if test="${wish.unickname eq loginUser.nickname}">
								<img src="${myctx}/images/full_heart.png" class="heart" id="${wish.ino}" style="width: 25px">
							</c:if>
							<c:if test="${wish.unickname ne loginUser.nickname}">
								<img src="${myctx}/images/heart.png" class="heart" id="${wish.ino}" style="width: 25px">
							</c:if>
						</td>
						<td rowspan="2" style="width: 27%;">
							<div class="nick">
								<a href="${myctx}/shop/info/<c:out value="${wish.ino}"/>"><b>${wish.snickname}</b></a>
							</div>
						</td>
						<td>${wish.title}</td>
					</tr>
					<tr>
						<td style="width: 68%">${wish.saddr}</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="ino" value="${wish.ino}">
		</c:forEach>
	</div>


	<div class="t4">
		<b  style="font-size: 1.1em;">이용 내역 및 리뷰</b>
		<div class="used" style="clear:both; font-size:1em; margin-left:10px; ">

			<table class="table table-borderless text-center" id="usedT">
				<tr>
					<td id="usedC">펫시터 닉네임</td>
					<td id="usedC">시작 날짜 ~ 끝 날짜</td>
					<td></td>
				</tr>
				<c:forEach var="item" items="${used}">
					<tr>
						<td style="width:30%">
								${item.snickname} 님
						</td>
						<td style="width:45%">
							<fmt:formatDate value="${item.sdate}" pattern="YY.MM.dd"/>				
						 ~ <fmt:formatDate value="${item.fdate}" pattern="YY.MM.dd"/>
						</td>
						<td>
							<form action="${myctx}/general/user/reviewBoardWrite" name="wf" id="wf" method="post">
								<input type="hidden" name="snickname" value="${item.snickname}"/>
								<button class="btn btn-outline-dark" style="padding: 5px; font-size: 0.9em;">리뷰 쓰기</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			
			</table>
		</div>
	
	</div>
	
	<!-- --------------------------- 내가 쓴 리뷰 --------------------- -->
	<div class="t5">
		<b>내가 쓴 리뷰</b>
		<div class="container">
            <div class="row" style="margin-top: 10px;">
                <div class="col-4 text-center">펫시터 닉네임</div>
                <div class="col-5 text-center">제목</div>
                <div class="col-3 text-center">작성일</div>
            </div>
			
			<c:forEach var="reviewBoard" items="${reviewBoard}" varStatus="status">
	            <div class="row">
	                <div class="col-4 col1 name">${snicknames[status.index]} 님</div>
	                <div class="col-5 col1" id="rdiv">
	                	<a href="${myctx}/reviewBig?rno=${reviewBoard.rno}" class="review">${reviewBoard.title}</a>
	                </div>
	                <div class="col-3 col1 wdate">${reviewBoard.wdate}</div>
		        </div>
	        </c:forEach>
		</div>
	</div>
	
	<c:if test="${loginUser.kakao eq null}">
		<div>
			 <a href="javascript:kakaoPlus();">
			 	<img id="kakaoPlus" src="${myctx}/images/kakaoPlus.png" style="width: 200px;" class="rounded">
			 </a>
		</div>
	</c:if>
	

</div>
<div style="clear:both; margin-bottom:50px"></div>


<script>
var myctx = "${myctx}";

// 사용할 앱의 JavaScript 키
window.Kakao.init('95783301fd03fa983b31d7af57a434b2');

function kakaoPlus() {
    window.Kakao.Auth.login({
        scope: 'profile_nickname, account_email',
        success: function(response) {
            console.log(response) // 로그인 성공하면 받아오는 데이터
            window.Kakao.API.request({ // 사용자 정보 가져오기 
                url: '/v2/user/me',
                success : function(res) {
                    const kakao_account = res.kakao_account;
                    const user_email = kakao_account.email;
                    
                 	// POST 요청을 보낼 데이터
                    var data = {"email": user_email};
           
                	 // AJAX 요청 보내기
                    $.ajax({
                        url: 'kakaoPlus',
                        type: 'POST',
                        contentType: 'application/json',
                        dataType:'json',
                        data: JSON.stringify(data),
                        cache:false,
                        success: function(response) {
                        	// 서버로부터 받은 응답 처리
                            if (response.msg) {
                                alert(response.msg);
                            }
                            if (response.loc) {
                                window.location.href = myctx + response.loc;
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                        	if (jqXHR.status === 400) {
                                alert('이미 등록된 카카오 계정입니다.!!!!'); // 이미 등록된 계정이라면 에러 메시지를 보여줌
                            } else {
                                alert('오류가 발생했습니다.');
                            }
                            console.error('Error:', textStatus, errorThrown);
                        }
                    });
            
                }
            });
        },
        fail: function(error) {
            console.log(error);
        }
    });
}


</script>