drop table "PRODUCTLIST" cascade constraints;
drop table "USERINFO" cascade constraints;
drop table "MAINPRODUCT" cascade constraints;
drop table "SUBPRODUCT" cascade constraints;
drop table "ORDERINFO" cascade constraints;
drop table "BOARD" cascade constraints;
drop table "CART" cascade constraints;
drop table "RECENT" cascade constraints;
drop table "SELLERINFO" cascade constraints;
drop table "REFUND_MANAGE" cascade constraints;

drop sequence "BOARD_SEQ";
drop sequence "CART_SEQ";
drop sequence "ORDERINFO_SEQ";
drop sequence "RECENT_SEQ";
drop sequence "REFUND_MANAGE_SEQ";
drop sequence "SELLERINFO_SEQ";
drop sequence "USERINFO_SEQ";
drop sequence "PRODUCTLIST_SEQ";

commit;