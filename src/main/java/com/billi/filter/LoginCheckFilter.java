package com.billi.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.billi.vo.MembersVO;

/**
 * Servlet Filter implementation class LoginCheckFilter
 */
@WebFilter({"/board/boardwrite.do", "/user/mypage.do","/rental/rentalRegist.do"})
public class LoginCheckFilter extends HttpFilter implements Filter {

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		
		if(req.getServletPath().equals("/auth/loginCheck.do") || req.getServletPath().equals("/auth/signup.do")) {
			
		}else {
			HttpSession browser = req.getSession();
			MembersVO user = (MembersVO)browser.getAttribute("loginUser");
			if(user == null) {
				res.sendRedirect("/billi/auth/loginCheck.do");
				return;
			}
			System.out.println("user"+user);
		}
		
		
		chain.doFilter(request, response);
	}

}
