package com.chat.app;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

//https://dev-gorany.tistory.com/235
@Configuration
@EnableWebSocketMessageBroker //WebSocket 메시지 처리를 활성화시킴
public class WebSocketConfig  implements WebSocketMessageBrokerConfigurer{ //extends AbstractWebSocketMessageBrokerConfigurer {

	@Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/topic");
        config.setApplicationDestinationPrefixes("/app");
        //메시지 보낼때 붙여야하는 prefix를 /app으로 지정함
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/chat").setAllowedOrigins("*");
         registry.addEndpoint("/chat").withSockJS();
    }
}