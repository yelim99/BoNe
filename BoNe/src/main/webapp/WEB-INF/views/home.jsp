<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.explain {
	margin-top: 100px; 
	margin-left : 100px;
	display: flex;
	margin-left: 100px;
}

.e-title {
	font-weight: bold;
	font-size: 20px;
}

.pic {
	margin-left: 100px;
}

.explain-1 {
	margin-top: 100px;
	margin-bottom: 100px;
	white-space: nowrap;
}

.main_pic {
	width: 300px;
}

.review-more {
	margin-top: 100px;
	display: flex;

}

.review {
	margin-left: 100px;
	font-size: 20px;
	font-weight: bold;
	width: 20%;
}

.more {
	margin-left: 800px;
}
</style>

<div class="explain">
	<div class="explain-1">
		<div class="e-title">(사이트 이름) 이란?</div>
		<div>혼자 지낼 반려동물, 많이 걱정되시죠?</div>
		<div>이젠 걱정하지 말고, 믿고 맡길 수 있는 펫시터를 찾아보세요 !</div>
	</div>
	<div class="pic">
		<img src="${myctx}/images/main_pic.png" alt="main_pic"
			class="main_pic">
	</div>
</div>

<div class="review-more">
	<div class="review">이용 후기</div>
	<div class="more"><a href="${myctx}/main/reviewBoard">더보기</a></div>
</div>

