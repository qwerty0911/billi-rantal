package com.billi.frontcontroller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.billi.chatting.ChattingController;
import com.billi.chatting.ChattingListController;
import com.billi.controller.BoardAjaxController;
import com.billi.controller.BoardDetailController;
import com.billi.controller.BoardListController;
import com.billi.controller.BoradwriteController;
import com.billi.controller.LoginCheckController;
import com.billi.controller.MypageController;
import com.billi.controller.RentalConfirmController;
import com.billi.controller.RentalController;
import com.billi.controller.SignUpController;
import com.billi.controller.returnConfirmController;

/*
 * Servlet implementation class FrontController
 */
@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String path = request.getServletPath();
		CommonControllerInterface controller = null;
		Map<String, Object> data = new HashMap<>();
		data.put("method", request.getMethod());
		data.put("request", request);
		data.put("response", response);

		System.out.println("servletPath : " + request.getServletPath());

		switch (path) {
		
		case "/auth/loginCheck.do":
			controller = new LoginCheckController();
			break;
		case "/auth/signUp.do":
			controller = new SignUpController();
			break;
		case "/rental/rentalRegist.do": //예약 등록
			controller = new RentalController();
			break;
		case "/board/boardwrite.do": //게시글 작성
			controller = new BoradwriteController();
			break;
		case "/board/boardlist.do": //게시판 목록
			controller = new BoardListController();
			break;
		case "/board/boardlistAjax.do": //게시판 목록 ajax
			controller = new BoardAjaxController();
			break;
		case "/board/boarddetail.do": //게시판 페이지
			controller = new BoardDetailController();
			break;
		case "/auth/idDupCheck.do":
			controller = new idDupCheckController();
			break;
		case "/auth/nicknameDupCheck.do":
			controller = new nicknameDupCheckController();
			break;
		case "/auth/membersDetail.do":
			controller = new membersDetailController();
			break;
		case "/auth/logout.do":
			controller = new LogoutController();
			break;
		case "/chat/chatlist.do": //채팅 목록
			controller=new ChattingListController();
			break;
		case "/chat/chat.do": //채팅페이지 호출
			controller = new ChattingController();
			break;
			
		case "/user/myboardlist.do": //내가 쓴 글 호출
			controller = new SelectbynicknameController();
			break;
		case "/user/mypage.do": //마이페이지 호출
			controller = new MypageController();
			break;
		case "/user/myreview.do": //내가 쓴 리뷰 호출
			controller = new MyreviewController();
			break;
		case "/user/myrental.do": //내가 빌린 내역 호출
			controller = new MyrentalController();
			break;
		case "/user/reviewwrite.do": //리뷰 작성
			controller = new ReviewwriteController();
			break;
		case "/user/reviewdelete.do": //리뷰 삭제
			controller = new ReviewdeleteController();
			break;
		case "/user/rentalconfirm.do": //렌탈 확정
			controller = new RentalConfirmController();
			break;
			
		case "/user/returnconfirm.do": //반납 확정
			controller = new returnConfirmController();
			break;
<<<<<<< HEAD
		case "/user/insurancecharge.do": //보험금 청구 신청
			controller = new InsurancechargeController();
			break;
=======
>>>>>>> 0af4bfb1b9f8b0f0275adf1272bf71b04d35335b

		default:
			break;
		}
		String page = null;
		try {
			page = controller.excute(data);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//HttpSession session = request.getSession();

		/*
		 * for (String key : data.keySet()) { if (key.equals("loginUser")) {
		 * session.setAttribute(key, data.get(key)); } }
		 */
		System.out.println(page);

		if (page.indexOf("redirect:") >= 0) {
			response.sendRedirect(page.substring(9));
		}else if(page.indexOf("responseBody:")>=0) {
			response.setCharacterEncoding("utf-8");
			response.getWriter().append(page.substring( 13) );
		}else {
			RequestDispatcher rd;
			rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}
}