--
-- PostgreSQL database dump
--

-- Dumped from database version 11.11
-- Dumped by pg_dump version 13.3

-- Started on 2021-05-23 12:37:59 CST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

--
-- TOC entry 196 (class 1259 OID 32295)
-- Name: dish; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dish (
    code character varying(10) NOT NULL,
    name character varying(80) NOT NULL,
    price numeric(5,2)
);


ALTER TABLE public.dish OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 32307)
-- Name: order_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_info (
    id integer NOT NULL,
    count integer,
    start_ts timestamp with time zone DEFAULT now() NOT NULL,
    check_ts timestamp with time zone,
    table_id integer,
    status integer
);


ALTER TABLE public.order_info OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 32305)
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_id_seq OWNER TO postgres;

--
-- TOC entry 3200 (class 0 OID 0)
-- Dependencies: 198
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_id_seq OWNED BY public.order_info.id;


--
-- TOC entry 201 (class 1259 OID 32315)
-- Name: order_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item (
    id integer NOT NULL,
    item character varying(10),
    order_id integer
);


ALTER TABLE public.order_item OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 32313)
-- Name: order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_item_id_seq OWNER TO postgres;

--
-- TOC entry 3201 (class 0 OID 0)
-- Dependencies: 200
-- Name: order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_item_id_seq OWNED BY public.order_item.id;


--
-- TOC entry 197 (class 1259 OID 32300)
-- Name: table_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.table_info (
    id integer NOT NULL,
    capacity integer NOT NULL
);


ALTER TABLE public.table_info OWNER TO postgres;

--
-- TOC entry 3054 (class 2604 OID 32310)
-- Name: order_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_info ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- TOC entry 3056 (class 2604 OID 32318)
-- Name: order_item id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item ALTER COLUMN id SET DEFAULT nextval('public.order_item_id_seq'::regclass);


--
-- TOC entry 3189 (class 0 OID 32295)
-- Dependencies: 196
-- Data for Name: dish; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dish (code, name, price) FROM stdin;
GBJD	宫保鸡丁	10.00
GBNRD	宫保牛肉丁	20.00
GBRD	宫保肉丁	15.00
YXRS	鱼香肉丝	22.00
YXQZ	鱼香茄子	16.00
\.


--
-- TOC entry 3192 (class 0 OID 32307)
-- Dependencies: 199
-- Data for Name: order_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_info (id, count, start_ts, check_ts, table_id, status) FROM stdin;
1	2	2021-05-23 01:31:07.119576+08	\N	5	0
2	5	2021-05-23 01:32:34.89711+08	\N	3	0
3	3	2021-05-23 01:34:04.461473+08	2021-05-23 01:47:36.188178+08	1	1
\.


--
-- TOC entry 3194 (class 0 OID 32315)
-- Dependencies: 201
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_item (id, item, order_id) FROM stdin;
4	GBJD	1
5	YXRS	1
6	YXQZ	2
7	GBNRD	3
\.


--
-- TOC entry 3190 (class 0 OID 32300)
-- Dependencies: 197
-- Data for Name: table_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.table_info (id, capacity) FROM stdin;
1	4
2	4
3	8
4	8
5	2
6	2
\.


--
-- TOC entry 3202 (class 0 OID 0)
-- Dependencies: 198
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_id_seq', 3, true);


--
-- TOC entry 3203 (class 0 OID 0)
-- Dependencies: 200
-- Name: order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_item_id_seq', 7, true);


--
-- TOC entry 3058 (class 2606 OID 32299)
-- Name: dish dish_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dish
    ADD CONSTRAINT dish_pkey PRIMARY KEY (code);


--
-- TOC entry 3064 (class 2606 OID 32320)
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);


--
-- TOC entry 3062 (class 2606 OID 32312)
-- Name: order_info order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- TOC entry 3060 (class 2606 OID 32304)
-- Name: table_info table_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.table_info
    ADD CONSTRAINT table_info_pkey PRIMARY KEY (id);


--
-- TOC entry 3067 (class 2606 OID 32331)
-- Name: order_item order_item_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_item_fkey FOREIGN KEY (item) REFERENCES public.dish(code) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3066 (class 2606 OID 32321)
-- Name: order_item order_item_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.order_info(id) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 3065 (class 2606 OID 32326)
-- Name: order_info order_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT order_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.table_info(id) ON UPDATE CASCADE NOT VALID;


-- Completed on 2021-05-23 12:37:59 CST

--
-- PostgreSQL database dump complete
--

