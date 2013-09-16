protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
  response.setContentType("text/html;charset=UTF-8");
  
  RequestDispatcher dispatcher = request.getRequestDispatcher("lista.jsp");
  dispatcher.forward(request, response);
}
