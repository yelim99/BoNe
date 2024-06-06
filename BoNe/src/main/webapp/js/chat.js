/**
 * 
 */
 
let win = null;
function open_chat() {
	win = window.open("../chat", "chat", "width=400, height=400, letf=200, top=200");
		
} //------------------------------
 	
	var stompClient = null;
    
    function setConnected(connected) {
        document.getElementById('connect').disabled = connected;
        document.getElementById('disconnect').disabled = !connected;
        document.getElementById('conversationDiv').style.visibility 
          = connected ? 'visible' : 'hidden';
        document.getElementById('response').innerHTML = '';
    }
    
    function connect() {
        var socket = new SockJS('${pageContext.request.contextPath}/chat');
        stompClient = Stomp.over(socket);  
        stompClient.connect({}, function(frame) {
        	console.log("frame==="+frame)
            setConnected(true);
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/messages', function(messageOutput) {
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
        stompClient.send("/app/chat", {}, //prefix를 /app으로 지정합=>WebSocketConfigure에서 
          JSON.stringify({'from':from, 'text':text}));
        $('#text').val('')
    }
    
    function showMessageOutput(messageOutput) {
        var response = document.getElementById('response');
        var p = document.createElement('p');
        p.style.wordWrap = 'break-word';
        p.appendChild(document.createTextNode(messageOutput.from + ": " 
          + messageOutput.text + " (" + messageOutput.time + ")"));
        response.appendChild(p);
    }