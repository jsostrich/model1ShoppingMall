package com.teamfour.cart.model;

import java.sql.SQLException;
import java.util.List;

public class CartService {

	private CartDAO dao;

	public CartService() {
		dao = new CartDAO();
	}

	public int insertCart(CartVO vo) throws SQLException {
		return dao.insertCart(vo);
	}

	public List<CartVO> selectCartItem(String d_userid) throws SQLException {
		return dao.selectCartItem(d_userid);
	}
	
	public int deleteCart(int cartno) throws SQLException {
		return dao.deleteCart(cartno);
	}
}
