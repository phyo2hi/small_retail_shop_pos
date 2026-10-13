--
-- PostgreSQL database dump
--

\restrict 4v0mbmgcps45AhNR9KC5ffc5Cc5rYMM6kQWG6wg0XkeivYRD2tlbsRPAnw8aFjd

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-13 19:34:26

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 17112)
-- Name: ကုန်ပစ္စည်းပေးသွင်းသူ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ကုန်ပစ္စည်းပေးသွင်းသူ" (
    supplier_id bigint CONSTRAINT "ကုန်ပစ္စည်းပေး_supplier_id_not_null" NOT NULL,
    name character varying(200) CONSTRAINT "ကုန်ပစ္စည်းပေးသွ_name_not_null" NOT NULL,
    contact_person character varying(150),
    phone character varying(50),
    email character varying(255),
    address text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT "ကုန်ပစ္စည်းပေး_created_at_not_null" NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT "ကုန်ပစ္စည်းပေး_updated_at_not_null" NOT NULL
);


ALTER TABLE public."ကုန်ပစ္စည်းပေးသွင်းသူ" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17111)
-- Name: ကုန်ပစ္စည်းပေးသ_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."ကုန်ပစ္စည်းပေးသွင်းသူ" ALTER COLUMN supplier_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ကုန်ပစ္စည်းပေးသ_supplier_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 17126)
-- Name: ကုန်ပစ္စည်းများ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ကုန်ပစ္စည်းများ" (
    product_id bigint CONSTRAINT "ကုန်ပစ္စည်းမျာ_product_id_not_null" NOT NULL,
    category_id bigint,
    supplier_id bigint,
    name character varying(200) NOT NULL,
    barcode character varying(100),
    cost_price numeric(12,2) DEFAULT 0 CONSTRAINT "ကုန်ပစ္စည်းမျာ_cost_price_not_null" NOT NULL,
    selling_price numeric(12,2) DEFAULT 0 CONSTRAINT "ကုန်ပစ္စည်းမျ_selling_price_not_null" NOT NULL,
    unit character varying(50) DEFAULT 'piece'::character varying NOT NULL,
    is_active boolean DEFAULT true CONSTRAINT "ကုန်ပစ္စည်းမျာ_is_active_not_null" NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT "ကုန်ပစ္စည်းမျာ_created_at_not_null" NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT "ကုန်ပစ္စည်းမျာ_updated_at_not_null" NOT NULL,
    CONSTRAINT products_cost_price_nonnegative CHECK ((cost_price >= (0)::numeric)),
    CONSTRAINT products_selling_price_nonnegative CHECK ((selling_price >= (0)::numeric))
);


ALTER TABLE public."ကုန်ပစ္စည်းများ" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17125)
-- Name: ကုန်ပစ္စည်းများ_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."ကုန်ပစ္စည်းများ" ALTER COLUMN product_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ကုန်ပစ္စည်းများ_product_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 17160)
-- Name: ကုန်လက်ကျန်စာရင်း; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ကုန်လက်ကျန်စာရင်း" (
    inventory_id bigint CONSTRAINT "ကုန်လက်ကျန်စာ_inventory_id_not_null" NOT NULL,
    product_id bigint CONSTRAINT "ကုန်လက်ကျန်စာရ_product_id_not_null" NOT NULL,
    stock_qty numeric(12,3) DEFAULT 0 CONSTRAINT "ကုန်လက်ကျန်စာရ_stock_qty_not_null" NOT NULL,
    reorder_level numeric(12,3) DEFAULT 0 CONSTRAINT "ကုန်လက်ကျန်စာ_reorder_level_not_null" NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT "ကုန်လက်ကျန်စာရ_updated_at_not_null" NOT NULL,
    CONSTRAINT inventory_reorder_level_nonnegative CHECK ((reorder_level >= (0)::numeric)),
    CONSTRAINT inventory_stock_nonnegative CHECK ((stock_qty >= (0)::numeric))
);


ALTER TABLE public."ကုန်လက်ကျန်စာရင်း" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17159)
-- Name: ကုန်လက်ကျန်စာရင_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."ကုန်လက်ကျန်စာရင်း" ALTER COLUMN inventory_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ကုန်လက်ကျန်စာရင_inventory_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 17096)
-- Name: ကုန်အမျိုးအစားများ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ကုန်အမျိုးအစားများ" (
    category_id bigint CONSTRAINT "ကုန်အမျိုးအစား_category_id_not_null" NOT NULL,
    name character varying(150) CONSTRAINT "ကုန်အမျိုးအစားမျ_name_not_null" NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT "ကုန်အမျိုးအစား_created_at_not_null" NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT "ကုန်အမျိုးအစား_updated_at_not_null" NOT NULL
);


ALTER TABLE public."ကုန်အမျိုးအစားများ" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17095)
-- Name: ကုန်အမျိုးအစားမ_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."ကုန်အမျိုးအစားများ" ALTER COLUMN category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ကုန်အမျိုးအစားမ_category_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 17183)
-- Name: ဖောက်သည်များ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ဖောက်သည်များ" (
    customer_id bigint NOT NULL,
    name character varying(200) NOT NULL,
    phone character varying(50),
    email character varying(255),
    address text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."ဖောက်သည်များ" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17182)
-- Name: ဖောက်သည်များ_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."ဖောက်သည်များ" ALTER COLUMN customer_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ဖောက်သည်များ_customer_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 17266)
-- Name: ဘောင်ချာပစ္စည်းအသေးစိ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ဘောင်ချာပစ္စည်းအသေးစိ" (
    sale_item_id bigint CONSTRAINT "ဘောင်ချာပစ္စည_sale_item_id_not_null" NOT NULL,
    voucher_id bigint CONSTRAINT "ဘောင်ချာပစ္စည်_voucher_id_not_null" NOT NULL,
    product_id bigint CONSTRAINT "ဘောင်ချာပစ္စည်_product_id_not_null" NOT NULL,
    quantity numeric(12,3) CONSTRAINT "ဘောင်ချာပစ္စည်း_quantity_not_null" NOT NULL,
    unit_price numeric(12,2) CONSTRAINT "ဘောင်ချာပစ္စည်_unit_price_not_null" NOT NULL,
    unit_cost numeric(12,2) CONSTRAINT "ဘောင်ချာပစ္စည်_unit_cost_not_null" NOT NULL,
    discount_amount numeric(12,2) DEFAULT 0 CONSTRAINT "ဘောင်ချာပစ္စ_discount_amount_not_null" NOT NULL,
    line_total numeric(12,2) CONSTRAINT "ဘောင်ချာပစ္စည်_line_total_not_null" NOT NULL,
    CONSTRAINT sale_items_discount_nonnegative CHECK ((discount_amount >= (0)::numeric)),
    CONSTRAINT sale_items_discount_within_line_amount CHECK ((discount_amount <= (quantity * unit_price))),
    CONSTRAINT sale_items_line_total_nonnegative CHECK ((line_total >= (0)::numeric)),
    CONSTRAINT sale_items_quantity_positive CHECK ((quantity > (0)::numeric)),
    CONSTRAINT sale_items_unit_cost_nonnegative CHECK ((unit_cost >= (0)::numeric)),
    CONSTRAINT sale_items_unit_price_nonnegative CHECK ((unit_price >= (0)::numeric))
);


ALTER TABLE public."ဘောင်ချာပစ္စည်းအသေးစိ" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17265)
-- Name: ဘောင်ချာပစ္စည်း_sale_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."ဘောင်ချာပစ္စည်းအသေးစိ" ALTER COLUMN sale_item_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ဘောင်ချာပစ္စည်း_sale_item_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 17199)
-- Name: ဝန်ထမ်းများ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ဝန်ထမ်းများ" (
    user_id bigint NOT NULL,
    full_name character varying(200) NOT NULL,
    username character varying(100) NOT NULL,
    password_hash text NOT NULL,
    role character varying(50) DEFAULT 'cashier'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."ဝန်ထမ်းများ" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17198)
-- Name: ဝန်ထမ်းများ_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."ဝန်ထမ်းများ" ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ဝန်ထမ်းများ_user_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 17221)
-- Name: အရောင်းဘောင်ချာများ; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."အရောင်းဘောင်ချာများ" (
    voucher_id bigint CONSTRAINT "အရောင်းဘောင်ချ_voucher_id_not_null" NOT NULL,
    voucher_number character varying(100) CONSTRAINT "အရောင်းဘောင်ခ_voucher_number_not_null" NOT NULL,
    cashier_id bigint CONSTRAINT "အရောင်းဘောင်ချ_cashier_id_not_null" NOT NULL,
    customer_id bigint,
    sold_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT "အရောင်းဘောင်ချာ_sold_at_not_null" NOT NULL,
    subtotal numeric(12,2) DEFAULT 0 CONSTRAINT "အရောင်းဘောင်ချာ_subtotal_not_null" NOT NULL,
    discount_amount numeric(12,2) DEFAULT 0 CONSTRAINT "အရောင်းဘောင်_discount_amount_not_null" NOT NULL,
    tax_amount numeric(12,2) DEFAULT 0 CONSTRAINT "အရောင်းဘောင်ချ_tax_amount_not_null" NOT NULL,
    total_amount numeric(12,2) DEFAULT 0 CONSTRAINT "အရောင်းဘောင်ခ_total_amount_not_null" NOT NULL,
    payment_method character varying(20) CONSTRAINT "အရောင်းဘောင်ခ_payment_method_not_null" NOT NULL,
    payment_status character varying(20) DEFAULT 'paid'::character varying CONSTRAINT "အရောင်းဘောင်ခ_payment_status_not_null" NOT NULL,
    notes text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT "အရောင်းဘောင်ချ_created_at_not_null" NOT NULL,
    CONSTRAINT sales_vouchers_discount_nonnegative CHECK ((discount_amount >= (0)::numeric)),
    CONSTRAINT sales_vouchers_discount_within_subtotal CHECK ((discount_amount <= subtotal)),
    CONSTRAINT sales_vouchers_payment_method_check CHECK (((payment_method)::text = ANY ((ARRAY['cash'::character varying, 'kpay'::character varying, 'credit'::character varying])::text[]))),
    CONSTRAINT sales_vouchers_payment_status_check CHECK (((payment_status)::text = ANY ((ARRAY['paid'::character varying, 'pending'::character varying, 'partial'::character varying])::text[]))),
    CONSTRAINT sales_vouchers_subtotal_nonnegative CHECK ((subtotal >= (0)::numeric)),
    CONSTRAINT sales_vouchers_tax_nonnegative CHECK ((tax_amount >= (0)::numeric)),
    CONSTRAINT sales_vouchers_total_nonnegative CHECK ((total_amount >= (0)::numeric))
);


ALTER TABLE public."အရောင်းဘောင်ချာများ" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17220)
-- Name: အရောင်းဘောင်ချာမ_voucher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."အရောင်းဘောင်ချာများ" ALTER COLUMN voucher_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."အရောင်းဘောင်ချာမ_voucher_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5129 (class 0 OID 17112)
-- Dependencies: 222
-- Data for Name: ကုန်ပစ္စည်းပေးသွင်းသူ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ကုန်ပစ္စည်းပေးသွင်းသူ" (supplier_id, name, contact_person, phone, email, address, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5131 (class 0 OID 17126)
-- Dependencies: 224
-- Data for Name: ကုန်ပစ္စည်းများ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ကုန်ပစ္စည်းများ" (product_id, category_id, supplier_id, name, barcode, cost_price, selling_price, unit, is_active, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5133 (class 0 OID 17160)
-- Dependencies: 226
-- Data for Name: ကုန်လက်ကျန်စာရင်း; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ကုန်လက်ကျန်စာရင်း" (inventory_id, product_id, stock_qty, reorder_level, updated_at) FROM stdin;
\.


--
-- TOC entry 5127 (class 0 OID 17096)
-- Dependencies: 220
-- Data for Name: ကုန်အမျိုးအစားများ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ကုန်အမျိုးအစားများ" (category_id, name, description, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5135 (class 0 OID 17183)
-- Dependencies: 228
-- Data for Name: ဖောက်သည်များ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ဖောက်သည်များ" (customer_id, name, phone, email, address, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5141 (class 0 OID 17266)
-- Dependencies: 234
-- Data for Name: ဘောင်ချာပစ္စည်းအသေးစိ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ဘောင်ချာပစ္စည်းအသေးစိ" (sale_item_id, voucher_id, product_id, quantity, unit_price, unit_cost, discount_amount, line_total) FROM stdin;
\.


--
-- TOC entry 5137 (class 0 OID 17199)
-- Dependencies: 230
-- Data for Name: ဝန်ထမ်းများ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ဝန်ထမ်းများ" (user_id, full_name, username, password_hash, role, is_active, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5139 (class 0 OID 17221)
-- Dependencies: 232
-- Data for Name: အရောင်းဘောင်ချာများ; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."အရောင်းဘောင်ချာများ" (voucher_id, voucher_number, cashier_id, customer_id, sold_at, subtotal, discount_amount, tax_amount, total_amount, payment_method, payment_status, notes, created_at) FROM stdin;
\.


--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 221
-- Name: ကုန်ပစ္စည်းပေးသ_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ကုန်ပစ္စည်းပေးသ_supplier_id_seq"', 1, false);


--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 223
-- Name: ကုန်ပစ္စည်းများ_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ကုန်ပစ္စည်းများ_product_id_seq"', 1, false);


--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 225
-- Name: ကုန်လက်ကျန်စာရင_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ကုန်လက်ကျန်စာရင_inventory_id_seq"', 1, false);


--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 219
-- Name: ကုန်အမျိုးအစားမ_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ကုန်အမျိုးအစားမ_category_id_seq"', 1, false);


--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 227
-- Name: ဖောက်သည်များ_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ဖောက်သည်များ_customer_id_seq"', 1, false);


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 233
-- Name: ဘောင်ချာပစ္စည်း_sale_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ဘောင်ချာပစ္စည်း_sale_item_id_seq"', 1, false);


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 229
-- Name: ဝန်ထမ်းများ_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ဝန်ထမ်းများ_user_id_seq"', 1, false);


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 231
-- Name: အရောင်းဘောင်ချာမ_voucher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."အရောင်းဘောင်ချာမ_voucher_id_seq"', 1, false);


--
-- TOC entry 4940 (class 2606 OID 17124)
-- Name: ကုန်ပစ္စည်းပေးသွင်းသူ ကုန်ပစ္စည်းပေးသွင်း_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ကုန်ပစ္စည်းပေးသွင်းသူ"
    ADD CONSTRAINT "ကုန်ပစ္စည်းပေးသွင်း_pkey" PRIMARY KEY (supplier_id);


--
-- TOC entry 4945 (class 2606 OID 17148)
-- Name: ကုန်ပစ္စည်းများ ကုန်ပစ္စည်းများ_barcode_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ကုန်ပစ္စည်းများ"
    ADD CONSTRAINT "ကုန်ပစ္စည်းများ_barcode_key" UNIQUE (barcode);


--
-- TOC entry 4947 (class 2606 OID 17146)
-- Name: ကုန်ပစ္စည်းများ ကုန်ပစ္စည်းများ_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ကုန်ပစ္စည်းများ"
    ADD CONSTRAINT "ကုန်ပစ္စည်းများ_pkey" PRIMARY KEY (product_id);


--
-- TOC entry 4950 (class 2606 OID 17176)
-- Name: ကုန်လက်ကျန်စာရင်း ကုန်လက်ကျန်စာရင်_product_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ကုန်လက်ကျန်စာရင်း"
    ADD CONSTRAINT "ကုန်လက်ကျန်စာရင်_product_id_key" UNIQUE (product_id);


--
-- TOC entry 4952 (class 2606 OID 17174)
-- Name: ကုန်လက်ကျန်စာရင်း ကုန်လက်ကျန်စာရင်း_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ကုန်လက်ကျန်စာရင်း"
    ADD CONSTRAINT "ကုန်လက်ကျန်စာရင်း_pkey" PRIMARY KEY (inventory_id);


--
-- TOC entry 4936 (class 2606 OID 17110)
-- Name: ကုန်အမျိုးအစားများ ကုန်အမျိုးအစားများ_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ကုန်အမျိုးအစားများ"
    ADD CONSTRAINT "ကုန်အမျိုးအစားများ_name_key" UNIQUE (name);


--
-- TOC entry 4938 (class 2606 OID 17108)
-- Name: ကုန်အမျိုးအစားများ ကုန်အမျိုးအစားများ_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ကုန်အမျိုးအစားများ"
    ADD CONSTRAINT "ကုန်အမျိုးအစားများ_pkey" PRIMARY KEY (category_id);


--
-- TOC entry 4954 (class 2606 OID 17197)
-- Name: ဖောက်သည်များ ဖောက်သည်များ_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ဖောက်သည်များ"
    ADD CONSTRAINT "ဖောက်သည်များ_phone_key" UNIQUE (phone);


--
-- TOC entry 4956 (class 2606 OID 17195)
-- Name: ဖောက်သည်များ ဖောက်သည်များ_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ဖောက်သည်များ"
    ADD CONSTRAINT "ဖောက်သည်များ_pkey" PRIMARY KEY (customer_id);


--
-- TOC entry 4971 (class 2606 OID 17285)
-- Name: ဘောင်ချာပစ္စည်းအသေးစိ ဘောင်ချာပစ္စည်းအသေး_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ဘောင်ချာပစ္စည်းအသေးစိ"
    ADD CONSTRAINT "ဘောင်ချာပစ္စည်းအသေး_pkey" PRIMARY KEY (sale_item_id);


--
-- TOC entry 4958 (class 2606 OID 17217)
-- Name: ဝန်ထမ်းများ ဝန်ထမ်းများ_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ဝန်ထမ်းများ"
    ADD CONSTRAINT "ဝန်ထမ်းများ_pkey" PRIMARY KEY (user_id);


--
-- TOC entry 4960 (class 2606 OID 17219)
-- Name: ဝန်ထမ်းများ ဝန်ထမ်းများ_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ဝန်ထမ်းများ"
    ADD CONSTRAINT "ဝန်ထမ်းများ_username_key" UNIQUE (username);


--
-- TOC entry 4965 (class 2606 OID 17254)
-- Name: အရောင်းဘောင်ချာများ အရောင်းဘောင်ချ_voucher_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."အရောင်းဘောင်ချာများ"
    ADD CONSTRAINT "အရောင်းဘောင်ချ_voucher_number_key" UNIQUE (voucher_number);


--
-- TOC entry 4967 (class 2606 OID 17252)
-- Name: အရောင်းဘောင်ချာများ အရောင်းဘောင်ချာများ_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."အရောင်းဘောင်ချာများ"
    ADD CONSTRAINT "အရောင်းဘောင်ချာများ_pkey" PRIMARY KEY (voucher_id);


--
-- TOC entry 4948 (class 1259 OID 17299)
-- Name: inventory_product_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inventory_product_id_idx ON public."ကုန်လက်ကျန်စာရင်း" USING btree (product_id);


--
-- TOC entry 4941 (class 1259 OID 17296)
-- Name: products_category_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_category_id_idx ON public."ကုန်ပစ္စည်းများ" USING btree (category_id);


--
-- TOC entry 4942 (class 1259 OID 17298)
-- Name: products_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_name_idx ON public."ကုန်ပစ္စည်းများ" USING btree (name);


--
-- TOC entry 4943 (class 1259 OID 17297)
-- Name: products_supplier_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_supplier_id_idx ON public."ကုန်ပစ္စည်းများ" USING btree (supplier_id);


--
-- TOC entry 4968 (class 1259 OID 17304)
-- Name: sale_items_product_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sale_items_product_id_idx ON public."ဘောင်ချာပစ္စည်းအသေးစိ" USING btree (product_id);


--
-- TOC entry 4969 (class 1259 OID 17303)
-- Name: sale_items_voucher_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sale_items_voucher_id_idx ON public."ဘောင်ချာပစ္စည်းအသေးစိ" USING btree (voucher_id);


--
-- TOC entry 4961 (class 1259 OID 17300)
-- Name: sales_vouchers_cashier_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sales_vouchers_cashier_id_idx ON public."အရောင်းဘောင်ချာများ" USING btree (cashier_id);


--
-- TOC entry 4962 (class 1259 OID 17301)
-- Name: sales_vouchers_customer_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sales_vouchers_customer_id_idx ON public."အရောင်းဘောင်ချာများ" USING btree (customer_id);


--
-- TOC entry 4963 (class 1259 OID 17302)
-- Name: sales_vouchers_sold_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sales_vouchers_sold_at_idx ON public."အရောင်းဘောင်ချာများ" USING btree (sold_at);


--
-- TOC entry 4972 (class 2606 OID 17149)
-- Name: ကုန်ပစ္စည်းများ ကုန်ပစ္စည်းများ_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ကုန်ပစ္စည်းများ"
    ADD CONSTRAINT "ကုန်ပစ္စည်းများ_category_id_fkey" FOREIGN KEY (category_id) REFERENCES public."ကုန်အမျိုးအစားများ"(category_id) ON DELETE SET NULL;


--
-- TOC entry 4973 (class 2606 OID 17154)
-- Name: ကုန်ပစ္စည်းများ ကုန်ပစ္စည်းများ_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ကုန်ပစ္စည်းများ"
    ADD CONSTRAINT "ကုန်ပစ္စည်းများ_supplier_id_fkey" FOREIGN KEY (supplier_id) REFERENCES public."ကုန်ပစ္စည်းပေးသွင်းသူ"(supplier_id) ON DELETE SET NULL;


--
-- TOC entry 4974 (class 2606 OID 17177)
-- Name: ကုန်လက်ကျန်စာရင်း ကုန်လက်ကျန်စာရင_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ကုန်လက်ကျန်စာရင်း"
    ADD CONSTRAINT "ကုန်လက်ကျန်စာရင_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."ကုန်ပစ္စည်းများ"(product_id) ON DELETE RESTRICT;


--
-- TOC entry 4977 (class 2606 OID 17291)
-- Name: ဘောင်ချာပစ္စည်းအသေးစိ ဘောင်ချာပစ္စည်း_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ဘောင်ချာပစ္စည်းအသေးစိ"
    ADD CONSTRAINT "ဘောင်ချာပစ္စည်း_product_id_fkey" FOREIGN KEY (product_id) REFERENCES public."ကုန်ပစ္စည်းများ"(product_id) ON DELETE RESTRICT;


--
-- TOC entry 4978 (class 2606 OID 17286)
-- Name: ဘောင်ချာပစ္စည်းအသေးစိ ဘောင်ချာပစ္စည်း_voucher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ဘောင်ချာပစ္စည်းအသေးစိ"
    ADD CONSTRAINT "ဘောင်ချာပစ္စည်း_voucher_id_fkey" FOREIGN KEY (voucher_id) REFERENCES public."အရောင်းဘောင်ချာများ"(voucher_id) ON DELETE RESTRICT;


--
-- TOC entry 4975 (class 2606 OID 17255)
-- Name: အရောင်းဘောင်ချာများ အရောင်းဘောင်ချာ_cashier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."အရောင်းဘောင်ချာများ"
    ADD CONSTRAINT "အရောင်းဘောင်ချာ_cashier_id_fkey" FOREIGN KEY (cashier_id) REFERENCES public."ဝန်ထမ်းများ"(user_id) ON DELETE RESTRICT;


--
-- TOC entry 4976 (class 2606 OID 17260)
-- Name: အရောင်းဘောင်ချာများ အရောင်းဘောင်ချာ_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."အရောင်းဘောင်ချာများ"
    ADD CONSTRAINT "အရောင်းဘောင်ချာ_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES public."ဖောက်သည်များ"(customer_id) ON DELETE SET NULL;


-- Completed on 2026-10-13 19:34:26

--
-- PostgreSQL database dump complete
--

\unrestrict 4v0mbmgcps45AhNR9KC5ffc5Cc5rYMM6kQWG6wg0XkeivYRD2tlbsRPAnw8aFjd

