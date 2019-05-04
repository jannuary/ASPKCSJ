import java.sql.*;
import java.util.*;

public class DatabaseAccess{
    // JDBC �����������ݿ� URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/jspks";

    // ���ݿ���û��������룬��Ҫ�����Լ�������
    static final String USER = "";
    static final String PASS = "";

    Connection conn = null;
    Statement stmt = null;

    public DatabaseAccess() {
    }

    public Map<String, ArrayList<String>> sel(String sql){
        Map<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
        try {
            // ע�� JDBC ����
            Class.forName("com.mysql.jdbc.Driver");

            // ������
            System.out.println("�������ݿ�...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // ִ�в�ѯ
            System.out.println(" ʵ����Statement����...");
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


            // ��ɺ�ر�
            rs.close();
            stmt.close();
            conn.close();
            System.out.println("Goodbye!");

        } catch (Exception e) {
            // ���� Class.forName ����
            e.printStackTrace();
        }

        return map;
    }

    public boolean updata(String sql){
        try {
            // ע�� JDBC ����
            Class.forName("com.mysql.jdbc.Driver");

            // ������
            System.out.println("�������ݿ�...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // ִ�в�ѯ
            System.out.println(" ʵ����Statement����...");
            stmt = conn.createStatement();

            stmt.executeUpdate(sql);

            // ��ɺ�ر�
            stmt.close();
            conn.close();
            System.out.println("Goodbye!");

        } catch (Exception e) {
            // ���� Class.forName ����
            e.printStackTrace();
        }

        return true;
    }
}