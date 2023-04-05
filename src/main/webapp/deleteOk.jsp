<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴 성공</title>
</head>
<body>
	<%
		String mid = request.getParameter("id");
	
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jsp_testdb";
		String username = "root";
		String password = "1234";
		String sql = "DELETE FROM members WHERE id = ?";
		
		Connection conn = null;
		//Statement stmt = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driverName); 							//드라이버 로딩			
			conn = DriverManager.getConnection(url, username, password);	//연결 생성			
			//pstmt = conn.createStatement();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);							//sql문의 첫번째 ?에 mid값을 대입
			
			int dbFlag = pstmt.executeUpdate();
			if(dbFlag == 1) {									//rs 안에 들어있는 레코드의 개수만큼 반복
				out.println("회원탈퇴 성공하였습니다");
			} else {
				out.println("가입한 정보가 없습니다");
			}			
		} catch(ClassNotFoundException e) {
			out.println("DB 드라이버 로딩 실패");
		} catch(SQLException e) {
			out.println("DB 연결 실패");
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(Exception e) { 
				e.printStackTrace();				//에러 발생시 에러의 내용 출력
			  }			
		}
	%>
</body>
</html>