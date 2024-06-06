package com.user.service;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.MailException;
import org.springframework.mail.MailParseException;
import org.springframework.mail.MailSendException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.user.mapper.UserMapper;
import com.user.model.NotUserException;
import com.user.model.UserVO;

/* 회원가입 관련 서비스 임플 */

@Service("userService")
public class UserServiceImpl implements UserService {

	@Inject
	private UserMapper userMapper;
	
	@Inject
	private BCryptPasswordEncoder passwordEncoder;
	
	@Inject
	private JavaMailSender mailSender;
	
	@Resource(name="GeneralService")
	private GeneralService service;
	
	@Override
	public int createUser(UserVO user) {
		user.setPwd(passwordEncoder.encode(user.getPwd()));
		return this.userMapper.createUser(user);
	}
	@Override
	public int createUserS(UserVO user) {
		user.setPwd(passwordEncoder.encode(user.getPwd()));
		return this.userMapper.createUserS(user);
	}

	@Override
	public boolean idCheck(String mid) {
		Integer idx = userMapper.idCheck(mid);
		System.out.println("idx: "+idx);
		if (idx == null) return true;
		
		return false;
	}
	@Override
	public boolean nickCheck(String nickname) {
		Integer idx = userMapper.nickCheck(nickname);
		System.out.println("idx: "+idx);
		if (idx == null) return true;
		
		return false;
	}

	
	@Override
	public UserVO findUser(UserVO findUser) throws NotUserException {
		UserVO user=userMapper.findUser(findUser);
		return user;
	}

	@Override
	public UserVO loginCheck(String mid, String pwd) throws NotUserException {
		UserVO tmpUser=new UserVO();
		tmpUser.setMid(mid);
		tmpUser.setPwd(pwd);
		UserVO dbuser=this.findUser(tmpUser);
		if(dbuser==null) throw new NotUserException("존재하지 않는 아이디 입니다.");

		boolean isMatch=passwordEncoder.matches(pwd, dbuser.getPwd());
		System.out.println("isMatch: "+isMatch);
		if(!isMatch) {
			throw new NotUserException("패스워드가 맞지 않습니다.");
		}
		
		return dbuser;
	}
	@Override
	public UserVO getUserByKakao(String kakao) {
		
		return this.userMapper.getUserByKakao(kakao);
	}
	@Override
	public String getIdByEmail(String searchEmail) {

		return this.userMapper.getIdByEmail(searchEmail);
	}

	@Override
	public void sendEmail(UserVO user, String email) {

		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

        String tmpPwd = "";

        // 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
        int idx = 0;
        for (int i = 0; i < 10; i++) {
            idx = (int) (charSet.length * Math.random());
            tmpPwd += charSet[idx];
        }
		
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setFrom("BONE");
            message.setSubject("[BONE] 임시 비밀번호 안내 이메일입니다.");
            message.setText("안녕하세요.\n"
            		+ "BONE 임시비밀번호 안내 관련 이메일 입니다.\n"
            		+ "임시 비밀번호를 발급하오니 사이트에 접속하셔서 로그인 하신 후\n"
            		+ "반드시 비밀번호를 변경해주시기 바랍니다.\n\n"
            		+ "임시 비밀번호 : " + tmpPwd);
            mailSender.send(message);
        } catch (MailParseException e) {
            e.printStackTrace();
        } catch (MailAuthenticationException e) {
            e.printStackTrace();
        } catch (MailSendException e) {
            e.printStackTrace();
        } catch (MailException e) {
            e.printStackTrace();
        }
		
        // 비번 바꾸기
        user.setPwd(tmpPwd);
        service.editUserInfo(user);
        
	}
	
	@Override
	public UserVO getUserByEmail(String searchEmail) {

		return this.userMapper.getUserByEmail(searchEmail);
	}

}
