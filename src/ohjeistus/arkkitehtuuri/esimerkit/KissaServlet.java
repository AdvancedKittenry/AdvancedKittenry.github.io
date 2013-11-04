package Kissalista.Servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Kissalista.Models.Kissa;

/* Kontrolleriluokka, joka näyttää listan kissoja. 
 * Kissalista voi olla hakusanalla suodatettu, 
 * mikäli parametri haku on lähetetty aineistopyynnön mukana.
 */
public class KissaServlet extends HttpServlet {
  /**
   * Processes requests for both HTTP
   * <code>GET</code> and <code>POST</code> methods.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest request, 
                                HttpServletResponse response)
      throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    
    String hakusana = request.getParameter("haku");
    List<Kissa> kissat = null;
    if (hakusana != null && hakusana.length > 0) {
      kissat = Kissa.hae(hakusana);
    } else {
      kissat = Kissa.kaikkiKissat();
    }
    
    request.setAttribute("kissat", kissat);
    if (kissat.length() == 0) {
      request.setAttribute("viesti", "Kissoja ei löytynyt");
    }
    
    /* Luodaan RequestDispatcher-olio, joka osaa näyttää näkymätiedoston lista.jsp */
    RequestDispatcher dispatcher = request.getRequestDispatcher("lista.jsp");
    /* Pyydetään dispatcher-oliota näyttämään JSP-sivunsa */
    dispatcher.forward(request, response);
  }
  
  /**
   * Handles the HTTP
   * <code>GET</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
      processRequest(request, response);
  }

  /**
   * Handles the HTTP
   * <code>POST</code> method.
   *
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
      processRequest(request, response);
  }
}
