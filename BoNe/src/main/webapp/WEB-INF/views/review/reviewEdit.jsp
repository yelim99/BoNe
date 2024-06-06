<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- taglib functions -------------------------------------------- -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>

input, textarea {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 auto;
	width: 50%;
	padding: 10px;
	margin-bottom: 15px;
	border: 3px solid pink;
	border-radius: 6px;
}
.file {
	border:none;
}
textarea {
	height: 200px;
}

.btn-div,.input-div {
  	display: flex;
  	justify-content: center;
  	align-items: center;
	margin: 0 auto;	
}

.submit-button {
	padding: 10px 20px;
	text-align: center;
	background-color: #64CCC5;
	color: #fff;
	border: none;
	border-radius: 6px;
	margin-top: 50px;
	margin-bottom: 70px;
}

.submit-button:hover {
	background-color: #DAFFFB;	
}
.title{
	width: 100%;
	text-align: center;
	margin-top: 20px;
	font-size: 35px;
	font-weight: bold;
	color: #64CCC5;	
}
.title2 {
	width: 100%;
	padding-left: 25%;
	padding-bottom: 15px;
	font-size: 17px;
	font-weight: 600;
	color: #643843;
}

.image {
	width: 300px;
	height: 300px;
	border: 3px dashed pink;
	border-radius: 6px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 auto;
	margin-bottom: 10px;
	background-color: white;
}
.rounded {
	display: none; 
	max-width: 90%; 
	max-height: 90%; 
	height: auto;
}

input[type="file"] {
	width: 250px;
	text-align: center;
	align-items: center;
	margin-bottom: 100px;
}

.share, .stars {
	display: flex;
	justify-content: center;

	color: #E966A0;
	font-size: 12px;
	font-weight: bold;
	margin-bottom: 5px;
}
.form-control {
	width: 130px;
	border: 3px solid #FFD89C;
	border-radius: 4px;
}
.form-group {
	display: flex;
	justify-content: center;
	margin-bottom: 40px;
}
.big-box {
	justify-content: center;
  	align-items: center;
	margin: 0 auto;	
	margin-top: 100px;
	width: 800px;
	height: auto;
	padding-top: 50px;
	background-color: #ECF8F9;
	border-radius: 30px;
	border: 3px solid #B8DFD8;
}
</style>
<body>
	<div class="big-box">
	<div class="title" style="margin-top: 100px;">'${snickname}' 님과 함께하셨네요 !</div>
	<div class="title" style="margin-bottom: 100px;">어떠셨나요? 후기를 남겨주세요 ♥</div>

	<form action="${myctx}/updateReview" name="rb" id="rb" method="post" enctype="multipart/form-data">
		<input type="hidden" name="rno" value="${review.rno}" />
		<input type="hidden" name="snickname" value="${snickname}" />
		<div class="stars">만족하셨나요?</div>
		<div class="form-group">
			<select class="form-control" id="sel1" name="star">
				<option value="5">★★★★★</option>
				<option value="4">★★★★</option>
				<option value="3">★★★</option>
				<option value="2">★★</option>
				<option value="1">★</option>
			</select>
		</div>
	
		<div class="share">사진을 공유해주세요</div>
		<div class="image">
			<img class="rounded" id="preview" src="#" alt="Uploaded Image">
		</div>

		<div class="input-div">
			<input type="file" name="mfilename" id="filename" class="file" onchange="showPreview(event)" required>
		</div>

		<div class="title2">제목</div>
		<input type="text" id="title" name="title" value="${review.title}" required>
		
		<div class="title2">내용</div>
		<textarea id="content" name="content" required>${review.content}</textarea>

		<div class="btn-div">
			<button type="submit" class="submit-button">리뷰 수정</button>
		</div>
	</form>
	</div>
</body>

<script>

function showPreview(event) {
	var input = event.target;
	var preview = document.getElementById('preview');

	if (input.files && input.files[0]) {
		var reader = new FileReader();

    	reader.onload = function(e) { // 파일 읽기가 완료되었을 때 실행될 함수
      		preview.src = e.target.result;
      		preview.style.display = 'block';
    	};

    	reader.readAsDataURL(input.files[0]);
  	}
}

// 나중에 고치기 ***
 function showNotification() {
    alert("글이 등록되었습니다!");
}
  
  
</script>