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

import com.billi.controller.LoginController;
import com.billi.controller.SignupController;

/**
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

		System.out.println("servletPath : " + request.getServletPath());

		switch (path) {
		
		case "/auth/logincheck.do":
			controller = new LoginController();
			break;
		case "/auth/signup.do":
			controller = new SignupController();
			break;
		case "/board/boardlist.do":
			controller = new BoradListController();
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
		HttpSession session = request.getSession();

		for (String key : data.keySet()) {
			if (key.equals("loginUser")) {
				session.setAttribute(key, data.get(key));
			}
		}
		System.out.println(page);

		if (page.indexOf("redirect:") >= 0) {
			response.sendRedirect(page.substring(9));
		}else if(page.indexOf("responseBody:")>=0) {
			response.getWriter().append(page.substring( 13) );
		}else {
			RequestDispatcher rd;
			rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}
}
