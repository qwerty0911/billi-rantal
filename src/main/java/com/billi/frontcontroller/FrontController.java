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
import javax.servlet.http.HttpSession;

import com.billi.controller.BoardListController;
import com.billi.controller.BoardAjaxController;
import com.billi.controller.BoardDetailController;
import com.billi.controller.BoradwriteController;
import com.billi.controller.LoginCheckController;
import com.billi.controller.RentalController;
import com.billi.controller.SignUpController;
import com.billi.controller.ChattingController;

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
		case "/rental/rentalRegist.do":
			controller = new RentalController();
			break;
		case "/board/boardwrite.do": //게시글 작성
			controller = new BoradwriteController();
			break;
		case "/board/boardlist.do": //게시판 목록
			controller = new BoardListController();
			break;
		case "/board/boardlistAjax.do": //게시판 목록
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
			
		case "/chat/chat.do": //채팅페이지 호출
			controller = new ChattingController();
			break;
//		case "/emp/empList.do":
//			controller = new EmpListController();
//			break;
//		case "/emp/empDetail.do":
//			controller = new EmpDetailController();
//			break;
//		case "/emp/empInsert.do":
//			controller = new EmpInsertController();
//			break;
//		case "/emp/empDelete.do":
//			controller = new EmpDeleteController();
//			break;
//		case "/auth/emailDupCheck.do":
//			controller = new EmailDupCheckController();
//			break;

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