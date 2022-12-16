/* ȸ�� */
CREATE TABLE userinfo (
	user_no NUMBER NOT NULL, /* ȸ����ȣ */
	user_name VARCHAR2(20) NOT NULL, /* ȸ���� */
	user_nick VARCHAR2(30) not null unique, /* �г��� */
	user_id VARCHAR2(30) not null unique, /* ���̵� */
	user_pwd VARCHAR2(30) NOT NULL, /* ��й�ȣ */
	user_tel VARCHAR2(30) not null unique, /* ����ó */
	user_email VARCHAR2(50) not null unique, /* �̸��� */
	user_zipcode VARCHAR2(100) not null, /* �����ȣ */
	user_address VARCHAR2(200) NOT NULL, /* �ּ� */
	user_joindate DATE DEFAULT sysdate, /* ���Գ�¥ */
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

COMMENT ON TABLE userinfo IS 'ȸ��';

COMMENT ON COLUMN userinfo.user_no IS 'ȸ����ȣ';

COMMENT ON COLUMN userinfo.user_name IS 'ȸ����';

COMMENT ON COLUMN userinfo.user_nick IS '�г���';

COMMENT ON COLUMN userinfo.user_id IS '���̵�';

COMMENT ON COLUMN userinfo.user_pwd IS '��й�ȣ';

COMMENT ON COLUMN userinfo.user_tel IS '����ó';

COMMENT ON COLUMN userinfo.user_email IS '�̸���';

COMMENT ON COLUMN userinfo.user_zipcode IS '�����ȣ';

COMMENT ON COLUMN userinfo.user_address IS '�ּ�';

COMMENT ON COLUMN userinfo.user_joindate IS '���Գ�¥';

COMMENT ON COLUMN userinfo.user_class IS '������ �νĹ�ȣ';

COMMENT ON COLUMN userinfo.outdate IS 'Ż�𿩺�';


/* ��ǰ��� */
CREATE TABLE ProductList (
	pdcode NUMBER NOT NULL, /* ��ǰ�ڵ� */
	pdname VARCHAR2(30) NOT NULL, /* ��ǰ�� */
	price NUMBER NOT NULL, /* ���� */
    qty number not null check(qty>=0), /* ��� */
	regdate DATE DEFAULT sysdate NOT NULL, /* ����� */
	seller_no NUMBER NOT NULL, /* �Ǹ��ڹ�ȣ */
	image VARCHAR2(200) not null unique, /* �̹��� */
	detail CLOB NOT NULL, /* �󼼼��� */
	div_no NUMBER NOT NULL /* �Һз��ڵ� */
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
COMMENT ON TABLE ProductList IS '��ǰ���';

COMMENT ON COLUMN ProductList.pdcode IS '��ǰ�ڵ�';

COMMENT ON COLUMN ProductList.pdname IS '��ǰ��';

COMMENT ON COLUMN ProductList.qty IS '���';

COMMENT ON COLUMN ProductList.price IS '����';

COMMENT ON COLUMN ProductList.regdate IS '�����';

COMMENT ON COLUMN ProductList.seller_no IS '�Ǹ��ڹ�ȣ';

COMMENT ON COLUMN ProductList.image IS '�̹���';

COMMENT ON COLUMN ProductList.detail IS '�󼼼���';

COMMENT ON COLUMN ProductList.div_no IS '�Һз��ڵ�';

/* ��ǰ��з� */
CREATE TABLE mainproduct (
	maincode NUMBER NOT NULL, /* ��з��ڵ� */
	mainname VARCHAR2(30) NOT NULL unique /* ��з��̸� */
);

CREATE UNIQUE INDEX idx_mainproduct
	ON mainproduct (maincode);

ALTER TABLE mainproduct
	ADD CONSTRAINT PK_mainproduct
		PRIMARY KEY (maincode);
        
COMMENT ON TABLE mainproduct IS '��ǰ��з�';

COMMENT ON COLUMN mainproduct.maincode IS '��з��ڵ�';

COMMENT ON COLUMN mainproduct.mainname IS '��з��̸�';


/* ��ǰ�Һз� */
CREATE TABLE subproduct (
	div_no NUMBER NOT NULL, /* �Һз��ڵ� */
	subproduct_name VARCHAR2(50) NOT NULL unique, /* ��ǰ�� */
	maincode NUMBER NOT NULL /* ��з��ڵ� */
);

CREATE UNIQUE INDEX idx_subproduct
	ON subproduct (div_no);

ALTER TABLE subproduct
	ADD	CONSTRAINT PK_subproduct
		PRIMARY KEY (div_no);
        
COMMENT ON TABLE subproduct IS '��ǰ�Һз�';

COMMENT ON COLUMN subproduct.div_no IS '�Һз��ڵ�';

COMMENT ON COLUMN subproduct.subproduct_name IS '��ǰ��';

COMMENT ON COLUMN subproduct.maincode IS '��з��ڵ�';



/* �ֹ����� */
CREATE TABLE orderinfo (
	order_no NUMBER NOT NULL, /* �ֹ���ȣ */
	user_no NUMBER NOT NULL, /* ȸ����ȣ */
	pdcode NUMBER NOT NULL, /* ��ǰ�ڵ� */
	orderdate DATE DEFAULT sysdate, /* �ֹ��� */
	qty NUMBER NOT NULL, /* ��ǰ���� */
	totalprice NUMBER NOT NULL, /* �ѱݾ� */
	del_name VARCHAR2(20) NOT NULL, /* ��۹޴»���̸� */
	del_tel VARCHAR2(20) NOT NULL, /* ��۹޴¿���ó */
	del_add VARCHAR2(100) NOT NULL, /* ��۹޴��ּ� */
	del_deadd VARCHAR2(200) NOT NULL, /* ��۹޴»��ּ� */
	del_email VARCHAR2(30) NOT NULL, /* ��۹޴��̸��� */
	refund_mgno NUMBER /* ȯ�ҹ�ȣ */
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

COMMENT ON TABLE orderinfo IS '�ֹ�����';

COMMENT ON COLUMN orderinfo.order_no IS '�ֹ���ȣ';

COMMENT ON COLUMN orderinfo.user_no IS 'ȸ����ȣ';

COMMENT ON COLUMN orderinfo.pdcode IS '��ǰ�ڵ�';

COMMENT ON COLUMN orderinfo.orderdate IS '�ֹ���';

COMMENT ON COLUMN orderinfo.qty IS '��ǰ����';

COMMENT ON COLUMN orderinfo.totalprice IS '�ѱݾ�';

COMMENT ON COLUMN orderinfo.del_name IS '��۹޴»���̸�';

COMMENT ON COLUMN orderinfo.del_tel IS '��۹޴¿���ó';

COMMENT ON COLUMN orderinfo.del_add IS '��۹޴����ڵ�';

COMMENT ON COLUMN orderinfo.del_deadd IS '��۹޴»��ּ�';

COMMENT ON COLUMN orderinfo.del_email IS '��۹޴��̸���';

COMMENT ON COLUMN orderinfo.refund_mgno IS 'ȯ�ҹ�ȣ';


/* ���ǰԽ��� */
CREATE TABLE board (
	write_no NUMBER NOT NULL, /* �۹�ȣ */
	user_no NUMBER, /* ȸ����ȣ */
	title VARCHAR2(100) NOT NULL, /* ���� */
	writer VARCHAR2(30) NOT NULL, /* �ۼ��� */
	regdate DATE DEFAULT sysdate, /* �ۼ��� */
	read NUMBER DEFAULT 0 NULL, /* ��ȸ */
	content CLOB, /* �۳��� */
	filename VARCHAR2(50), /* ÷������ */
	file_size NUMBER DEFAULT 0/* ���ϻ����� */
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

COMMENT ON TABLE board IS '���ǰԽ���';

COMMENT ON COLUMN board.write_no IS '�۹�ȣ';

COMMENT ON COLUMN board.user_no IS 'ȸ����ȣ';

COMMENT ON COLUMN board.title IS '����';

COMMENT ON COLUMN board.writer IS '�ۼ���';

COMMENT ON COLUMN board.regdate IS '�ۼ���';

COMMENT ON COLUMN board.read IS '��ȸ';

COMMENT ON COLUMN board.content IS '�۳���';

COMMENT ON COLUMN board.filename IS '÷������';

COMMENT ON COLUMN board.file_size IS '���ϻ�����';

/* ��ٱ��� */
CREATE TABLE cart (
	cartno NUMBER, /* ��ȣ */
	pdcode NUMBER, /* ��ǰ�ڵ� */
	qty NUMBER, /* ���� */
	user_no NUMBER /* ȸ����ȣ */
    
);

ALTER TABLE cart
	ADD	CONSTRAINT PK_cart
		PRIMARY KEY (cartno);

create sequence cart_seq
start with 1
increment by 1
nocache;

COMMENT ON TABLE cart IS '��ٱ���';

COMMENT ON COLUMN cart.cartno IS '��ȣ';

COMMENT ON COLUMN cart.pdcode IS '��ǰ�ڵ�';

COMMENT ON COLUMN cart.qty IS '����';

COMMENT ON COLUMN cart.user_no IS 'ȸ����ȣ';


/* �Ǹ��� */
CREATE TABLE sellerinfo (
	seller_no NUMBER NOT NULL, /* �Ǹ��ڹ�ȣ */
	seller_name VARCHAR2(20) NOT NULL, /* �Ǹ��ڸ� */
	seller_nick VARCHAR2(30) NOT NULL, /* �г��� */
	seller_id VARCHAR2(30) NOT NULL, /* �Ǹ��ھ��̵� */
	seller_pwd VARCHAR2(30) NOT NULL, /* �ǹ��ں�й�ȣ */
	seller_tel VARCHAR2(30) NOT NULL, /* �Ǹ��ڿ���ó */
	seller_email VARCHAR2(50) NOT NULL, /* �Ǹ����̸��� */
    seller_zipcode VARCHAR2(100) not null, /* �����ȣ */
	seller_address VARCHAR2(200) NOT NULL, /* �Ǹ����ּ� */
	seller_joindate DATE DEFAULT sysdate, /* ���Գ�¥ */
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

COMMENT ON TABLE sellerinfo IS '�Ǹ���';

COMMENT ON COLUMN sellerinfo.seller_no IS '�Ǹ��ڹ�ȣ';

COMMENT ON COLUMN sellerinfo.seller_name IS '�Ǹ��ڸ�';

COMMENT ON COLUMN sellerinfo.seller_nick IS '�г���';

COMMENT ON COLUMN sellerinfo.seller_id IS '�Ǹ��ھ��̵�';

COMMENT ON COLUMN sellerinfo.seller_pwd IS '�ǹ��ں�й�ȣ';

COMMENT ON COLUMN sellerinfo.seller_tel IS '�Ǹ��ڿ���ó';

COMMENT ON COLUMN sellerinfo.seller_email IS '�Ǹ����̸���';

COMMENT ON COLUMN sellerinfo.seller_zipcode IS '�Ǹ��ڿ����ȣ';

COMMENT ON COLUMN sellerinfo.seller_address IS '�Ǹ����ּ�';

COMMENT ON COLUMN sellerinfo.seller_joindate IS '���Գ�¥';

COMMENT ON COLUMN sellerinfo.seller_class IS '�Ǹ��� �νĹ�ȣ';

COMMENT ON COLUMN sellerinfo.outdate IS 'Ż�𿩺�';

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
         raise_application_error(-20202,'�Ǹ�ȸ��Ż�� ���ν��� ����');
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
         raise_application_error(-20202,'�ֹ� ���ν��� ����');
        rollback;
end;