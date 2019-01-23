package com.mightyjava.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.github.cage.GCage;

@WebServlet("/captcha-servlet")
public class CaptchaServlet extends HttpServlet {
	
	private static final long serialVersionUID = 6665976557117569225L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		GCage gCage = new GCage();

		response.setContentType("image/" + gCage.getFormat());
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setHeader("Progma", "no-cache");
		response.setDateHeader("Max-Age", 0);

		String token = gCage.getTokenGenerator().next();

		HttpSession session = request.getSession();
		session.setAttribute("captcha", token);
		gCage.draw(token, response.getOutputStream());
	}
}
