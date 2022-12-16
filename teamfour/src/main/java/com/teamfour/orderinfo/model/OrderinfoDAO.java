package com.teamfour.orderinfo.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.teamfour.productAll.model.ProductAllVO;
import com.userinfo.db.ConnectionPool2;

public class OrderinfoDAO {
	private ConnectionPool2 pool;
	
	public OrderinfoDAO() {
		pool=new ConnectionPool2();
	}
	
	public int insertOrderinfo(OrderinfoVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		int cnt=0;
		try {
			con=pool.getConnection();
			
			String sql="insert into orderinfo(order_no, user_no, pdcode, qty, \r\n"
					+ "                totalprice, del_name, del_tel, del_add,\r\n"
					+ "                del_deadd, del_email, refund_mgno)\r\n"
					+ "values(orderinfo_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, vo.getUser_no());
			ps.setInt(2, vo.getPdcode());
			ps.setInt(3, vo.getQty());
			ps.setInt(4, vo.getTotalprice());
			ps.setString(5, vo.getDel_name());
			ps.setString(6, vo.getDel_tel());
			ps.setString(7, vo.getDel_add());
			ps.setString(8, vo.getDel_deadd());
			ps.setString(9, vo.getDel_email());
			ps.setInt(10, vo.getRefund_mgno());
			
			cnt=ps.executeUpdate();
			System.out.println("입력완료 cnt = "+cnt+", 매개변수 vo="+vo);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public ProductAllVO detailViewPdCode(int pdcode) throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		ProductAllVO vo = new ProductAllVO();
		
		try {
			con = pool.getConnection();
			
			String sql = "select pdname, price, image, detail"
					+ " from productList"
					+ "	where pdcode = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, pdcode);
			
			rs=ps.executeQuery();
			if(rs.next()) {
				String pdname = rs.getString("pdname");
				int price = rs.getInt("price");
				String image = rs.getString("image");
				String detail = rs.getString("detail");
				
				vo.setPdcode(pdcode);
				vo.setPdname(pdname);
				vo.setPrice(price);
				vo.setImage(image);
				vo.setDetail(detail);
			}
			System.out.println("상품번호로 상품검색 결과 vo=" + vo
				+"매개변수 pdcode=" + pdcode);
			
			return vo;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public List<ProductAllVO> selectByMaincode(int maincode) throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<ProductAllVO> list = new ArrayList<>();
		
		try {
			con = pool.getConnection();
			
			String sql = "select pl.*, s.subproduct_name, m.*"
					+ " from productList pl join subproduct s"
					+ " on pl.div_no = s.div_no"
					+ "	join mainproduct m"
					+ " on s.maincode = m.maincode"
					+ "	where maincode = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, maincode);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				int pdcode = rs.getInt("pdcode");
				String pdname = rs.getString("pdname");
				int price = rs.getInt("price");
				Timestamp regdate = rs.getTimestamp("regdate");
				int seller_no = rs.getInt("seller_no");
				String image = rs.getString("image");
				String detail = rs.getString("detail");
				int div_no = rs.getInt("div_no");
				String subproduct_name = rs.getString("subproduct_name");
				String mainname = rs.getString("mainname");
				
				ProductAllVO vo = new ProductAllVO(pdcode, pdname, price, regdate, seller_no, image, detail,
						div_no, subproduct_name, maincode, mainname);
				list.add(vo);
			}
			System.out.println("대분류코드로 상품검색 결과 list.size=" + list.size()
				+"매개변수 maincode=" + maincode);
			
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public List<ProductAllVO> selectAllPd() throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<ProductAllVO> list = new ArrayList<>();
		
		try {
			con = pool.getConnection();
			
			String sql = "select pdname, pdcode, price, regdate "
					+ " ,seller_no, image, detail, div_no from ProductList";
			ps = con.prepareStatement(sql);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				int div_no = rs.getInt("div_no");
				int pdcode = rs.getInt("pdcode");
				String pdname = rs.getString("pdname");
				int price = rs.getInt("price");
				Timestamp regdate = rs.getTimestamp("regdate");
				long seller_no = rs.getLong("seller_no");
				String image = rs.getString("image");
				String detail = rs.getString("detail");
				
				ProductAllVO vo = new ProductAllVO(pdcode, pdname, price, regdate, seller_no, image, detail, div_no);
				list.add(vo);
			}
			System.out.println("대분류코드로 상품검색 결과 list.size=" + list.size());
			
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	

}
