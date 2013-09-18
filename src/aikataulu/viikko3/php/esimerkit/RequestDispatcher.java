protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
  response.setContentType("text/html;charset=UTF-8");
  
  /* Luodaan RequestDispatcher-olio, joka osaa näyttää lista.jsp:n */
  RequestDispatcher dispatcher = request.getRequestDispatcher("lista.jsp");
  /* Pyydetään dispatcher-oliota näyttämään JSP-sivunsa */
  dispatcher.forward(request, response);
}
