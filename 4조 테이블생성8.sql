/* 회원 */
CREATE TABLE userinfo (
	user_no NUMBER NOT NULL, /* 회원번호 */
	user_name VARCHAR2(20) NOT NULL, /* 회원명 */
	user_nick VARCHAR2(30) not null unique, /* 닉네임 */
	user_id VARCHAR2(30) not null unique, /* 아이디 */
	user_pwd VARCHAR2(30) NOT NULL, /* 비밀번호 */
	user_tel VARCHAR2(30) not null unique, /* 연락처 */
	user_email VARCHAR2(50) not null unique, /* 이메일 */
	user_zipcode VARCHAR2(100) not null, /* 우편번호 */
	user_address VARCHAR2(200) NOT NULL, /* 주소 */
	user_joindate DATE DEFAULT sysdate, /* 가입날짜 */
	user_class number default 1,
	outdate varchar2(10)
);

CREATE unique index idx_userinfo
ON userinfo (user_no);

ALTER TABLE userinfo
ADD	CONSTRAINT PK_userinfo
PRIMARY KEY (user_no);

create sequence userinfo_seq
start with 1
increment by 1
nocache;

COMMENT ON TABLE userinfo IS '회원';

COMMENT ON COLUMN userinfo.user_no IS '회원번호';

COMMENT ON COLUMN userinfo.user_name IS '회원명';

COMMENT ON COLUMN userinfo.user_nick IS '닉네임';

COMMENT ON COLUMN userinfo.user_id IS '아이디';

COMMENT ON COLUMN userinfo.user_pwd IS '비밀번호';

COMMENT ON COLUMN userinfo.user_tel IS '연락처';

COMMENT ON COLUMN userinfo.user_email IS '이메일';

COMMENT ON COLUMN userinfo.user_zipcode IS '우편번호';

COMMENT ON COLUMN userinfo.user_address IS '주소';

COMMENT ON COLUMN userinfo.user_joindate IS '가입날짜';

COMMENT ON COLUMN userinfo.user_class IS '구매자 인식번호';

COMMENT ON COLUMN userinfo.outdate IS '탈퇴여부';


/* 상품목록 */
CREATE TABLE ProductList (
	pdcode NUMBER NOT NULL, /* 상품코드 */
	pdname VARCHAR2(30) NOT NULL, /* 상품명 */
	price NUMBER NOT NULL, /* 가격 */
    qty number not null check(qty>=0), /* 재고 */
	regdate DATE DEFAULT sysdate NOT NULL, /* 등록일 */
	seller_no NUMBER NOT NULL, /* 판매자번호 */
	image VARCHAR2(200) not null unique, /* 이미지 */
	detail CLOB NOT NULL, /* 상세설명 */
	div_no NUMBER NOT NULL /* 소분류코드 */
);

CREATE UNIQUE INDEX idx_ProductList
	ON ProductList (pdcode);

ALTER TABLE ProductList
	ADD	CONSTRAINT PK_ProductList
		PRIMARY KEY (pdcode	);
        
create sequence productList_seq
start with 1
increment by 1
nocache;
COMMENT ON TABLE ProductList IS '상품목록';

COMMENT ON COLUMN ProductList.pdcode IS '상품코드';

COMMENT ON COLUMN ProductList.pdname IS '상품명';

COMMENT ON COLUMN ProductList.qty IS '재고';

COMMENT ON COLUMN ProductList.price IS '가격';

COMMENT ON COLUMN ProductList.regdate IS '등록일';

COMMENT ON COLUMN ProductList.seller_no IS '판매자번호';

COMMENT ON COLUMN ProductList.image IS '이미지';

COMMENT ON COLUMN ProductList.detail IS '상세설명';

COMMENT ON COLUMN ProductList.div_no IS '소분류코드';

/* 상품대분류 */
CREATE TABLE mainproduct (
	maincode NUMBER NOT NULL, /* 대분류코드 */
	mainname VARCHAR2(30) NOT NULL unique /* 대분류이름 */
);

CREATE UNIQUE INDEX idx_mainproduct
	ON mainproduct (maincode);

ALTER TABLE mainproduct
	ADD CONSTRAINT PK_mainproduct
		PRIMARY KEY (maincode);
        
COMMENT ON TABLE mainproduct IS '상품대분류';

COMMENT ON COLUMN mainproduct.maincode IS '대분류코드';

COMMENT ON COLUMN mainproduct.mainname IS '대분류이름';


/* 상품소분류 */
CREATE TABLE subproduct (
	div_no NUMBER NOT NULL, /* 소분류코드 */
	subproduct_name VARCHAR2(50) NOT NULL unique, /* 제품명 */
	maincode NUMBER NOT NULL /* 대분류코드 */
);

CREATE UNIQUE INDEX idx_subproduct
	ON subproduct (div_no);

ALTER TABLE subproduct
	ADD	CONSTRAINT PK_subproduct
		PRIMARY KEY (div_no);
        
COMMENT ON TABLE subproduct IS '상품소분류';

COMMENT ON COLUMN subproduct.div_no IS '소분류코드';

COMMENT ON COLUMN subproduct.subproduct_name IS '제품명';

COMMENT ON COLUMN subproduct.maincode IS '대분류코드';



/* 주문내역 */
CREATE TABLE orderinfo (
	order_no NUMBER NOT NULL, /* 주문번호 */
	user_no NUMBER NOT NULL, /* 회원번호 */
	pdcode NUMBER NOT NULL, /* 상품코드 */
	orderdate DATE DEFAULT sysdate, /* 주문일 */
	qty NUMBER NOT NULL, /* 상품개수 */
	totalprice NUMBER NOT NULL, /* 총금액 */
	del_name VARCHAR2(20) NOT NULL, /* 배송받는사람이름 */
	del_tel VARCHAR2(20) NOT NULL, /* 배송받는연락처 */
	del_add VARCHAR2(100) NOT NULL, /* 배송받는주소 */
	del_deadd VARCHAR2(200) NOT NULL, /* 배송받는상세주소 */
	del_email VARCHAR2(30) NOT NULL, /* 배송받는이메일 */
	refund_mgno NUMBER /* 환불번호 */
);
CREATE UNIQUE INDEX idx_order
	ON orderinfo (order_no);

ALTER TABLE orderinfo
	ADD	CONSTRAINT PK_order
		PRIMARY KEY (order_no);
        
create sequence orderinfo_seq
start with 1
increment by 1
nocache;

COMMENT ON TABLE orderinfo IS '주문내역';

COMMENT ON COLUMN orderinfo.order_no IS '주문번호';

COMMENT ON COLUMN orderinfo.user_no IS '회원번호';

COMMENT ON COLUMN orderinfo.pdcode IS '상품코드';

COMMENT ON COLUMN orderinfo.orderdate IS '주문일';

COMMENT ON COLUMN orderinfo.qty IS '상품개수';

COMMENT ON COLUMN orderinfo.totalprice IS '총금액';

COMMENT ON COLUMN orderinfo.del_name IS '배송받는사람이름';

COMMENT ON COLUMN orderinfo.del_tel IS '배송받는연락처';

COMMENT ON COLUMN orderinfo.del_add IS '배송받는집코드';

COMMENT ON COLUMN orderinfo.del_deadd IS '배송받는상세주소';

COMMENT ON COLUMN orderinfo.del_email IS '배송받는이메일';

COMMENT ON COLUMN orderinfo.refund_mgno IS '환불번호';


/* 건의게시판 */
CREATE TABLE board (
	write_no NUMBER NOT NULL, /* 글번호 */
	user_no NUMBER, /* 회원번호 */
	title VARCHAR2(100) NOT NULL, /* 제목 */
	writer VARCHAR2(30) NOT NULL, /* 작성자 */
	regdate DATE DEFAULT sysdate, /* 작성일 */
	read NUMBER DEFAULT 0 NULL, /* 조회 */
	content CLOB, /* 글내용 */
	filename VARCHAR2(50), /* 첨부파일 */
	file_size NUMBER DEFAULT 0/* 파일사이즈 */
);

CREATE UNIQUE INDEX idx_board
	ON board (write_no);

ALTER TABLE board
	ADD	CONSTRAINT PK_board
		PRIMARY KEY (write_no);
        
create sequence board_seq
start with 1
increment by 1
nocache;

COMMENT ON TABLE board IS '건의게시판';

COMMENT ON COLUMN board.write_no IS '글번호';

COMMENT ON COLUMN board.user_no IS '회원번호';

COMMENT ON COLUMN board.title IS '제목';

COMMENT ON COLUMN board.writer IS '작성자';

COMMENT ON COLUMN board.regdate IS '작성일';

COMMENT ON COLUMN board.read IS '조회';

COMMENT ON COLUMN board.content IS '글내용';

COMMENT ON COLUMN board.filename IS '첨부파일';

COMMENT ON COLUMN board.file_size IS '파일사이즈';

/* 장바구니 */
CREATE TABLE cart (
	cartno NUMBER, /* 번호 */
	pdcode NUMBER, /* 상품코드 */
	qty NUMBER, /* 개수 */
	user_no NUMBER /* 회원번호 */
    
);

ALTER TABLE cart
	ADD	CONSTRAINT PK_cart
		PRIMARY KEY (cartno);

create sequence cart_seq
start with 1
increment by 1
nocache;

COMMENT ON TABLE cart IS '장바구니';

COMMENT ON COLUMN cart.cartno IS '번호';

COMMENT ON COLUMN cart.pdcode IS '상품코드';

COMMENT ON COLUMN cart.qty IS '개수';

COMMENT ON COLUMN cart.user_no IS '회원번호';


/* 판매자 */
CREATE TABLE sellerinfo (
	seller_no NUMBER NOT NULL, /* 판매자번호 */
	seller_name VARCHAR2(20) NOT NULL, /* 판매자명 */
	seller_nick VARCHAR2(30) NOT NULL, /* 닉네임 */
	seller_id VARCHAR2(30) NOT NULL, /* 판매자아이디 */
	seller_pwd VARCHAR2(30) NOT NULL, /* 판배자비밀번호 */
	seller_tel VARCHAR2(30) NOT NULL, /* 판매자연락처 */
	seller_email VARCHAR2(50) NOT NULL, /* 판매자이메일 */
    seller_zipcode VARCHAR2(100) not null, /* 우편번호 */
	seller_address VARCHAR2(200) NOT NULL, /* 판매자주소 */
	seller_joindate DATE DEFAULT sysdate, /* 가입날짜 */
    seller_class number default 2,
    outdate varchar2(10)
);


CREATE UNIQUE INDEX idx_sellerinfo
	ON sellerinfo (	seller_no );

ALTER TABLE sellerinfo
	ADD	CONSTRAINT PK_sellerinfo
		PRIMARY KEY (seller_no);
        
create sequence sellerinfo_seq
start with 100000000
increment by 1
nocache;

COMMENT ON TABLE sellerinfo IS '판매자';

COMMENT ON COLUMN sellerinfo.seller_no IS '판매자번호';

COMMENT ON COLUMN sellerinfo.seller_name IS '판매자명';

COMMENT ON COLUMN sellerinfo.seller_nick IS '닉네임';

COMMENT ON COLUMN sellerinfo.seller_id IS '판매자아이디';

COMMENT ON COLUMN sellerinfo.seller_pwd IS '판배자비밀번호';

COMMENT ON COLUMN sellerinfo.seller_tel IS '판매자연락처';

COMMENT ON COLUMN sellerinfo.seller_email IS '판매자이메일';

COMMENT ON COLUMN sellerinfo.seller_zipcode IS '판매자우편번호';

COMMENT ON COLUMN sellerinfo.seller_address IS '판매자주소';

COMMENT ON COLUMN sellerinfo.seller_joindate IS '가입날짜';

COMMENT ON COLUMN sellerinfo.seller_class IS '판매자 인식번호';

COMMENT ON COLUMN sellerinfo.outdate IS '탈퇴여부';

ALTER TABLE ProductList
	ADD	CONSTRAINT FK_subproduct_TO_ProductList
		FOREIGN KEY (div_no)
		REFERENCES subproduct (div_no);

ALTER TABLE ProductList
	ADD	CONSTRAINT FK_sellorinfo_TO_ProductList
		FOREIGN KEY (seller_no)
		REFERENCES sellerinfo (seller_no);

ALTER TABLE subproduct
	ADD	CONSTRAINT FK_mainproduct_TO_subproduct
		FOREIGN KEY (maincode)
		REFERENCES mainproduct (maincode);

ALTER TABLE orderinfo
	ADD	CONSTRAINT FK_userinfo_TO_orderinfo
		FOREIGN KEY (user_no)
		REFERENCES userinfo (user_no);

ALTER TABLE orderinfo
	ADD	CONSTRAINT FK_ProductList_TO_orderinfo
		FOREIGN KEY (pdcode)
		REFERENCES productlist(pdcode);

ALTER TABLE board
	ADD	CONSTRAINT FK_userinfo_TO_board
		FOREIGN KEY (user_no)
		REFERENCES userinfo (user_no);

ALTER TABLE cart
	ADD	CONSTRAINT FK_userinfo_TO_cart
		FOREIGN KEY (user_no)
		REFERENCES userinfo (user_no);

ALTER TABLE cart
	ADD	CONSTRAINT FK_ProductList_TO_cart
		FOREIGN KEY (pdcode)
		REFERENCES ProductList (pdcode);
-----
ALTER TABLE ProductList
	DROP
		CONSTRAINT FK_subproduct_TO_ProductList
		CASCADE;

ALTER TABLE ProductList
	DROP
		CONSTRAINT FK_sellorinfo_TO_ProductList
		CASCADE;

ALTER TABLE subproduct
	DROP
		CONSTRAINT FK_mainproduct_TO_subproduct
		CASCADE;

ALTER TABLE orderinfo
	DROP
		CONSTRAINT FK_userinfo_TO_orderinfo
		CASCADE;

ALTER TABLE orderinfo
	DROP
		CONSTRAINT FK_ProductList_TO_orderinfo
		CASCADE;

ALTER TABLE board
	DROP
		CONSTRAINT FK_userinfo_TO_board
		CASCADE;

ALTER TABLE cart
	DROP
		CONSTRAINT FK_userinfo_TO_cart
		CASCADE;

ALTER TABLE cart
	DROP
		CONSTRAINT FK_ProductList_TO_cart
		CASCADE;
        
-------------------------------------
create or replace procedure delete_seller
(
    p_seller_id sellerinfo.seller_id%type,
    p_seller_pwd sellerinfo.seller_pwd%type
)
is
    pe_seller_no number;
begin
    select seller_no into pe_seller_no from sellerinfo
    where seller_id = p_seller_id;
       
    update sellerinfo
    set outdate='Y'
    where seller_id=p_seller_id and seller_pwd=p_seller_pwd;
        
    delete from productlist
    where seller_no=pe_seller_no;
     
    commit;
               
    exception when others then
         raise_application_error(-20202,'판매회원탈퇴 프로시저 오류');
        rollback;
end;
/
create or replace procedure buyorder
(
    p_cartno cart.cartno%type,
    p_userno userinfo.user_no%type,
    p_pdcode productlist.pdcode%type,
    p_qty productlist.qty%type,
    p_delname userinfo.user_name%type,
    p_deltel userinfo.user_tel%TYPE,
    p_add userinfo.user_zipcode%type,
    p_deadd userinfo.user_address%type,
    p_delemail userinfo.user_email%type
)
is
    p_price number;
begin
    select price into p_price from productlist
    where pdcode = p_pdcode;
       
    insert into orderinfo
    values(orderinfo_seq.nextval,p_userno,p_pdcode,sysdate
        ,p_qty,p_qty*p_price,p_delname,p_deltel,p_add,p_deadd,p_delemail,null);
        
    update productlist
    set qty = qty-p_qty
    where pdcode=p_pdcode;
    
    delete from cart
    where cartno = p_cartno;
     
    commit;
               
    exception when others then
         raise_application_error(-20202,'주문 프로시저 오류');
        rollback;
end;