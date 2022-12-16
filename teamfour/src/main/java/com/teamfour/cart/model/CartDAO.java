package com.teamfour.cart.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.userinfo.db.ConnectionPool2;

public class CartDAO {

	private ConnectionPool2 pool;

	public CartDAO() {
		pool=new ConnectionPool2();
	}
	
	/**
	 * 카트 저장
	 * @param carVo
	 * @return
	 * @throws SQLException
	 */
	public int insertCart(CartVO carVo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		System.out.println(carVo);
		
		try {
			con=pool.getConnection();
			
			String sql="insert into CART(CARTNO, PDCODE, QTY, USER_NO)"
				+ " values(cart_seq.nextval,?,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, carVo.getPdcode());
			ps.setInt(2, carVo.getQty());
			ps.setInt(3, carVo.getUserNo());
			
			int cnt=ps.executeUpdate();
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}

	/**
	 * 장바구니 조회
	 * @return
	 * @throws SQLException
	 */
	public List<CartVO> selectCartItem(String d_userid) throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<CartVO> list = new ArrayList<>();
		CartVO cartVO = new CartVO();
		try {
			con = pool.getConnection();
			
			String sql = "select c.*, c.qty*p.price from \r\n"
					+ "cart c join productList p\r\n"
					+ "on c.pdcode=p.pdcode\r\n"
					+ "join userinfo u\r\n"
					+ "on c.user_no=u.user_no\r\n"
					+ "where u.user_id=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, d_userid);
			
			
			rs=ps.executeQuery();
			while(rs.next()) {
				cartVO.setPdcode(rs.getInt("pdcode"));
				cartVO.setCartNo(rs.getInt("cartno"));
				cartVO.setQty(rs.getInt("qty"));
				cartVO.setUserNo(rs.getInt("userNo"));
				cartVO.setPrice(rs.getInt("price"));
				cartVO.setPdName(rs.getString("pdName"));
				cartVO.setImage(rs.getString("image"));
				cartVO.setTotalprice(rs.getInt("totalprice"));
				list.add(cartVO);
			}
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int deleteCart(int cartno) throws SQLException {
		Connection con=null;
		PreparedStatement ps = null;
		
		try {
			con=pool.getConnection();
			
			String sql="delete from cart where cartno=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, cartno);
			
			int cnt=ps.executeUpdate();
			System.out.println("상품 삭제결과 cnt="+cnt+", 매개변수 cartno"+cartno);
			return cnt;
			
		}finally {
			pool.dbClose(ps, con);
		}
	}

	
}
