import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class HelloForm
 */
public class ex extends HttpServlet {
    private static final long serialVersionUID = 1L;
        
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ex() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // ������Ӧ��������
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String title = "ʹ�� POST ������ȡ������";
        // ��������


        Map<String, ArrayList<String>> data = new HashMap<String, ArrayList<String>>();
        
        
        String exid = new String(request.getParameter("exid").getBytes("ISO8859-1"), "UTF-8");
        String exn = new String(request.getParameter("exn").getBytes("ISO8859-1"), "UTF-8");
        
        

        new String(request.getParameter("exn").getBytes("ISO8859-1"), "UTF-8");

        String sql = "select answer from exam where exid='"+ exid +"' and exn='"+ exn +"' order by number asc";
        
        // �����ж�
        DatabaseAccess Data = new DatabaseAccess();
        Data.sel(sql);

        data = Data.sel(sql);
        List<String> answers = new ArrayList<>(data.get("answer"));
        
        int sc = 0;
        for (int i = 0; i < answers.size(); i++) {
            String n = "t_"+ String.valueOf(i+1);

            String str = new String(request.getParameter(n).getBytes("ISO8859-1"), "UTF-8");

            System.out.println(n);

            if(str.equals(answers.get(i))){
                sc++;
            }
        }
        System.out.println(sc);

        System.out.println(answers);
        System.out.println(data);

        // д�����ݿ�
        HttpSession session = request.getSession();
        String uid = (String)session.getAttribute("uid");
        uid = uid.substring(0,uid.indexOf(","));
        sql = "insert into mark(uid, exid, exn, mark) values('"+ uid +"','"+ exid +"', '"+ exn +"', '"+ sc +"')";
        System.out.println(uid);
        Data.updata(sql);
       
        // String sql = "select * from student";
        
        out.println("<head><link rel=\"stylesheet\" href=\"css/style.css\"></head><div class=\"title\"><p>"+exid+"�� "+ exn+ " ���� </p><p>"+  sc +" ��</p><a href=\"/ks/exam.jsp\"></a></div>");

        // request.getRequestDispatcher("ex.jsp").forward(request, response);
    }

    // ���� POST ��������ķ���
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}