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
import javax.servlet.ServletContext;

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
        // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String title = "使用 POST 方法读取表单数据";
        // 处理中文
        Map<String, ArrayList<String>> data = new HashMap<String, ArrayList<String>>();
        
        String exid = new String(request.getParameter("exid").getBytes("ISO8859-1"), "UTF-8");
        String exn = new String(request.getParameter("exn").getBytes("ISO8859-1"), "UTF-8");
        
        new String(request.getParameter("exn").getBytes("ISO8859-1"), "UTF-8");

        String sql = "select answer from exam where exid='"+ exid +"' and exn='"+ exn +"' order by number asc";
        
        // 分数判断
        ServletContext application = this.getServletContext();
        String port = application.getInitParameter("port");
        String suser = application.getInitParameter("user");
        String password = application.getInitParameter("password");

        DatabaseAccess Data = new DatabaseAccess(port, suser, password);
        Data.sel(sql);

        data = Data.sel(sql);
        List<String> answers = new ArrayList<>(data.get("answer"));
        
        int sc = 0;
        for (int i = 0; i < answers.size(); i++) {
            String n = "t_"+ String.valueOf(i+1);

            String str = new String(request.getParameter(n).getBytes("ISO8859-1"), "UTF-8");
            if(str.equals(answers.get(i))){
                sc++;
            }
        }

        // 写入数据库
        HttpSession session = request.getSession();
        String uid = (String)session.getAttribute("uid");
        uid = uid.substring(0,uid.indexOf(","));
        sql = "insert into mark(uid, exid, exn, mark) values('"+ uid +"','"+ exid +"', '"+ exn +"', '"+ sc +"')";
        Data.updata(sql);
       
        
        out.println("<head><link rel=\"stylesheet\" href=\"css/style.css\"></head><div class=\"title\"><p>"+exid+"第 "+ exn+ " 套题 </p><p>"+  sc +" 分</p><a href=\"/ks/exam.jsp\">ok</a></div>");

        // request.getRequestDispatcher("ex.jsp").forward(request, response);
    }

    // 处理 POST 方法请求的方法
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}