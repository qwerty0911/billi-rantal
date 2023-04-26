package com.billi.model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.Period;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.billi.dbutil.OracleUtil;
import com.billi.util.DateUtil;
import com.billi.vo.BoardsVO;
import com.billi.vo.ChatVO;
import com.billi.vo.MembersVO;

public class BoardsDAO {
	Connection conn;
	Statement st;
	PreparedStatement pst; //?지원
	ResultSet rs;
	int resultCount; //insert,update,delete 건수
	CallableStatement cst; //SP지원
	public static final int PAGEPERLIST = 8;
	
	//가까운 물건만 리스트
	public List<BoardsVO> selectCloseDistance(MembersVO member,float distance) {
		String sql="""
				select BOARD_ID,
					BOARD_TITLE,
					BOARD_CONTENTS,
					BOARD_WRITER,
					BOARD_DATE,
					PRICE,
					PICTURES,
					ADDRESS,
					CATEGORY
				from boards 
				where latitude between ? and ? and longitude between ? and ?
				order by board_date desc, board_id desc
				""";
		float userLatitude = member.getLatitude();
		float userLongitude = member.getLongitude();
		
		List<BoardsVO> boardlist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setFloat(1, userLatitude-distance);
			pst.setFloat(2, userLatitude+distance);
			pst.setFloat(3, userLongitude-distance);
			pst.setFloat(4, userLongitude+distance);
			rs=pst.executeQuery();
			
			while(rs.next()) {
				BoardsVO board = makeBoard(rs);
				boardlist.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return boardlist;
	}
	
	//카테고리 불러오기
	public List<String> selectCategory() {
		String sql="""
				select category_name
				from category
				order by 1
				""";
		List<String> clist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			st=conn.createStatement();
			rs=st.executeQuery(sql);
			
			while(rs.next()) {
				String category = rs.getString("category_name");
				clist.add(category);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return clist;
	}
	
	//게시글 작성 및 저장
	public int boardInsert(BoardsVO board) {
		String sql="""
				insert into boards(board_id, board_title,board_contents,board_writer,board_date,price,pictures,address,category,latitude,longitude)
				values(?, ?, ?, ?, sysdate, ?, ?, ?, ?,?,?)
				""";
		conn=OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, board.getBoard_id());
			pst.setString(2, board.getBoard_title());
			pst.setString(3, board.getBoard_contents());
			pst.setString(4,board.getBoard_writer());
			pst.setInt(5, board.getPrice());
			pst.setString(6, board.getPictures());
			pst.setString(7,  board.getAddress());
			pst.setString(8, board.getCategory());
			pst.setFloat(9, board.getLatitude());
			pst.setFloat(10, board.getLongitude());
			resultCount = pst.executeUpdate(); //DML문장 실행한다. 영향 받은 건수 return
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			resultCount=-1;
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		return resultCount;
	}
	
	//게시글 전체 불러오기
	public List<BoardsVO> selectAll() {
		String sql="""
				select BOARD_ID,
					BOARD_TITLE,
					BOARD_CONTENTS,
					BOARD_WRITER,
					BOARD_DATE,
					PRICE,
					PICTURES,
					ADDRESS,
					CATEGORY,
					LATITUDE,
					LONGITUDE
				from boards 
				order by board_date desc, board_id desc
				""";
		List<BoardsVO> boardlist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			st=conn.createStatement();
			rs=st.executeQuery(sql);
			
			while(rs.next()) {
				BoardsVO board = makeBoard(rs);
				boardlist.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return boardlist;
	}
	
	//board_id로 특정 게시글 불러오기
	public BoardsVO selectById(int board_id) {
		String sql="""
				select BOARD_ID,
					BOARD_TITLE,
					BOARD_CONTENTS,
					BOARD_WRITER,
					BOARD_DATE,
					PRICE,
					PICTURES,
					ADDRESS,
					CATEGORY,
					LATITUDE,
					LONGITUDE
				from boards 
				where board_id=?
				""";
		BoardsVO board = new BoardsVO();
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, board_id);
			rs=pst.executeQuery();
			while(rs.next()) {
				board = makeBoard(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return board;
	}
	
	//내가 쓴 글 조회
	public List<BoardsVO> selectByWriter(String board_writer) {
		String sql ="""
				select *
				from boards
				where board_writer = ?
				order by board_date desc
				""";
		List<BoardsVO> boardlist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, board_writer);
			rs = pst.executeQuery();
			while(rs.next()) {
				BoardsVO board = makeBoard(rs);
				boardlist.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, pst, conn);
		}
		return boardlist;
	}
		
	/*게시판 목록 페이지 처리*/
	//게시판 페이지번호 출력
	public String printPageList(int page, HttpServletRequest request, String categoryParam, int local, String search) throws Exception {
		String listUrl="/billi/board/boardlist.do";
		StringBuffer strList = new StringBuffer();
		
		//로그인 회원 정보
		HttpSession session = request.getSession();
		MembersVO loginUser = (MembersVO) session.getAttribute("loginUser");
		try {
			// 페이징 범위 산출
			int[] paging = countPage(page, categoryParam, local, loginUser, search);
			
			if(paging==null) {
				return null;
			}
			
			for(int i=paging[0];i<=paging[1];i++) {
				if(i==page)
					strList.append("<li class='page-item active' aria-current='page'><span class='page-link'>"+i+"</span></li>");
					//strList.append("<span style='color:orange; front-weight:bold;'>"+i+"</span>");
				else
					strList.append("<li class='page-item'><a class='page-link' href='"+listUrl+"?pageNum="+i+"&category="+categoryParam+"&local="+local+"'>"+i+"</a></li>");
					//strList.append("<a href='"+listUrl+"?pageNum="+i+"&category="+categoryParam+"'>"+i+"</a>");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}

		return strList.toString();
	}
	
	//페이지번호에 따른 게시물 출력
	public void printBoard(int page, HttpServletRequest request, String categoryParam, int local, String search) {
		conn = OracleUtil.getConnection();
		HttpSession session = request.getSession();
		
		// 리스트 정보 가져오기
		//카테고리와 동네 선택에 따라 동적 sql 작성
		String category = convertCategory(categoryParam);
		String condition="";
		
		//동네 보기 선택
		if(local==1) {
			MembersVO loginUser = (MembersVO) session.getAttribute("loginUser");
			float latitude = loginUser.getLatitude();
			float longitude= loginUser.getLongitude();
			float latitudeNear=latitude-0.003f;
			float latitudeFar=latitude+0.003f;
			float longitudeNear=longitude-0.003f;
			float longitudeFar=longitude+0.003f;
			condition+="and LATITUDE between "
					+latitudeNear
					+" and "
					+latitudeFar
					+" and LONGITUDE between "
					+longitudeNear
					+" and "
					+longitudeFar;
		}
		//카테고리 선택
		if(!category.equals("all")) {
			condition+="and category = '"+category+"'";
		}
		//검색 시
		if(search != null) {
			condition+=" and (board_title like '%"
					+search
					+"%' or board_contents like '%"
					+search
					+"%')";
		}
		String sql = """
				select * from
				(select ROWNUM as rnum, A.* from
				(select * from boards
				where 1=1"""
				+condition
				+
				"""
				order by board_date desc, board_id desc)A ) 
				where rnum >= ? and rnum <= ?
				""";
		try {
			pst = conn.prepareStatement(sql);
			// 요청된 페이지에 따른 게시물 범위 지정
			int startPage = (page - 1) * PAGEPERLIST + 1; // 시작 게시물
			int endPage = startPage + PAGEPERLIST - 1; // 끝 게시물
			pst.setInt(1, startPage);
			pst.setInt(2, endPage);
			rs = pst.executeQuery();
			
			// 결과를 ArrayList에 추가
			ArrayList<BoardsVO> list = new ArrayList<>(); // 리스트 정보 담아줄 객체
			while (rs.next()) {
				BoardsVO board = new BoardsVO();
				board=makeBoard(rs);
				list.add(board);
			}
			
			request.setAttribute("boardlist", list); // 리스트 전달
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
	}
	
	//1. 페이지 개수 구하기
	public int[] countPage(int page, String categoryParam, int local, MembersVO loginUser, String search) throws Exception {
		//카테고리와 동네 선택에 따라 동적 sql 작성
		String category = convertCategory(categoryParam);
		String sql = """
				select count(*) count 
				from boards
				where 1=1
				""";
		//동네 선택
		if(local==1) {
			float latitude = loginUser.getLatitude();
			float longitude= loginUser.getLongitude();
			float latitudeNear=latitude-0.003f;
			float latitudeFar=latitude+0.003f;
			float longitudeNear=longitude-0.003f;
			float longitudeFar=longitude+0.003f;
			sql+=" and LATITUDE between "
					+latitudeNear
					+" and "
					+latitudeFar
					+" and LONGITUDE between "
					+longitudeNear
					+" and "
					+longitudeFar;
		}
		//카테고리 선택
		if(!category.equals("all")) {
			sql+=" and category = '"+category+"'";
		}
		//검색 시
		if(search != null) {
			sql+="and (board_title like '%"
					+search
					+"%' or board_contents like '%"
					+search
					+"%')";
		}
		int totalContent=0;
		int totalPage = 0;
		conn = OracleUtil.getConnection();
		try {
			st=conn.createStatement();
			rs=st.executeQuery(sql);
			
			while(rs.next()) {
				totalContent = rs.getInt("count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (totalContent == 0) {
			return null;
		}
		totalPage = totalContent / PAGEPERLIST;
		if (totalContent % PAGEPERLIST > 0) {
			totalPage++;
		}
		
		// 페이징 범위 계산
		int startPage, endPage; // 시작과 끝 페이지
		startPage = ((page - 1) / PAGEPERLIST) * PAGEPERLIST + 1;
		endPage = startPage + PAGEPERLIST - 1;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		int[] startEnd = new int[2];
		startEnd[0] = startPage;
		startEnd[1] = endPage;

		return startEnd;
	}

	//게시글 조회수 업데이트
	public void updateHits(int board_id) {
		String sql="""
				update boards set board_hits = board_hits+1 where board_id=?
				""";
		conn=OracleUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1,board_id);
			pst.executeUpdate(); 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			resultCount=-1;
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		//return resultCount;
	}
	
	//조회수 높은 4개 게시물 가져오기
	public List<BoardsVO> getHitsList() {
		String sql="""
				SELECT BOARD_ID,BOARD_TITLE,BOARD_CONTENTS,BOARD_WRITER,BOARD_DATE,
				PRICE,PICTURES,ADDRESS,CATEGORY,latitude,longitude
				FROM (SELECT BOARD_ID,
					BOARD_TITLE,
					BOARD_CONTENTS,
					BOARD_WRITER,
					BOARD_DATE,
					PRICE,
					PICTURES,
					ADDRESS,
					CATEGORY,
					latitude,
					longitude
				       FROM boards
				      ORDER BY board_hits DESC)
				WHERE ROWNUM <= 4
				""";
		
		List<BoardsVO> boardlist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			st=conn.createStatement();
			rs=st.executeQuery(sql);
			
			while(rs.next()) {
				BoardsVO board = makeBoard(rs);
				boardlist.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return boardlist;
	}
	


	public List<BoardsVO> getLatestList() {
		String sql="""
				SELECT BOARD_ID,BOARD_TITLE,BOARD_CONTENTS,BOARD_WRITER,BOARD_DATE,
				PRICE,PICTURES,ADDRESS,CATEGORY,latitude,longitude
				FROM (SELECT BOARD_ID,
					BOARD_TITLE,
					BOARD_CONTENTS,
					BOARD_WRITER,
					BOARD_DATE,
					PRICE,
					PICTURES,
					ADDRESS,
					CATEGORY,
					latitude,
					longitude
				       FROM boards
				      ORDER BY board_date DESC, board_id DESC)
				WHERE ROWNUM <= 4
				""";
		
		List<BoardsVO> boardlist = new ArrayList<>();
		conn = OracleUtil.getConnection();
		try {
			st=conn.createStatement();
			rs=st.executeQuery(sql);
			
			while(rs.next()) {
				BoardsVO board = makeBoard(rs);
				boardlist.add(board);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return boardlist;
	}
	
	//board_id의 가장 큰 값 가져와서 board_id 설정
	public int setBoardSeq() {
		String sql="""
				select max(board_id) seq
				from boards 
				""";
		int seq = 0;
		conn = OracleUtil.getConnection();
		try {
			st=conn.createStatement();
			rs=st.executeQuery(sql);
			
			while(rs.next()) {
				seq=rs.getInt("seq");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(rs, st, conn);
		}
		return ++seq;
	}
	
	//board_id로 board_title 가져오기
	public String TitleById(int board_id) {
		String sql="""
				select board_title
				from boards
				where board_id=?
				""";
		conn = OracleUtil.getConnection();
		String title="";
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1,board_id);
			rs = pst.executeQuery();
			while (rs.next()) {
				title=rs.getString("board_title");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			resultCount = -1;
			e.printStackTrace();
		} finally {
			OracleUtil.dbDisconnect(null, pst, conn);
		}
		return title;
	}
	
	//카테고리 이름 변환
	private String convertCategory(String cateNum) {
		String category="";
		switch(cateNum) {
		case "toy": category="유아동/완구"; break;
		case "digital": category="디지털/가전"; break;
		case "sports": category="레저/스포츠"; break;
		case "life": category="주방/생활용품"; break;
		case "interior": category="가구/인테리어"; break;
		case "hobby": category="취미/악기/게임"; break;
		default: category="all";
		}
		return category;
	}
	
	private BoardsVO makeBoard(ResultSet rs) throws SQLException {
		BoardsVO board=new BoardsVO();
		board.setAddress(rs.getString("address"));
		board.setBoard_contents(rs.getString("board_contents"));
		board.setBoard_id(rs.getInt("board_id"));
		board.setBoard_title(rs.getString("board_title"));
		board.setBoard_writer(rs.getString("board_writer"));
		board.setBoard_date(rs.getDate("board_date"));
		board.setCategory(rs.getString("category"));
		board.setPictures(rs.getString("pictures"));
		board.setPrice(rs.getInt("price"));
		board.setLatitude(rs.getFloat("latitude"));
		board.setLongitude(rs.getFloat("longitude"));

		return board;
	}
}