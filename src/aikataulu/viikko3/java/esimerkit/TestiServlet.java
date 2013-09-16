public class TestiServlet extends HttpServlet {

  /**
   * Processes requests for both HTTP
   * <code>GET</code> and <code>POST</code> methods.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter(); 
    try {
      /* TODO output your page here. You may use following sample code. */
      out.println("<html>"); 
      out.println("<head><title>Servlet TestiServlet</title></head>");
      out.println("<body>");
      out.println("<h1>Servlet TestiServlet at " + 
        request.getContextPath() + "</h1>");
      out.println("</body>");
      out.println("</html>");
    } finally {            
      out.close();
    }
  }
  
  /* NetBeansin piilottamat doGet- ja doPost-metodit, jotka kutsuvat processRequest-metodia. */

}
