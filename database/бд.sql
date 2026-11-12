--
-- PostgreSQL database dump
--

\restrict lRya5uqGvbf3sHYoNiv6AagcVHa2dca50KDdipd3vxcV4ATqfnL8h3Wasoqbf3N

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-31 18:54:43

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 24721)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id_category integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24720)
-- Name: categories_id_category_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_category_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_category_seq OWNER TO postgres;

--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_id_category_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_category_seq OWNED BY public.categories.id_category;


--
-- TOC entry 238 (class 1259 OID 24830)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id_item integer NOT NULL,
    id_orders integer NOT NULL,
    id_product integer NOT NULL,
    id_size integer NOT NULL,
    kolichestvo integer NOT NULL,
    cena_edinica numeric(12,2) NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 24829)
-- Name: order_items_id_item_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_item_seq OWNER TO postgres;

--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_items_id_item_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_item_seq OWNED BY public.order_items.id_item;


--
-- TOC entry 236 (class 1259 OID 24812)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id_orders integer NOT NULL,
    number_zakaz integer NOT NULL,
    date_zakaz date NOT NULL,
    id_users integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 24811)
-- Name: orders_id_orders_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_orders_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_orders_seq OWNER TO postgres;

--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 235
-- Name: orders_id_orders_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_orders_seq OWNED BY public.orders.id_orders;


--
-- TOC entry 232 (class 1259 OID 24759)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id_product integer NOT NULL,
    id_category integer NOT NULL,
    id_subcategory integer NOT NULL,
    id_proizvod integer NOT NULL,
    image character varying(250),
    opisanie text,
    sostav text,
    price numeric(12,2) NOT NULL,
    name text
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 24758)
-- Name: products_id_product_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_product_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_product_seq OWNER TO postgres;

--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 231
-- Name: products_id_product_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_product_seq OWNED BY public.products.id_product;


--
-- TOC entry 228 (class 1259 OID 24739)
-- Name: proizvodstvo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.proizvodstvo (
    id_proizvod integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.proizvodstvo OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24738)
-- Name: proizvodstvo_id_proizvod_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.proizvodstvo_id_proizvod_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.proizvodstvo_id_proizvod_seq OWNER TO postgres;

--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 227
-- Name: proizvodstvo_id_proizvod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.proizvodstvo_id_proizvod_seq OWNED BY public.proizvodstvo.id_proizvod;


--
-- TOC entry 220 (class 1259 OID 24694)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id_role integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24693)
-- Name: roles_id_role_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_role_seq OWNER TO postgres;

--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_role_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_role_seq OWNED BY public.roles.id_role;


--
-- TOC entry 230 (class 1259 OID 24748)
-- Name: size; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.size (
    id_size integer NOT NULL,
    size_value numeric(4,1) NOT NULL
);


ALTER TABLE public.size OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24747)
-- Name: size_id_size_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.size_id_size_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.size_id_size_seq OWNER TO postgres;

--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 229
-- Name: size_id_size_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.size_id_size_seq OWNED BY public.size.id_size;


--
-- TOC entry 234 (class 1259 OID 24789)
-- Name: stock_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_items (
    id_stock integer NOT NULL,
    id_product integer NOT NULL,
    id_size integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.stock_items OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 24788)
-- Name: stock_items_id_stock_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_items_id_stock_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_items_id_stock_seq OWNER TO postgres;

--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 233
-- Name: stock_items_id_stock_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_items_id_stock_seq OWNED BY public.stock_items.id_stock;


--
-- TOC entry 226 (class 1259 OID 24730)
-- Name: subcategories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subcategories (
    id_subcategory integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.subcategories OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24729)
-- Name: subcategories_id_subcategory_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subcategories_id_subcategory_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subcategories_id_subcategory_seq OWNER TO postgres;

--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 225
-- Name: subcategories_id_subcategory_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subcategories_id_subcategory_seq OWNED BY public.subcategories.id_subcategory;


--
-- TOC entry 222 (class 1259 OID 24703)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_users integer NOT NULL,
    familiya character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    otchestvo character varying(100),
    login character varying(50) NOT NULL,
    id_role integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24702)
-- Name: users_id_users_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_users_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_users_seq OWNER TO postgres;

--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_users_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_users_seq OWNED BY public.users.id_users;


--
-- TOC entry 4802 (class 2604 OID 24724)
-- Name: categories id_category; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id_category SET DEFAULT nextval('public.categories_id_category_seq'::regclass);


--
-- TOC entry 4809 (class 2604 OID 24833)
-- Name: order_items id_item; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id_item SET DEFAULT nextval('public.order_items_id_item_seq'::regclass);


--
-- TOC entry 4808 (class 2604 OID 24815)
-- Name: orders id_orders; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id_orders SET DEFAULT nextval('public.orders_id_orders_seq'::regclass);


--
-- TOC entry 4806 (class 2604 OID 24762)
-- Name: products id_product; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id_product SET DEFAULT nextval('public.products_id_product_seq'::regclass);


--
-- TOC entry 4804 (class 2604 OID 24742)
-- Name: proizvodstvo id_proizvod; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proizvodstvo ALTER COLUMN id_proizvod SET DEFAULT nextval('public.proizvodstvo_id_proizvod_seq'::regclass);


--
-- TOC entry 4800 (class 2604 OID 24697)
-- Name: roles id_role; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id_role SET DEFAULT nextval('public.roles_id_role_seq'::regclass);


--
-- TOC entry 4805 (class 2604 OID 24751)
-- Name: size id_size; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.size ALTER COLUMN id_size SET DEFAULT nextval('public.size_id_size_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 24792)
-- Name: stock_items id_stock; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_items ALTER COLUMN id_stock SET DEFAULT nextval('public.stock_items_id_stock_seq'::regclass);


--
-- TOC entry 4803 (class 2604 OID 24733)
-- Name: subcategories id_subcategory; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategories ALTER COLUMN id_subcategory SET DEFAULT nextval('public.subcategories_id_subcategory_seq'::regclass);


--
-- TOC entry 4801 (class 2604 OID 24706)
-- Name: users id_users; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id_users SET DEFAULT nextval('public.users_id_users_seq'::regclass);


--
-- TOC entry 5000 (class 0 OID 24721)
-- Dependencies: 224
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories (id_category, name) VALUES (1, 'Детская обувь');
INSERT INTO public.categories (id_category, name) VALUES (2, 'Мужская обувь');
INSERT INTO public.categories (id_category, name) VALUES (3, 'Женская обувь');


--
-- TOC entry 5014 (class 0 OID 24830)
-- Dependencies: 238
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5012 (class 0 OID 24812)
-- Dependencies: 236
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5008 (class 0 OID 24759)
-- Dependencies: 232
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (1, 1, 1, 1, 'IMG_KS_195217.png', 'Кроссовки детские «Звёздочка» экокожа. Производитель: ООО «Малыш-Спорт», г. Смоленск', 'Верх — экокожа (полиуретан на хлопковой основе), подкладка — хлопок 100%, подошва — ПВХ', 2190.00, 'Кроссовки детские «Звёздочка» экокожа');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (2, 1, 1, 6, 'IMG_KS_195213.png', 'Кроссовки детские «Гонщик» экокожа. Производитель: Фабрика «Топ-Топ», г. Киров', 'Верх — экокожа (микрофибра), подкладка — текстиль сетчатый (полиэстер), подошва — термопластичная резина (ТЭП)', 2490.00, 'Кроссовки детские «Гонщик» экокожа');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (3, 1, 1, 14, 'IMG_KS_195222.png', 'Кроссовки детские «Радуга» экокожа перфорированная. Производитель: ИП Смирнова Л.В. (бренд «Лапушка»), г. Вологда', 'Верх — экокожа перфорированная, вставки — нейлон, стелька — ортопедическая с латексной подушкой, подошва — ЭВА', 1990.00, 'Кроссовки детские «Радуга» экокожа перфорированная');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (4, 1, 2, 15, 'IMG_KB_185501.png', 'Сапожки детские «Снежинка» зимние на меху. Производитель: ООО «Тёплые ножки», г. Новосибирск', 'Верх — экокожа морозостойкая, утеплитель — искусственный мех (акрил 70%, полиэстер 30%), подкладка — флис, подошва — термоэластопласт (ТЭП)', 3490.00, 'Сапожки детские «Снежинка» зимние на меху');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (5, 1, 2, 13, 'IMG_KB_164816.png', 'Сапожки детские «Медвежонок» демисезонные непромокаемые. Производитель: Компания «Северята», г. Архангельск', 'Верх — плащёвая ткань с водоотталкивающей пропиткой (полиэстер 100%), отделка — экокожа, подкладка — микрофибра, мембрана — AirTex, подошва — резина', 3190.00, 'Сапожки детские «Медвежонок» демисезонные непромокаемые');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (6, 1, 2, 10, 'IMG_KB_164811.png', 'Сапожки детские «Принцесса» кожаные. Производитель: Мастерская «Весна», г. Тула', 'Верх — натуральная кожа (КРС), подкладка — шерсть натуральная (70%), байка (30%), стелька — войлочная, подошва — полиуретан', 4290.00, 'Сапожки детские «Принцесса» кожаные');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (7, 1, 3, 2, 'IMG_KSd_195207.png', 'Сандалии детские «Пчёлка» ортопедические летние. Производитель: ООО «Здоровый шаг», г. Воронеж', 'Верх — нубук натуральный, подкладка — кожа растительного дубления, стелька — анатомическая с супинатором (латекс + пробка), подошва — каучук', 2790.00, 'Сандалии детские «Пчёлка» ортопедические летние');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (8, 1, 3, 11, 'IMG_KSd_185508.png', 'Сандалии детские «Морячок» текстильные с фиксатором. Производитель: ИП Кузнецов А.Д. (бренд «Карапуз»), г. Краснодар', 'Верх — джинсовая ткань (хлопок 100%), окантовка — искусственная кожа, подкладка — хлопок, подошва — ЭВА лёгкая', 1690.00, 'Сандалии детские «Морячок» текстильные с фиксатором');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (9, 1, 4, 16, 'IMG_KSho_185512.png', 'Туфли детские «Бантик» лаковые праздничные. Производитель: Дом обуви «Маленький франт», г. Москва', 'Верх — искусственная лаковая кожа (ПВХ), носок усиленный — термопластичный полиуретан, подкладка — кожа искусственная дышащая, стелька — анатомическая с амортизацией, подошва — полиуретан', 2390.00, 'Туфли детские «Бантик» лаковые праздничные');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (10, 3, 2, 3, 'IMG_WB_170905.png', 'Сапоги женские зимние, нескользящая, устойчивая подошва, натуральный мех. Производитель: Дом обуви «Барбари», г. Новороссийск ', 'Верх — натуральная кожа, подкладка — евромех, натуральный мех, текстильный утеплитель, подошва — резина', 25000.00, 'Сапоги зимние натуральная кожа');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (11, 3, 2, 3, 'IMG_WB_170859.png', 'Сапоги женские демисезонные из высококачественной натуральной кожи. Производитель: Дом обуви «Барбари», г. Новороссийск ', 'Верх — натуральная кожа, подкладка — текстильный утеплитель, стелька — текстиль, подошва — ТПР', 15000.00, 'Сапоги осенние натуральная кожа');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (12, 3, 2, 5, 'IMG_WB_170906.png', 'Сапоги женские демисезонные замшевые. Производитель: ОАО «Твой комфорт», г. Ярославль', 'Верх — натуральная замша, утепленные, тракторная подошва, стелька — байка, подошва — резина', 17000.00, 'Сапоги трубы демисезонные замшевые');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (13, 3, 3, 4, 'IMG_WSd_174332.png', 'Коричневая кожаная модель с открытым носком, боковой пряжкой и закрытым каблуком. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', 'Верх — 100% козья кожа, подкладка — 100% кожа; подошва: 100% кожа', 7500.00, 'Босоножки «Песчаный берег» коричневые');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (14, 3, 3, 7, 'IMG_WSd_185156.png', 'Открытый носок и ремешок со сборной пряжкой, низкий каблук и резиновая подошва гарантируют комфорт. Производитель: ЗАО «Кожевенные традиции», г. Вятка', 'Верх — кожа собственного производств, подкладка — кожа; подошва: резина', 5600.00, 'Женские босоножки «Черный кофе» со скульптурным каблуком');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (15, 3, 3, 8, 'IMG_WSd_185551.png', 'Босоножки женские кожаные белые, регулируемый ремешок, закрытый каблук и кожаная подошва. Производитель: ООО «Модный силуэт», г. Кострома', 'Верх — натуральная кожа, подкладка — натуральная кожа, подошва — кожа', 7130.00, 'Босоножки женские «Летний бриз»');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (16, 3, 4, 8, 'IMG_WSho_174409.png', 'Комфортные лаконичные лодочки, классический дизайна с современными акцентами. Производитель: ООО «Модный силуэт», г. Кострома', 'Верх — натуральная овечья кожа, подкладка и стелька — натуральная овечья кожа, подошва — резина', 12340.00, 'Демисезонные туфли натуральная кожа');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (17, 3, 4, 7, 'IMG_WSho_185202.png', 'Стильные туфли для весеннего и летнего сезона. Производитель: ЗАО «Кожевенные традиции», г. Вятка', 'Верх — натуральная телячьей кожа, металлическая пряжка, подкладка и стелька— натуральная овечья кожа, подошва — резина', 7757.00, 'Туфли женские натуральная кожа с металлическими вставками');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (18, 3, 4, 4, 'IMG_WSho_185545.png', 'Модель из натуральной кожи, классический острый носок и изящная шпилька. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', 'Верх — натуральная кожа, подкладка и стелька — натуральная кожа, подошва — тунит', 7550.00, 'Туфли классические лодочки натуральная кожа');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (19, 3, 1, 6, 'IMG_WS_174110.png', 'Многослойный верх из кожи и текстиля. Производитель: Фабрика «Топ-Топ», г. Киров', 'Верх — 70% кожа, 30% текстиль, подкладка — текстиль, подошва — резина', 9450.00, 'Кроссовки белые с оранжевым и красным');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (20, 3, 1, 6, 'IMG_WS_185528.png', 'Уверенность на каждом шагу. Материал обеспечивает долговечность и комфорт при носке. Производитель: Фабрика «Топ-Топ», г. Киров', 'Верх — 87% кожа, 11% текстиль, 2% синтетика; подкладка: 100% текстиль; подошва: резина, пластик', 8565.00, 'Кроссовки летние кожаные');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (21, 3, 1, 4, 'IMG_WS_185535.png', 'Кроссовки женские из натуральной кожи. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', 'Верх — натуральная кожа, подкладка — кожа, подошва — полиуретан', 8765.00, 'Кроссовки кожаные');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (22, 3, 1, 4, 'IMG_WS_185538.png', 'Кроссовки женские из натуральной кожи и синтетических материалов, сетчатые вставки. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', 'Верх — 70% кожа, 20% полиамид, 10% полиуретан; подкладка — текстиль, подошва — ТПУ', 7795.00, 'Кроссовки «Стиль и комфорт»');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (23, 2, 1, 9, 'IMG_MS_185531.png', 'Сочетание стиля, комфорта и современных технологий. Производитель: Фабрика «Азимут», г. Санкт-Петербург', 'Верх —  сетка, подкладка — текстиль, подошва —  резина', 6550.00, 'Кроссовки для бега «Драйв»');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (24, 2, 1, 9, 'IMG_MS_185532.png', 'Универсальный выбор для повседневного использования. Производитель: Фабрика «Азимут», г. Санкт-Петербург', 'Верх — 6% кожа, 29% текстиль, 15% полимерные материалы; подкладка — 100% текстиль; подошва — полимерные материалы, резина', 7890.00, 'Кроссовки «Азимут Бег»');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (25, 2, 1, 6, 'IMG_MS_185533.png', 'Кроссовки для мужчин, идеальное сочетание стиля и комфорта. Производитель: Фабрика «Топ-Топ», г. Киров', 'Верх — 56% кожа, 29% текстиль, 15% полимерные материалы; подкладка — 100% текстиль; подошва — полимерные материалы, резина', 9567.00, 'Кроссовки');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (26, 2, 4, 3, 'IMG_MSho_190514.png', 'Модель выполнена из натуральной кожи, на резиновой подошве. Производитель: Дом обуви «Барбари», г. Новороссийск ', 'Верх — натуральная кожа, подкладка — текстиль, стелька — натуральная кожа, подошва — резина', 24569.00, 'Черные туфли в классическом стиле');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (27, 2, 4, 12, 'IMG_MSho_190518.png', 'Туфли на низком каблуке кожаные', 'Верх — натуральная кожа, подкладка — текстиль, стелька — натуральная кожа, подошва — ТЭП', 10155.00, 'Туфли мужские светлые классика демисезонные');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (28, 2, 4, 12, 'IMG_MSho_191612.png', 'Модель выполнена из натуральной кожи, на резиновой подошве, поддеживает классический и деловой стиль образов. Производитель: Дом обуви «Берестов», г. Москва', 'Верх — натуральная кожа, подкладка — натуральная кожа, стелька — натуральная кожа, подошва — резина', 25625.00, 'Туфли из натуральной кожи');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (29, 2, 5, 3, 'IMG_MB_174349.png', 'Ботинки из натуральной кожи темно-коричневого и черного цвета на шнурках. Производитель: Дом обуви «Берестов», г. Москва', 'Верх — натуральная кожа, подкладка — текстиль, подошва — искусственный материал', 21500.00, 'Ботинки мужские демисезонные');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (30, 2, 5, 7, 'IMG_MB_191200.png', 'Ботинки представляют баланс традиций и современности. Выполнены из натуральной кожи насыщенного черного цвета. Производитель: ЗАО «Кожевенные традиции», г. Вятка', 'Верх — натуральная кожа, подкладка — ворсин, стелька — ворсин, подошва — тунит', 14567.00, 'Ботинки черные из натуральной кожи');
INSERT INTO public.products (id_product, id_category, id_subcategory, id_proizvod, image, opisanie, sostav, price, name) VALUES (31, 2, 5, 3, 'IMG_MB_191205.png', 'Выбор на каждый день — натуральная кожа, натуральный мех. Производитель: Дом обуви «Барбари», г. Новороссийск ', 'Верх — натуральная кожа, подкладка — натуральный мех, стелька — натуральный мех, подошва — ТЭП', 15670.00, 'Ботинки зимние классические');


--
-- TOC entry 5004 (class 0 OID 24739)
-- Dependencies: 228
-- Data for Name: proizvodstvo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (1, 'Малыш-Спорт');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (2, 'Здоровый шаг');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (3, 'Барбари');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (4, 'Стиль и комфорт');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (5, 'Твой комфорт');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (6, 'Топ-Топ');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (7, 'Кожевенные традиции');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (8, 'Модный силуэт');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (9, 'Азимут');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (10, 'Весна');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (11, 'Карапуз');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (12, 'Берестов');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (13, 'Северята');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (14, 'Лапушка');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (15, 'Тёплые ножки');
INSERT INTO public.proizvodstvo (id_proizvod, name) VALUES (16, 'Маленький франт');


--
-- TOC entry 4996 (class 0 OID 24694)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles (id_role, name) VALUES (1, 'Администратор');
INSERT INTO public.roles (id_role, name) VALUES (2, 'Менеджер');
INSERT INTO public.roles (id_role, name) VALUES (3, 'Авторизованный пользователь');


--
-- TOC entry 5006 (class 0 OID 24748)
-- Dependencies: 230
-- Data for Name: size; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.size (id_size, size_value) VALUES (1, 18.0);
INSERT INTO public.size (id_size, size_value) VALUES (2, 19.0);
INSERT INTO public.size (id_size, size_value) VALUES (3, 20.0);
INSERT INTO public.size (id_size, size_value) VALUES (4, 21.0);
INSERT INTO public.size (id_size, size_value) VALUES (5, 22.0);
INSERT INTO public.size (id_size, size_value) VALUES (6, 23.0);
INSERT INTO public.size (id_size, size_value) VALUES (7, 24.0);
INSERT INTO public.size (id_size, size_value) VALUES (8, 25.0);
INSERT INTO public.size (id_size, size_value) VALUES (9, 26.0);
INSERT INTO public.size (id_size, size_value) VALUES (10, 27.0);
INSERT INTO public.size (id_size, size_value) VALUES (11, 28.0);
INSERT INTO public.size (id_size, size_value) VALUES (12, 29.0);
INSERT INTO public.size (id_size, size_value) VALUES (13, 30.0);
INSERT INTO public.size (id_size, size_value) VALUES (14, 31.0);
INSERT INTO public.size (id_size, size_value) VALUES (15, 32.0);
INSERT INTO public.size (id_size, size_value) VALUES (16, 33.0);
INSERT INTO public.size (id_size, size_value) VALUES (17, 34.0);
INSERT INTO public.size (id_size, size_value) VALUES (18, 35.0);
INSERT INTO public.size (id_size, size_value) VALUES (19, 36.0);
INSERT INTO public.size (id_size, size_value) VALUES (20, 36.5);
INSERT INTO public.size (id_size, size_value) VALUES (21, 37.0);
INSERT INTO public.size (id_size, size_value) VALUES (22, 37.5);
INSERT INTO public.size (id_size, size_value) VALUES (23, 38.0);
INSERT INTO public.size (id_size, size_value) VALUES (24, 38.5);
INSERT INTO public.size (id_size, size_value) VALUES (25, 39.0);
INSERT INTO public.size (id_size, size_value) VALUES (26, 39.5);
INSERT INTO public.size (id_size, size_value) VALUES (27, 40.0);
INSERT INTO public.size (id_size, size_value) VALUES (28, 40.5);
INSERT INTO public.size (id_size, size_value) VALUES (29, 41.0);
INSERT INTO public.size (id_size, size_value) VALUES (30, 41.5);
INSERT INTO public.size (id_size, size_value) VALUES (31, 42.0);
INSERT INTO public.size (id_size, size_value) VALUES (32, 42.5);
INSERT INTO public.size (id_size, size_value) VALUES (33, 43.0);
INSERT INTO public.size (id_size, size_value) VALUES (34, 44.0);
INSERT INTO public.size (id_size, size_value) VALUES (35, 45.0);


--
-- TOC entry 5010 (class 0 OID 24789)
-- Dependencies: 234
-- Data for Name: stock_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (1, 1, 3, 20);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (2, 1, 2, 20);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (3, 1, 5, 20);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (4, 1, 6, 20);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (5, 1, 7, 20);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (6, 1, 8, 20);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (7, 2, 16, 2);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (8, 2, 17, 2);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (9, 3, 2, 30);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (10, 3, 3, 30);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (11, 4, 2, 15);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (12, 4, 3, 15);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (13, 5, 4, 5);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (14, 5, 22, 5);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (15, 5, 23, 5);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (16, 6, 18, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (17, 6, 19, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (18, 6, 20, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (19, 7, 21, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (20, 7, 22, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (21, 7, 23, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (22, 7, 24, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (23, 8, 27, 7);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (24, 8, 11, 7);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (25, 8, 12, 7);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (26, 8, 13, 7);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (27, 9, 1, 7);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (28, 9, 2, 7);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (29, 9, 3, 7);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (30, 10, 19, 12);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (31, 10, 21, 12);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (32, 11, 25, 2);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (33, 11, 27, 2);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (34, 12, 21, 5);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (35, 12, 25, 5);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (36, 12, 27, 5);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (37, 13, 19, 10);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (38, 13, 21, 10);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (39, 13, 23, 10);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (40, 13, 25, 10);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (41, 13, 27, 10);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (42, 14, 18, 3);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (43, 15, 21, 23);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (44, 15, 25, 23);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (45, 15, 27, 23);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (46, 16, 19, 25);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (47, 16, 21, 25);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (48, 16, 23, 25);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (49, 17, 19, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (50, 17, 23, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (51, 17, 25, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (52, 17, 27, 4);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (53, 18, 18, 9);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (54, 18, 23, 9);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (55, 19, 18, 2);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (56, 19, 19, 2);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (57, 20, 21, 5);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (58, 20, 22, 5);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (59, 20, 23, 5);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (60, 20, 24, 5);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (61, 21, 18, 16);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (62, 21, 19, 16);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (63, 21, 23, 16);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (64, 21, 25, 16);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (65, 22, 18, 3);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (66, 22, 23, 3);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (67, 23, 30, 18);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (68, 23, 31, 18);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (69, 23, 32, 18);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (70, 23, 33, 18);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (71, 24, 23, 50);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (72, 24, 24, 50);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (73, 24, 25, 50);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (74, 24, 26, 50);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (75, 24, 27, 50);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (76, 24, 29, 50);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (77, 25, 29, 3);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (78, 25, 31, 3);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (79, 25, 34, 3);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (80, 26, 27, 23);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (81, 26, 29, 23);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (82, 26, 33, 23);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (83, 27, 31, 15);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (84, 27, 33, 15);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (85, 27, 34, 15);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (86, 28, 34, 3);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (87, 29, 29, 1);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (88, 29, 31, 1);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (89, 30, 31, 20);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (90, 30, 33, 20);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (91, 31, 12, 30);
INSERT INTO public.stock_items (id_stock, id_product, id_size, quantity) VALUES (92, 31, 14, 30);


--
-- TOC entry 5002 (class 0 OID 24730)
-- Dependencies: 226
-- Data for Name: subcategories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subcategories (id_subcategory, name) VALUES (1, 'Кроссовки');
INSERT INTO public.subcategories (id_subcategory, name) VALUES (2, 'Сапоги');
INSERT INTO public.subcategories (id_subcategory, name) VALUES (3, 'Босоножки');
INSERT INTO public.subcategories (id_subcategory, name) VALUES (4, 'Туфли');
INSERT INTO public.subcategories (id_subcategory, name) VALUES (5, 'Ботинки');


--
-- TOC entry 4998 (class 0 OID 24703)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (1, 'Иванов', 'Иван', 'Сергеевич', 'isivanov', 1);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (2, 'Петров', 'Пётр', 'Алексеевич', 'papetrov', 2);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (3, 'Сидорова', 'Анна', 'Дмитриевна', 'asidorova', 3);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (4, 'Кузнецова', 'Екатерина', 'Андреевна', 'ekuznetsova', 2);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (5, 'Смирнов', 'Дмитрий', 'Владимирович', 'dsmirnov', 3);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (6, 'Попов', 'Алексей', 'Николаевич', 'apopov', 1);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (7, 'Васильева', 'Ольга', 'Игоревна', 'ovasileva', 3);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (8, 'Соколов', 'Павел', 'Викторович', 'psokolov', 2);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (9, 'Михайлова', 'Татьяна', 'Юрьевна', 'tmikhailova', 3);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (10, 'Новикова', 'Наталья', 'Сергеевна', 'nnovikova', 2);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (11, 'Фёдоров', 'Андрей', 'Максимович', 'afedorov', 1);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (12, 'Морозов', 'Сергей', 'Павлович', 'smorozov', 3);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (13, 'Волкова', 'Юлия', 'Александровна', 'jvolkova', 2);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (14, 'Алексеев', 'Артём', 'Евгеньевич', 'aalekseev', 3);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (15, 'Лебедева', 'Ирина', 'Владимировна', 'ilebedeva', 3);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (16, 'Егоров', 'Никита', 'Денисович', 'negorov', 2);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (17, 'Павлова', 'Елена', 'Петровна', 'epavlova', 3);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (18, 'Козлов', 'Роман', 'Олегович', 'rkozlov', 1);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (19, 'Степанова', 'Виктория', 'Романовна', 'vstepanova', 2);
INSERT INTO public.users (id_users, familiya, name, otchestvo, login, id_role) VALUES (20, 'Николаев', 'Владимир', 'Иванович', 'vnikolaev', 3);


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_id_category_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_category_seq', 1, false);


--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_items_id_item_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_item_seq', 1, false);


--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 235
-- Name: orders_id_orders_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_orders_seq', 1, false);


--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 231
-- Name: products_id_product_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_product_seq', 1, false);


--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 227
-- Name: proizvodstvo_id_proizvod_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.proizvodstvo_id_proizvod_seq', 1, false);


--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_role_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_role_seq', 1, false);


--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 229
-- Name: size_id_size_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.size_id_size_seq', 1, false);


--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 233
-- Name: stock_items_id_stock_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_items_id_stock_seq', 1, false);


--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 225
-- Name: subcategories_id_subcategory_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subcategories_id_subcategory_seq', 1, false);


--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_users_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_users_seq', 1, false);


--
-- TOC entry 4817 (class 2606 OID 24728)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id_category);


--
-- TOC entry 4837 (class 2606 OID 24841)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id_item);


--
-- TOC entry 4833 (class 2606 OID 24823)
-- Name: orders orders_number_zakaz_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_number_zakaz_key UNIQUE (number_zakaz);


--
-- TOC entry 4835 (class 2606 OID 24821)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id_orders);


--
-- TOC entry 4827 (class 2606 OID 24772)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id_product);


--
-- TOC entry 4821 (class 2606 OID 24746)
-- Name: proizvodstvo proizvodstvo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.proizvodstvo
    ADD CONSTRAINT proizvodstvo_pkey PRIMARY KEY (id_proizvod);


--
-- TOC entry 4811 (class 2606 OID 24701)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_role);


--
-- TOC entry 4823 (class 2606 OID 24755)
-- Name: size size_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.size
    ADD CONSTRAINT size_pkey PRIMARY KEY (id_size);


--
-- TOC entry 4825 (class 2606 OID 24757)
-- Name: size size_size_value_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.size
    ADD CONSTRAINT size_size_value_key UNIQUE (size_value);


--
-- TOC entry 4829 (class 2606 OID 24800)
-- Name: stock_items stock_items_id_product_id_size_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_items
    ADD CONSTRAINT stock_items_id_product_id_size_key UNIQUE (id_product, id_size);


--
-- TOC entry 4831 (class 2606 OID 24798)
-- Name: stock_items stock_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_items
    ADD CONSTRAINT stock_items_pkey PRIMARY KEY (id_stock);


--
-- TOC entry 4819 (class 2606 OID 24737)
-- Name: subcategories subcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_pkey PRIMARY KEY (id_subcategory);


--
-- TOC entry 4813 (class 2606 OID 24714)
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- TOC entry 4815 (class 2606 OID 24712)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_users);


--
-- TOC entry 4845 (class 2606 OID 24842)
-- Name: order_items order_items_id_orders_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_id_orders_fkey FOREIGN KEY (id_orders) REFERENCES public.orders(id_orders);


--
-- TOC entry 4846 (class 2606 OID 24847)
-- Name: order_items order_items_id_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_id_product_fkey FOREIGN KEY (id_product) REFERENCES public.products(id_product);


--
-- TOC entry 4847 (class 2606 OID 24852)
-- Name: order_items order_items_id_size_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_id_size_fkey FOREIGN KEY (id_size) REFERENCES public.size(id_size);


--
-- TOC entry 4844 (class 2606 OID 24824)
-- Name: orders orders_id_users_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_id_users_fkey FOREIGN KEY (id_users) REFERENCES public.users(id_users);


--
-- TOC entry 4839 (class 2606 OID 24773)
-- Name: products products_id_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_id_category_fkey FOREIGN KEY (id_category) REFERENCES public.categories(id_category);


--
-- TOC entry 4840 (class 2606 OID 24783)
-- Name: products products_id_proizvod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_id_proizvod_fkey FOREIGN KEY (id_proizvod) REFERENCES public.proizvodstvo(id_proizvod);


--
-- TOC entry 4841 (class 2606 OID 24778)
-- Name: products products_id_subcategory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_id_subcategory_fkey FOREIGN KEY (id_subcategory) REFERENCES public.subcategories(id_subcategory);


--
-- TOC entry 4842 (class 2606 OID 24866)
-- Name: stock_items stock_items_id_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_items
    ADD CONSTRAINT stock_items_id_product_fkey FOREIGN KEY (id_product) REFERENCES public.products(id_product) NOT VALID;


--
-- TOC entry 4843 (class 2606 OID 24806)
-- Name: stock_items stock_items_id_size_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_items
    ADD CONSTRAINT stock_items_id_size_fkey FOREIGN KEY (id_size) REFERENCES public.size(id_size);


--
-- TOC entry 4838 (class 2606 OID 24715)
-- Name: users users_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.roles(id_role);


-- Completed on 2026-10-31 18:54:44

--
-- PostgreSQL database dump complete
--

\unrestrict lRya5uqGvbf3sHYoNiv6AagcVHa2dca50KDdipd3vxcV4ATqfnL8h3Wasoqbf3N

