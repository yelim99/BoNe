<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<style>
	.jumbotron, .navbar, footer {
		display: none;
	}
</style>

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/sockjs.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/stomp.min.js"></script>
	
<%-- <script type="text/javascript" src="${myctx}/js/chat.js"></script> --%>

<script type="text/javascript">
	
	var stompClient = null;
    
    function setConnected(connected) {
        /* document.getElementById('connect').disabled = connected;
        document.getElementById('disconnect').disabled = !connected; */
        document.getElementById('conversationDiv').style.visibility 
          = connected ? 'visible' : 'hidden';
        document.getElementById('response').innerHTML = '';
    }
    
    function connect() {
        var socket = new SockJS('${pageContext.request.contextPath}/chat');
        var roomId = document.getElementById('roomId').value;
        stompClient = Stomp.over(socket);  
        stompClient.connect({}, function(frame) {
        	console.log("frame==="+frame)
            setConnected(true);
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/rooms/'+roomId, function(messageOutput) {
                console.log('messageOutput.body: '+messageOutput.body);
            	showMessageOutput(JSON.parse(messageOutput.body));
            });
        });
    }
    
    function disconnect() {
        if(stompClient != null) {
            stompClient.disconnect();
        }
        setConnected(false);
        console.log("Disconnected");
    }
    
    function send(){
    	//console.log(event.keyCode)
    	if(event.keyCode==13){
    		sendMessage();
    	}
    	
    }
    
  //https://tecoble.techcourse.co.kr/post/2021-09-05-web-socket-practice/ ==>참고하여 방만들기도 적용해보기
    function sendMessage() {
        var from = document.getElementById('from').value;
        var text = document.getElementById('text').value;
       	var roomId = document.getElementById('roomId').value;
       	var nick2 = document.getElementById('nick2').value;
       	
        stompClient.send("/app/chat/"+roomId, {}, //prefix를 /app으로 지정합=>WebSocketConfigure에서 
          JSON.stringify({'roomId':roomId, 'message':text, 'sender_nick':from, 'nick2':nick2}));
        $('#text').val('')
    }
  
    function showMessageOutput(messageOutput) {
    	var from = document.getElementById('from').value;
    	var loginNick = document.getElementById('loginNick').value;
    	var sender = String(messageOutput.from);
    	
    	// console.log("loginNick: "+loginNick);
    	// console.log("sender: "+sender);
    	
        var response = document.getElementById('response');
        var cbox = document.getElementById('convBox');
        var div = document.createElement('div');
        div.className = 'message';
        
        var pSender = document.createElement('p');
        if (sender === loginNick) {
        	pSender.id = 'sender';
        } else {
        	pSender.id = 'receiver';
        }
        
        pSender.appendChild(document.createTextNode(messageOutput.from));
        
        var messageDiv = document.createElement('div');
        var pMessage = document.createElement('p');
        
        if (sender === loginNick) {
            div.id = 'mychat_right';
            pMessage.id = 'smsg';
        } else {
            div.id = 'chat_left';
            pMessage.id = 'rmsg';
        }
        
        pMessage.appendChild(document.createTextNode(messageOutput.text));
        
        var pDate = document.createElement('p');
        
        if (sender === loginNick) {
            pDate.id = 'sdate';
        } else {
            pDate.id = 'rdate';
        }
        
        pDate.appendChild(document.createTextNode(messageOutput.time));
        
        messageDiv.appendChild(pSender);
        messageDiv.appendChild(pMessage);
        messageDiv.appendChild(pDate);
        
        div.appendChild(messageDiv);
        
        response.appendChild(div);
        
        // 스크롤을 맨 아래로 이동 (새 메시지가 보이도록)
        cbox.scrollTop = cbox.scrollHeight;
    }	
   
</script>

<style>
	
	body { 
		background-color: #C4DFDF;
		font-family: 'omyu_pretty';
	}
	
	#chatBox {
		width: 95%;
		height: 95%;
		margin: 0 auto;
		border-radius: 5px;
		padding: 20px;
	}
	
	#text {
		width: 80%;
		padding: 4px;
	}
	
	#sendMessage {
		padding: 6px 10px;
		margin-bottom: 4px;
	}
	
	#convBox {
		width: 100%;
		height: 400px;
		margin: 20px auto;
		border: 1px solid white;
		border-radius: 10px;
		overflow: auto;
	}
	
	#who {
		width: 70%; 
		padding: 5px;
		background-color: white; 
		margin: 0 auto; 
		border-radius: 10px;
	}
	
	.message {
        clear: both; /* 각 메시지 아래로 정렬되도록 설정 */
        margin-bottom: 10px; /* 각 메시지 사이에 간격 추가 */
        padding: 5px;
        border-radius: 10px;
        max-width: 70%; /* 메시지의 최대 너비 설정 (선택사항) */
    }
	
	#chat_left {
		float: left;
		width: 40%;
		margin-left: 5px;
	}
	
	#mychat_right {
		float: right;
		width: 40%;
		margin-right: 5px;
	}
	
	#sender { text-align: right; margin-bottom: 0; }
	
	#smsg {
		background-color: #EFEFEF;
		border-radius: 10px;
		margin-bottom: 0;
	}
	
	#sdate { text-align: right; }
	
	#receiver { text-align: left; margin-bottom: 0; }
	
	#rmsg {
		background-color: #E3F4F4;
		border-radius: 10px;
		margin-bottom: 0;
	}
	
	#rdate { text-align: left; }
	
	#home {
		width: 5%;
		float: left;
		margin-top: 20px;
		margin-left: 10px;
		font-size: 1.8em;
	}
	
	#home:hover { cursor: pointer; }
</style>


<body onload="connect()">

	<div id="home" onclick="javascript:history.back()">
		⬅️
	</div>

	<div id="chatBox" class="text-center">
		<div id="who">
			<h3 style="font-family: 'omyu_pretty';"><b>${cmessage.nick2}</b> 님과 채팅</h3>
		</div>
		<div>
			<input type="hidden" id="from" class="form-control" value="${cmessage.sender_nick}" readonly />
		</div>

		<div id="conversationDiv">
			<div id="convBox">
				<c:if test="${cHistory eq null}">
				</c:if>
				
				<c:if test="${cHistory ne null}">
					<c:forEach var="item" items="${cHistory}">
						<c:if test="${item.sender_nick eq loginNick}">
							<div class="message" id="mychat_right">
								<p id="sender">${item.sender_nick}</p>
								<div id="smsg">
									${item.message}
								</div>
								<p id="sdate">${item.mdate}</p>
							</div>
						</c:if>
						
						<c:if test="${item.sender_nick ne loginNick}">
							<div class="message" id="chat_left">
								<p id="receiver">${item.sender_nick}</p>
								<div id="rmsg">
									${item.message}
								</div>
								<p id="rdate">${item.mdate}</p>
							</div>
						</c:if>
						
					</c:forEach>
				</c:if>
				<p id="response"></p>
			</div>
		
			<input type="text" id="text" placeholder="메시지를 입력하세요."
				onkeydown="send()" />
			<button id="sendMessage" class="btn btn-primary" onclick="sendMessage();">전송</button>
			
		</div>

	</div>
	
	<input type="hidden" id="roomId" value="${roomId}">
	<input type="hidden" id="nick2" value="${cmessage.nick2}">
	<input type="hidden" id="mdate" value="${cmessage.mdate}">
	<input type="hidden" id="loginNick" value="${loginNick}">
	

</body>