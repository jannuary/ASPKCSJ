import java.sql.*;
import java.util.*;

public class DatabaseAccess{
    // JDBC 驱动名及数据库 URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    
    // 数据库的用户名与密码，需要根据自己的设置
    String PORT = "3306";
    String USER = "";
    String PASS = "";

    String DB_URL = "jdbc:mysql://localhost:"+ this.PORT +"/jspks";

    Connection conn = null;
    Statement stmt = null;

    public DatabaseAccess(String port, String user, String password) {
        this.PORT = port;
        this.USER = user;
        this.PASS = password;
        this.DB_URL = "jdbc:mysql://localhost:"+ this.PORT +"/jspks";
    }

    public Map<String, ArrayList<String>> sel(String sql){
        Map<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
        try {
            // 注册 JDBC 驱动
            Class.forName("com.mysql.jdbc.Driver");

            // 打开链接
            System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // 执行查询
            System.out.println(" 实例化Statement对象...");
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            ResultSetMetaData rsMeta = rs.getMetaData();

            for (int i = 0; i < rsMeta.getColumnCount(); ++i) {
                map.put(rsMeta.getColumnName(i + 1), new ArrayList<String>());
            }
            while (rs.next()) {
                for (int i = 0; i < rsMeta.getColumnCount(); ++i) {
                    String columnName = rsMeta.getColumnName(i + 1);
                    map.get(columnName).add(rs.getString(columnName));
                }
            }


            // 完成后关闭
            rs.close();
            stmt.close();
            conn.close();
            System.out.println("Goodbye!");

        } catch (Exception e) {
            // 处理 Class.forName 错误
            e.printStackTrace();
        }

        return map;
    }

    public boolean updata(String sql){
        try {
            // 注册 JDBC 驱动
            Class.forName("com.mysql.jdbc.Driver");

            // 打开链接
            System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // 执行查询
            System.out.println(" 实例化Statement对象...");
            stmt = conn.createStatement();

            stmt.executeUpdate(sql);

            // 完成后关闭
            stmt.close();
            conn.close();
            System.out.println("Goodbye!");

        } catch (Exception e) {
            // 处理 Class.forName 错误
            e.printStackTrace();
        }

        return true;
    }
}