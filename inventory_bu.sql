--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 16.9

-- Started on 2025-07-14 22:59:38

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

--
-- TOC entry 1001 (class 1247 OID 25533)
-- Name: po_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.po_type_enum AS ENUM (
    'direct',
    'quotation_based'
);


ALTER TYPE public.po_type_enum OWNER TO postgres;

--
-- TOC entry 905 (class 1247 OID 24957)
-- Name: status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status_enum AS ENUM (
    'active',
    'inactive',
    'archived'
);


ALTER TYPE public.status_enum OWNER TO postgres;

--
-- TOC entry 908 (class 1247 OID 24964)
-- Name: storage_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.storage_type_enum AS ENUM (
    'ambient',
    'refrigerated',
    'frozen',
    'hazardous',
    'dry',
    'wet'
);


ALTER TYPE public.storage_type_enum OWNER TO postgres;

--
-- TOC entry 959 (class 1247 OID 25212)
-- Name: supply_mode; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.supply_mode AS ENUM (
    'via_warehouse',
    'direct_from_vendor',
    'both'
);


ALTER TYPE public.supply_mode OWNER TO postgres;

--
-- TOC entry 956 (class 1247 OID 25205)
-- Name: supply_mode_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.supply_mode_enum AS ENUM (
    'via_warehouse',
    'direct_from_vendor',
    'both'
);


ALTER TYPE public.supply_mode_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 25009)
-- Name: brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brands (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    status public.status_enum DEFAULT 'active'::public.status_enum
);


ALTER TABLE public.brands OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25008)
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brands_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brands_id_seq OWNER TO postgres;

--
-- TOC entry 5289 (class 0 OID 0)
-- Dependencies: 221
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brands_id_seq OWNED BY public.brands.id;


--
-- TOC entry 256 (class 1259 OID 25365)
-- Name: enquiry_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enquiry_items (
    id integer NOT NULL,
    enquiry_id integer,
    item_id integer,
    quantity numeric(10,2) NOT NULL,
    unit_id integer,
    remarks text
);


ALTER TABLE public.enquiry_items OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 25364)
-- Name: enquiry_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enquiry_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enquiry_items_id_seq OWNER TO postgres;

--
-- TOC entry 5290 (class 0 OID 0)
-- Dependencies: 255
-- Name: enquiry_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enquiry_items_id_seq OWNED BY public.enquiry_items.id;


--
-- TOC entry 272 (class 1259 OID 25568)
-- Name: goods_receipt_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goods_receipt_items (
    id integer NOT NULL,
    goods_receipt_id integer,
    item_id integer,
    unit_id integer,
    quantity_received numeric(10,2) NOT NULL,
    unit_price numeric(10,2),
    discount_percent numeric(5,2) DEFAULT 0,
    tax_percent numeric(5,2) DEFAULT 0,
    batch_number character varying(100),
    expiry_date date,
    received_quantity_validated boolean DEFAULT false,
    remarks text
);


ALTER TABLE public.goods_receipt_items OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 25567)
-- Name: goods_receipt_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goods_receipt_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.goods_receipt_items_id_seq OWNER TO postgres;

--
-- TOC entry 5291 (class 0 OID 0)
-- Dependencies: 271
-- Name: goods_receipt_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goods_receipt_items_id_seq OWNED BY public.goods_receipt_items.id;


--
-- TOC entry 270 (class 1259 OID 25539)
-- Name: goods_receipts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goods_receipts (
    id integer NOT NULL,
    grn_number character varying(50) NOT NULL,
    purchase_order_id integer,
    site_id integer,
    vendor_id integer,
    grn_date date NOT NULL,
    received_by character varying(100),
    status character varying(20) DEFAULT 'received'::character varying,
    remarks text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.goods_receipts OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 25538)
-- Name: goods_receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goods_receipts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.goods_receipts_id_seq OWNER TO postgres;

--
-- TOC entry 5292 (class 0 OID 0)
-- Dependencies: 269
-- Name: goods_receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goods_receipts_id_seq OWNED BY public.goods_receipts.id;


--
-- TOC entry 230 (class 1259 OID 25101)
-- Name: item_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_attributes (
    id integer NOT NULL,
    item_id integer,
    attribute_key character varying(100),
    attribute_value character varying(255)
);


ALTER TABLE public.item_attributes OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25100)
-- Name: item_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_attributes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_attributes_id_seq OWNER TO postgres;

--
-- TOC entry 5293 (class 0 OID 0)
-- Dependencies: 229
-- Name: item_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_attributes_id_seq OWNED BY public.item_attributes.id;


--
-- TOC entry 278 (class 1259 OID 25646)
-- Name: item_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_batches (
    id integer NOT NULL,
    site_id integer,
    item_id integer,
    batch_number character varying(100),
    expiry_date date,
    quantity numeric(10,2),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.item_batches OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 25645)
-- Name: item_batches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_batches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_batches_id_seq OWNER TO postgres;

--
-- TOC entry 5294 (class 0 OID 0)
-- Dependencies: 277
-- Name: item_batches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_batches_id_seq OWNED BY public.item_batches.id;


--
-- TOC entry 218 (class 1259 OID 24987)
-- Name: item_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    parent_category_id integer,
    status public.status_enum DEFAULT 'active'::public.status_enum,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.item_categories OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24986)
-- Name: item_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_categories_id_seq OWNER TO postgres;

--
-- TOC entry 5295 (class 0 OID 0)
-- Dependencies: 217
-- Name: item_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_categories_id_seq OWNED BY public.item_categories.id;


--
-- TOC entry 231 (class 1259 OID 25112)
-- Name: item_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_details (
    item_id integer NOT NULL,
    storage_type public.storage_type_enum,
    storage_temp_min numeric(5,2),
    storage_temp_max numeric(5,2),
    net_weight numeric(10,2),
    gross_weight numeric(10,2),
    msds_url text,
    packaging_info text
);


ALTER TABLE public.item_details OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 25595)
-- Name: item_stocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_stocks (
    id integer NOT NULL,
    site_id integer,
    item_id integer,
    quantity numeric(12,2) DEFAULT 0,
    unit_id integer,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.item_stocks OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 25594)
-- Name: item_stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_stocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_stocks_id_seq OWNER TO postgres;

--
-- TOC entry 5296 (class 0 OID 0)
-- Dependencies: 273
-- Name: item_stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_stocks_id_seq OWNED BY public.item_stocks.id;


--
-- TOC entry 236 (class 1259 OID 25155)
-- Name: item_tag_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_tag_map (
    item_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.item_tag_map OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 25147)
-- Name: item_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_tags (
    id integer NOT NULL,
    name character varying(50)
);


ALTER TABLE public.item_tags OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 25146)
-- Name: item_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_tags_id_seq OWNER TO postgres;

--
-- TOC entry 5297 (class 0 OID 0)
-- Dependencies: 234
-- Name: item_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_tags_id_seq OWNED BY public.item_tags.id;


--
-- TOC entry 220 (class 1259 OID 25001)
-- Name: item_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    status public.status_enum DEFAULT 'active'::public.status_enum
);


ALTER TABLE public.item_types OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25000)
-- Name: item_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_types_id_seq OWNER TO postgres;

--
-- TOC entry 5298 (class 0 OID 0)
-- Dependencies: 219
-- Name: item_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_types_id_seq OWNED BY public.item_types.id;


--
-- TOC entry 233 (class 1259 OID 25125)
-- Name: item_units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_units (
    id integer NOT NULL,
    item_id integer,
    from_unit_id integer,
    to_unit_id integer,
    conversion_rate numeric(10,3) NOT NULL
);


ALTER TABLE public.item_units OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 25124)
-- Name: item_units_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_units_id_seq OWNER TO postgres;

--
-- TOC entry 5299 (class 0 OID 0)
-- Dependencies: 232
-- Name: item_units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_units_id_seq OWNED BY public.item_units.id;


--
-- TOC entry 228 (class 1259 OID 25053)
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    sku_code character varying(50),
    barcode character varying(50),
    category_id integer,
    item_type_id integer,
    base_unit_id integer,
    brand_id integer,
    manufacturer_id integer,
    model_id integer,
    is_perishable boolean DEFAULT false,
    shelf_life_days integer,
    is_batch_tracked boolean DEFAULT false,
    is_serial_tracked boolean DEFAULT false,
    has_expiry_date boolean DEFAULT false,
    tax_rate numeric(5,2) DEFAULT 0.0,
    hsn_code character varying(30),
    description text,
    image_url text,
    status public.status_enum DEFAULT 'active'::public.status_enum,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.items OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25052)
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.items_id_seq OWNER TO postgres;

--
-- TOC entry 5300 (class 0 OID 0)
-- Dependencies: 227
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.items_id_seq OWNED BY public.items.id;


--
-- TOC entry 224 (class 1259 OID 25021)
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturers (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    contact_person character varying(100),
    email character varying(100),
    phone character varying(20),
    address text,
    status public.status_enum DEFAULT 'active'::public.status_enum
);


ALTER TABLE public.manufacturers OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25020)
-- Name: manufacturers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manufacturers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manufacturers_id_seq OWNER TO postgres;

--
-- TOC entry 5301 (class 0 OID 0)
-- Dependencies: 223
-- Name: manufacturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manufacturers_id_seq OWNED BY public.manufacturers.id;


--
-- TOC entry 226 (class 1259 OID 25033)
-- Name: models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.models (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    brand_id integer,
    manufacturer_id integer,
    description text,
    status public.status_enum DEFAULT 'active'::public.status_enum
);


ALTER TABLE public.models OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25032)
-- Name: models_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.models_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.models_id_seq OWNER TO postgres;

--
-- TOC entry 5302 (class 0 OID 0)
-- Dependencies: 225
-- Name: models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.models_id_seq OWNED BY public.models.id;


--
-- TOC entry 254 (class 1259 OID 25347)
-- Name: purchase_enquiries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_enquiries (
    id integer NOT NULL,
    site_id integer,
    reference_no character varying(50),
    requested_by character varying(100),
    expected_delivery_date date,
    priority_level character varying(20),
    status public.status_enum DEFAULT 'active'::public.status_enum,
    remarks text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.purchase_enquiries OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 25346)
-- Name: purchase_enquiries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_enquiries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_enquiries_id_seq OWNER TO postgres;

--
-- TOC entry 5303 (class 0 OID 0)
-- Dependencies: 253
-- Name: purchase_enquiries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_enquiries_id_seq OWNED BY public.purchase_enquiries.id;


--
-- TOC entry 268 (class 1259 OID 25507)
-- Name: purchase_order_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_order_documents (
    id integer NOT NULL,
    purchase_order_id integer,
    doc_type character varying(50),
    file_url text,
    uploaded_by character varying(100),
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.purchase_order_documents OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 25506)
-- Name: purchase_order_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_order_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_order_documents_id_seq OWNER TO postgres;

--
-- TOC entry 5304 (class 0 OID 0)
-- Dependencies: 267
-- Name: purchase_order_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_order_documents_id_seq OWNED BY public.purchase_order_documents.id;


--
-- TOC entry 264 (class 1259 OID 25466)
-- Name: purchase_order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_order_items (
    id integer NOT NULL,
    purchase_order_id integer,
    item_id integer,
    unit_id integer,
    quantity numeric(10,2) NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    discount_percent numeric(5,2) DEFAULT 0,
    tax_percent numeric(5,2) DEFAULT 0,
    total_before_tax numeric(12,2),
    tax_amount numeric(12,2),
    total_after_tax numeric(12,2),
    required_by_date date,
    remarks text
);


ALTER TABLE public.purchase_order_items OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 25465)
-- Name: purchase_order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_order_items_id_seq OWNER TO postgres;

--
-- TOC entry 5305 (class 0 OID 0)
-- Dependencies: 263
-- Name: purchase_order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_order_items_id_seq OWNED BY public.purchase_order_items.id;


--
-- TOC entry 266 (class 1259 OID 25492)
-- Name: purchase_order_status_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_order_status_log (
    id integer NOT NULL,
    purchase_order_id integer,
    status character varying(30),
    changed_by character varying(100),
    changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    remarks text
);


ALTER TABLE public.purchase_order_status_log OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 25491)
-- Name: purchase_order_status_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_order_status_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_order_status_log_id_seq OWNER TO postgres;

--
-- TOC entry 5306 (class 0 OID 0)
-- Dependencies: 265
-- Name: purchase_order_status_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_order_status_log_id_seq OWNED BY public.purchase_order_status_log.id;


--
-- TOC entry 262 (class 1259 OID 25438)
-- Name: purchase_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_orders (
    id integer NOT NULL,
    po_number character varying(50) NOT NULL,
    vendor_id integer,
    site_id integer,
    order_date date NOT NULL,
    expected_delivery_date date,
    payment_terms character varying(100),
    shipping_address text,
    billing_address text,
    shipping_method character varying(100),
    currency character varying(10) DEFAULT 'INR'::character varying,
    total_amount numeric(12,2) DEFAULT 0,
    total_tax numeric(12,2) DEFAULT 0,
    grand_total numeric(12,2) DEFAULT 0,
    status character varying(30) DEFAULT 'draft'::character varying,
    remarks text,
    created_by character varying(100),
    approved_by character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    enquiry_id integer,
    vendor_quotation_id integer,
    po_type public.po_type_enum DEFAULT 'direct'::public.po_type_enum,
    billing_site_id integer
);


ALTER TABLE public.purchase_orders OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 25437)
-- Name: purchase_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchase_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchase_orders_id_seq OWNER TO postgres;

--
-- TOC entry 5307 (class 0 OID 0)
-- Dependencies: 261
-- Name: purchase_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchase_orders_id_seq OWNED BY public.purchase_orders.id;


--
-- TOC entry 260 (class 1259 OID 25413)
-- Name: quotation_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quotation_items (
    id integer NOT NULL,
    quotation_id integer,
    item_id integer,
    unit_price numeric(10,2) NOT NULL,
    tax_rate numeric(5,2) DEFAULT 0.0,
    available_quantity numeric(10,2),
    remarks text
);


ALTER TABLE public.quotation_items OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 25412)
-- Name: quotation_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quotation_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quotation_items_id_seq OWNER TO postgres;

--
-- TOC entry 5308 (class 0 OID 0)
-- Dependencies: 259
-- Name: quotation_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quotation_items_id_seq OWNED BY public.quotation_items.id;


--
-- TOC entry 242 (class 1259 OID 25197)
-- Name: site_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    status public.status_enum DEFAULT 'active'::public.status_enum
);


ALTER TABLE public.site_types OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 25196)
-- Name: site_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.site_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.site_types_id_seq OWNER TO postgres;

--
-- TOC entry 5309 (class 0 OID 0)
-- Dependencies: 241
-- Name: site_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.site_types_id_seq OWNED BY public.site_types.id;


--
-- TOC entry 244 (class 1259 OID 25220)
-- Name: sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sites (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    code character varying(20),
    site_type_id integer,
    organization_id integer,
    parent_site_id integer,
    contact_person_name character varying(100),
    contact_phone character varying(20),
    contact_email character varying(100),
    address_line1 text,
    address_line2 text,
    city character varying(100),
    state character varying(100),
    postal_code character varying(20),
    country character varying(100) DEFAULT 'India'::character varying,
    latitude numeric(10,6),
    longitude numeric(10,6),
    opening_time time without time zone,
    closing_time time without time zone,
    timezone character varying(50) DEFAULT 'Asia/Kolkata'::character varying,
    supply_mode public.supply_mode_enum DEFAULT 'via_warehouse'::public.supply_mode_enum,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sites OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 25219)
-- Name: sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sites_id_seq OWNER TO postgres;

--
-- TOC entry 5310 (class 0 OID 0)
-- Dependencies: 243
-- Name: sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sites_id_seq OWNED BY public.sites.id;


--
-- TOC entry 276 (class 1259 OID 25621)
-- Name: stock_ledger; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_ledger (
    id integer NOT NULL,
    site_id integer,
    item_id integer,
    transaction_type character varying(50),
    reference_id integer,
    quantity numeric(10,2),
    unit_id integer,
    direction character varying(10),
    remarks text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.stock_ledger OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 25620)
-- Name: stock_ledger_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_ledger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_ledger_id_seq OWNER TO postgres;

--
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 275
-- Name: stock_ledger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_ledger_id_seq OWNED BY public.stock_ledger.id;


--
-- TOC entry 216 (class 1259 OID 24978)
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    symbol character varying(10),
    status public.status_enum DEFAULT 'active'::public.status_enum,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.units OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24977)
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.units_id_seq OWNER TO postgres;

--
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 215
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- TOC entry 252 (class 1259 OID 25325)
-- Name: vendor_delivery_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_delivery_schedule (
    id integer NOT NULL,
    vendor_id integer,
    site_id integer,
    day_of_week integer,
    delivery_start time without time zone,
    delivery_end time without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT vendor_delivery_schedule_day_of_week_check CHECK (((day_of_week >= 0) AND (day_of_week <= 6)))
);


ALTER TABLE public.vendor_delivery_schedule OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 25324)
-- Name: vendor_delivery_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendor_delivery_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_delivery_schedule_id_seq OWNER TO postgres;

--
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 251
-- Name: vendor_delivery_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendor_delivery_schedule_id_seq OWNED BY public.vendor_delivery_schedule.id;


--
-- TOC entry 280 (class 1259 OID 25669)
-- Name: vendor_invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_invoices (
    id integer NOT NULL,
    invoice_number character varying(100),
    vendor_id integer,
    grn_id integer,
    billing_site_id integer,
    invoice_date date,
    amount numeric(12,2),
    tax_amount numeric(10,2),
    payment_status character varying(20) DEFAULT 'unpaid'::character varying,
    payment_reference text,
    remarks text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vendor_invoices OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 25668)
-- Name: vendor_invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendor_invoices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_invoices_id_seq OWNER TO postgres;

--
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 279
-- Name: vendor_invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendor_invoices_id_seq OWNED BY public.vendor_invoices.id;


--
-- TOC entry 258 (class 1259 OID 25389)
-- Name: vendor_quotations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_quotations (
    id integer NOT NULL,
    enquiry_id integer,
    vendor_id integer,
    quotation_ref character varying(100),
    quoted_by character varying(100),
    quotation_date date DEFAULT CURRENT_DATE,
    delivery_lead_time_days integer,
    validity_days integer,
    remarks text,
    status public.status_enum DEFAULT 'active'::public.status_enum,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vendor_quotations OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 25388)
-- Name: vendor_quotations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendor_quotations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_quotations_id_seq OWNER TO postgres;

--
-- TOC entry 5315 (class 0 OID 0)
-- Dependencies: 257
-- Name: vendor_quotations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendor_quotations_id_seq OWNED BY public.vendor_quotations.id;


--
-- TOC entry 246 (class 1259 OID 25246)
-- Name: vendor_site_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_site_assignments (
    id integer NOT NULL,
    vendor_id integer,
    site_id integer,
    supply_mode public.supply_mode_enum DEFAULT 'direct_from_vendor'::public.supply_mode_enum,
    preferred boolean DEFAULT false,
    lead_time_days integer DEFAULT 2,
    min_order_value numeric(10,2),
    remarks text,
    status public.status_enum DEFAULT 'active'::public.status_enum,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vendor_site_assignments OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 25245)
-- Name: vendor_site_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendor_site_assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_site_assignments_id_seq OWNER TO postgres;

--
-- TOC entry 5316 (class 0 OID 0)
-- Dependencies: 245
-- Name: vendor_site_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendor_site_assignments_id_seq OWNED BY public.vendor_site_assignments.id;


--
-- TOC entry 248 (class 1259 OID 25272)
-- Name: vendor_site_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_site_items (
    id integer NOT NULL,
    vendor_id integer,
    site_id integer,
    item_id integer,
    is_available boolean DEFAULT true,
    remarks text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vendor_site_items OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 25271)
-- Name: vendor_site_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendor_site_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_site_items_id_seq OWNER TO postgres;

--
-- TOC entry 5317 (class 0 OID 0)
-- Dependencies: 247
-- Name: vendor_site_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendor_site_items_id_seq OWNED BY public.vendor_site_items.id;


--
-- TOC entry 250 (class 1259 OID 25300)
-- Name: vendor_site_pricing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_site_pricing (
    id integer NOT NULL,
    vendor_id integer,
    site_id integer,
    item_id integer,
    price numeric(10,2) NOT NULL,
    tax_rate numeric(5,2),
    effective_from date DEFAULT CURRENT_DATE
);


ALTER TABLE public.vendor_site_pricing OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 25299)
-- Name: vendor_site_pricing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendor_site_pricing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_site_pricing_id_seq OWNER TO postgres;

--
-- TOC entry 5318 (class 0 OID 0)
-- Dependencies: 249
-- Name: vendor_site_pricing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendor_site_pricing_id_seq OWNED BY public.vendor_site_pricing.id;


--
-- TOC entry 238 (class 1259 OID 25171)
-- Name: vendor_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    status public.status_enum DEFAULT 'active'::public.status_enum
);


ALTER TABLE public.vendor_types OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 25170)
-- Name: vendor_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendor_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_types_id_seq OWNER TO postgres;

--
-- TOC entry 5319 (class 0 OID 0)
-- Dependencies: 237
-- Name: vendor_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendor_types_id_seq OWNED BY public.vendor_types.id;


--
-- TOC entry 240 (class 1259 OID 25179)
-- Name: vendors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendors (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    vendor_type_id integer,
    contact_person_name character varying(100),
    contact_phone character varying(20),
    contact_email character varying(100),
    alt_phone character varying(20),
    alt_email character varying(100),
    gst_number character varying(30),
    pan_number character varying(20),
    fssai_number character varying(30),
    website character varying(150),
    company_reg_number character varying(50),
    address_line1 text,
    address_line2 text,
    city character varying(100),
    state character varying(100),
    postal_code character varying(20),
    country character varying(100) DEFAULT 'India'::character varying,
    payment_terms text,
    credit_limit numeric(12,2),
    bank_account_number character varying(50),
    bank_ifsc_code character varying(20),
    bank_name character varying(100),
    notes text,
    status public.status_enum DEFAULT 'active'::public.status_enum,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vendors OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 25178)
-- Name: vendors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendors_id_seq OWNER TO postgres;

--
-- TOC entry 5320 (class 0 OID 0)
-- Dependencies: 239
-- Name: vendors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendors_id_seq OWNED BY public.vendors.id;


--
-- TOC entry 4820 (class 2604 OID 25012)
-- Name: brands id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands ALTER COLUMN id SET DEFAULT nextval('public.brands_id_seq'::regclass);


--
-- TOC entry 4867 (class 2604 OID 25368)
-- Name: enquiry_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiry_items ALTER COLUMN id SET DEFAULT nextval('public.enquiry_items_id_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 25571)
-- Name: goods_receipt_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipt_items ALTER COLUMN id SET DEFAULT nextval('public.goods_receipt_items_id_seq'::regclass);


--
-- TOC entry 4890 (class 2604 OID 25542)
-- Name: goods_receipts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipts ALTER COLUMN id SET DEFAULT nextval('public.goods_receipts_id_seq'::regclass);


--
-- TOC entry 4834 (class 2604 OID 25104)
-- Name: item_attributes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attributes ALTER COLUMN id SET DEFAULT nextval('public.item_attributes_id_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 25649)
-- Name: item_batches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_batches ALTER COLUMN id SET DEFAULT nextval('public.item_batches_id_seq'::regclass);


--
-- TOC entry 4815 (class 2604 OID 24990)
-- Name: item_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_categories ALTER COLUMN id SET DEFAULT nextval('public.item_categories_id_seq'::regclass);


--
-- TOC entry 4898 (class 2604 OID 25598)
-- Name: item_stocks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_stocks ALTER COLUMN id SET DEFAULT nextval('public.item_stocks_id_seq'::regclass);


--
-- TOC entry 4836 (class 2604 OID 25150)
-- Name: item_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_tags ALTER COLUMN id SET DEFAULT nextval('public.item_tags_id_seq'::regclass);


--
-- TOC entry 4818 (class 2604 OID 25004)
-- Name: item_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_types ALTER COLUMN id SET DEFAULT nextval('public.item_types_id_seq'::regclass);


--
-- TOC entry 4835 (class 2604 OID 25128)
-- Name: item_units id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_units ALTER COLUMN id SET DEFAULT nextval('public.item_units_id_seq'::regclass);


--
-- TOC entry 4826 (class 2604 OID 25056)
-- Name: items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items ALTER COLUMN id SET DEFAULT nextval('public.items_id_seq'::regclass);


--
-- TOC entry 4822 (class 2604 OID 25024)
-- Name: manufacturers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers ALTER COLUMN id SET DEFAULT nextval('public.manufacturers_id_seq'::regclass);


--
-- TOC entry 4824 (class 2604 OID 25036)
-- Name: models id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models ALTER COLUMN id SET DEFAULT nextval('public.models_id_seq'::regclass);


--
-- TOC entry 4864 (class 2604 OID 25350)
-- Name: purchase_enquiries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_enquiries ALTER COLUMN id SET DEFAULT nextval('public.purchase_enquiries_id_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 25510)
-- Name: purchase_order_documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_documents ALTER COLUMN id SET DEFAULT nextval('public.purchase_order_documents_id_seq'::regclass);


--
-- TOC entry 4883 (class 2604 OID 25469)
-- Name: purchase_order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items ALTER COLUMN id SET DEFAULT nextval('public.purchase_order_items_id_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 25495)
-- Name: purchase_order_status_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_status_log ALTER COLUMN id SET DEFAULT nextval('public.purchase_order_status_log_id_seq'::regclass);


--
-- TOC entry 4874 (class 2604 OID 25441)
-- Name: purchase_orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders ALTER COLUMN id SET DEFAULT nextval('public.purchase_orders_id_seq'::regclass);


--
-- TOC entry 4872 (class 2604 OID 25416)
-- Name: quotation_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation_items ALTER COLUMN id SET DEFAULT nextval('public.quotation_items_id_seq'::regclass);


--
-- TOC entry 4843 (class 2604 OID 25200)
-- Name: site_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_types ALTER COLUMN id SET DEFAULT nextval('public.site_types_id_seq'::regclass);


--
-- TOC entry 4845 (class 2604 OID 25223)
-- Name: sites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites ALTER COLUMN id SET DEFAULT nextval('public.sites_id_seq'::regclass);


--
-- TOC entry 4901 (class 2604 OID 25624)
-- Name: stock_ledger id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_ledger ALTER COLUMN id SET DEFAULT nextval('public.stock_ledger_id_seq'::regclass);


--
-- TOC entry 4812 (class 2604 OID 24981)
-- Name: units id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- TOC entry 4862 (class 2604 OID 25328)
-- Name: vendor_delivery_schedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_delivery_schedule ALTER COLUMN id SET DEFAULT nextval('public.vendor_delivery_schedule_id_seq'::regclass);


--
-- TOC entry 4905 (class 2604 OID 25672)
-- Name: vendor_invoices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_invoices ALTER COLUMN id SET DEFAULT nextval('public.vendor_invoices_id_seq'::regclass);


--
-- TOC entry 4868 (class 2604 OID 25392)
-- Name: vendor_quotations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_quotations ALTER COLUMN id SET DEFAULT nextval('public.vendor_quotations_id_seq'::regclass);


--
-- TOC entry 4851 (class 2604 OID 25249)
-- Name: vendor_site_assignments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_assignments ALTER COLUMN id SET DEFAULT nextval('public.vendor_site_assignments_id_seq'::regclass);


--
-- TOC entry 4857 (class 2604 OID 25275)
-- Name: vendor_site_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_items ALTER COLUMN id SET DEFAULT nextval('public.vendor_site_items_id_seq'::regclass);


--
-- TOC entry 4860 (class 2604 OID 25303)
-- Name: vendor_site_pricing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_pricing ALTER COLUMN id SET DEFAULT nextval('public.vendor_site_pricing_id_seq'::regclass);


--
-- TOC entry 4837 (class 2604 OID 25174)
-- Name: vendor_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_types ALTER COLUMN id SET DEFAULT nextval('public.vendor_types_id_seq'::regclass);


--
-- TOC entry 4839 (class 2604 OID 25182)
-- Name: vendors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors ALTER COLUMN id SET DEFAULT nextval('public.vendors_id_seq'::regclass);


--
-- TOC entry 5225 (class 0 OID 25009)
-- Dependencies: 222
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brands (id, name, description, status) FROM stdin;
\.


--
-- TOC entry 5259 (class 0 OID 25365)
-- Dependencies: 256
-- Data for Name: enquiry_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enquiry_items (id, enquiry_id, item_id, quantity, unit_id, remarks) FROM stdin;
\.


--
-- TOC entry 5275 (class 0 OID 25568)
-- Dependencies: 272
-- Data for Name: goods_receipt_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goods_receipt_items (id, goods_receipt_id, item_id, unit_id, quantity_received, unit_price, discount_percent, tax_percent, batch_number, expiry_date, received_quantity_validated, remarks) FROM stdin;
\.


--
-- TOC entry 5273 (class 0 OID 25539)
-- Dependencies: 270
-- Data for Name: goods_receipts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goods_receipts (id, grn_number, purchase_order_id, site_id, vendor_id, grn_date, received_by, status, remarks, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5233 (class 0 OID 25101)
-- Dependencies: 230
-- Data for Name: item_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_attributes (id, item_id, attribute_key, attribute_value) FROM stdin;
\.


--
-- TOC entry 5281 (class 0 OID 25646)
-- Dependencies: 278
-- Data for Name: item_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_batches (id, site_id, item_id, batch_number, expiry_date, quantity, created_at) FROM stdin;
\.


--
-- TOC entry 5221 (class 0 OID 24987)
-- Dependencies: 218
-- Data for Name: item_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_categories (id, name, parent_category_id, status, created_at) FROM stdin;
\.


--
-- TOC entry 5234 (class 0 OID 25112)
-- Dependencies: 231
-- Data for Name: item_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_details (item_id, storage_type, storage_temp_min, storage_temp_max, net_weight, gross_weight, msds_url, packaging_info) FROM stdin;
\.


--
-- TOC entry 5277 (class 0 OID 25595)
-- Dependencies: 274
-- Data for Name: item_stocks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_stocks (id, site_id, item_id, quantity, unit_id, last_updated) FROM stdin;
\.


--
-- TOC entry 5239 (class 0 OID 25155)
-- Dependencies: 236
-- Data for Name: item_tag_map; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_tag_map (item_id, tag_id) FROM stdin;
\.


--
-- TOC entry 5238 (class 0 OID 25147)
-- Dependencies: 235
-- Data for Name: item_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_tags (id, name) FROM stdin;
\.


--
-- TOC entry 5223 (class 0 OID 25001)
-- Dependencies: 220
-- Data for Name: item_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_types (id, name, status) FROM stdin;
\.


--
-- TOC entry 5236 (class 0 OID 25125)
-- Dependencies: 233
-- Data for Name: item_units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_units (id, item_id, from_unit_id, to_unit_id, conversion_rate) FROM stdin;
\.


--
-- TOC entry 5231 (class 0 OID 25053)
-- Dependencies: 228
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items (id, name, sku_code, barcode, category_id, item_type_id, base_unit_id, brand_id, manufacturer_id, model_id, is_perishable, shelf_life_days, is_batch_tracked, is_serial_tracked, has_expiry_date, tax_rate, hsn_code, description, image_url, status, created_at) FROM stdin;
\.


--
-- TOC entry 5227 (class 0 OID 25021)
-- Dependencies: 224
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manufacturers (id, name, contact_person, email, phone, address, status) FROM stdin;
\.


--
-- TOC entry 5229 (class 0 OID 25033)
-- Dependencies: 226
-- Data for Name: models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.models (id, name, brand_id, manufacturer_id, description, status) FROM stdin;
\.


--
-- TOC entry 5257 (class 0 OID 25347)
-- Dependencies: 254
-- Data for Name: purchase_enquiries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_enquiries (id, site_id, reference_no, requested_by, expected_delivery_date, priority_level, status, remarks, created_at) FROM stdin;
2	101	ENQ-20250714-001	John Doe	2025-07-18	High	active	Urgent stock needed for weekend orders	2025-07-14 22:13:41.133333
\.


--
-- TOC entry 5271 (class 0 OID 25507)
-- Dependencies: 268
-- Data for Name: purchase_order_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_order_documents (id, purchase_order_id, doc_type, file_url, uploaded_by, uploaded_at) FROM stdin;
\.


--
-- TOC entry 5267 (class 0 OID 25466)
-- Dependencies: 264
-- Data for Name: purchase_order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_order_items (id, purchase_order_id, item_id, unit_id, quantity, unit_price, discount_percent, tax_percent, total_before_tax, tax_amount, total_after_tax, required_by_date, remarks) FROM stdin;
\.


--
-- TOC entry 5269 (class 0 OID 25492)
-- Dependencies: 266
-- Data for Name: purchase_order_status_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_order_status_log (id, purchase_order_id, status, changed_by, changed_at, remarks) FROM stdin;
\.


--
-- TOC entry 5265 (class 0 OID 25438)
-- Dependencies: 262
-- Data for Name: purchase_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_orders (id, po_number, vendor_id, site_id, order_date, expected_delivery_date, payment_terms, shipping_address, billing_address, shipping_method, currency, total_amount, total_tax, grand_total, status, remarks, created_by, approved_by, created_at, updated_at, enquiry_id, vendor_quotation_id, po_type, billing_site_id) FROM stdin;
\.


--
-- TOC entry 5263 (class 0 OID 25413)
-- Dependencies: 260
-- Data for Name: quotation_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.quotation_items (id, quotation_id, item_id, unit_price, tax_rate, available_quantity, remarks) FROM stdin;
\.


--
-- TOC entry 5245 (class 0 OID 25197)
-- Dependencies: 242
-- Data for Name: site_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site_types (id, name, status) FROM stdin;
1	Warehouse	active
2	Outlet	active
3	Kitchen	active
4	Store Room	active
5	Lab	active
6	Outlet	active
\.


--
-- TOC entry 5247 (class 0 OID 25220)
-- Dependencies: 244
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sites (id, name, code, site_type_id, organization_id, parent_site_id, contact_person_name, contact_phone, contact_email, address_line1, address_line2, city, state, postal_code, country, latitude, longitude, opening_time, closing_time, timezone, supply_mode, is_active, created_at) FROM stdin;
101	Indiranagar Outlet	OUT-BLR-IND	2	\N	\N	John Doe	9876543210	john@restaurant.com	123 1st Main Road, Indiranagar	\N	Bangalore	Karnataka	560038	India	\N	\N	\N	\N	Asia/Kolkata	direct_from_vendor	t	2025-07-14 22:13:33.052941
\.


--
-- TOC entry 5279 (class 0 OID 25621)
-- Dependencies: 276
-- Data for Name: stock_ledger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_ledger (id, site_id, item_id, transaction_type, reference_id, quantity, unit_id, direction, remarks, created_at) FROM stdin;
\.


--
-- TOC entry 5219 (class 0 OID 24978)
-- Dependencies: 216
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.units (id, name, symbol, status, created_at) FROM stdin;
\.


--
-- TOC entry 5255 (class 0 OID 25325)
-- Dependencies: 252
-- Data for Name: vendor_delivery_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_delivery_schedule (id, vendor_id, site_id, day_of_week, delivery_start, delivery_end, created_at) FROM stdin;
\.


--
-- TOC entry 5283 (class 0 OID 25669)
-- Dependencies: 280
-- Data for Name: vendor_invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_invoices (id, invoice_number, vendor_id, grn_id, billing_site_id, invoice_date, amount, tax_amount, payment_status, payment_reference, remarks, created_at) FROM stdin;
\.


--
-- TOC entry 5261 (class 0 OID 25389)
-- Dependencies: 258
-- Data for Name: vendor_quotations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_quotations (id, enquiry_id, vendor_id, quotation_ref, quoted_by, quotation_date, delivery_lead_time_days, validity_days, remarks, status, created_at) FROM stdin;
\.


--
-- TOC entry 5249 (class 0 OID 25246)
-- Dependencies: 246
-- Data for Name: vendor_site_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_site_assignments (id, vendor_id, site_id, supply_mode, preferred, lead_time_days, min_order_value, remarks, status, created_at) FROM stdin;
\.


--
-- TOC entry 5251 (class 0 OID 25272)
-- Dependencies: 248
-- Data for Name: vendor_site_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_site_items (id, vendor_id, site_id, item_id, is_available, remarks, created_at) FROM stdin;
\.


--
-- TOC entry 5253 (class 0 OID 25300)
-- Dependencies: 250
-- Data for Name: vendor_site_pricing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_site_pricing (id, vendor_id, site_id, item_id, price, tax_rate, effective_from) FROM stdin;
\.


--
-- TOC entry 5241 (class 0 OID 25171)
-- Dependencies: 238
-- Data for Name: vendor_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_types (id, name, status) FROM stdin;
1	Manufacturer	active
2	Distributor	active
3	Wholesaler	active
4	Retailer	active
5	Aggregator	active
\.


--
-- TOC entry 5243 (class 0 OID 25179)
-- Dependencies: 240
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendors (id, name, vendor_type_id, contact_person_name, contact_phone, contact_email, alt_phone, alt_email, gst_number, pan_number, fssai_number, website, company_reg_number, address_line1, address_line2, city, state, postal_code, country, payment_terms, credit_limit, bank_account_number, bank_ifsc_code, bank_name, notes, status, created_at) FROM stdin;
1	FreshMeat Distributors	2	Rajesh Kumar	9876543210	rajesh@freshmeat.com	\N	\N	29ABCDE1234FZ1	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	active	2025-07-14 22:12:47.516912
2	EcoPack Solutions	2	Priya Singh	9988776655	priya@ecopack.com	\N	\N	29ABCDE5678XZ2	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	active	2025-07-14 22:12:47.516912
\.


--
-- TOC entry 5321 (class 0 OID 0)
-- Dependencies: 221
-- Name: brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brands_id_seq', 1, false);


--
-- TOC entry 5322 (class 0 OID 0)
-- Dependencies: 255
-- Name: enquiry_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enquiry_items_id_seq', 1, false);


--
-- TOC entry 5323 (class 0 OID 0)
-- Dependencies: 271
-- Name: goods_receipt_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goods_receipt_items_id_seq', 1, false);


--
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 269
-- Name: goods_receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goods_receipts_id_seq', 1, false);


--
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 229
-- Name: item_attributes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_attributes_id_seq', 1, false);


--
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 277
-- Name: item_batches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_batches_id_seq', 1, false);


--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 217
-- Name: item_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_categories_id_seq', 1, false);


--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 273
-- Name: item_stocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_stocks_id_seq', 1, false);


--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 234
-- Name: item_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_tags_id_seq', 1, false);


--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 219
-- Name: item_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_types_id_seq', 1, false);


--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 232
-- Name: item_units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_units_id_seq', 1, false);


--
-- TOC entry 5332 (class 0 OID 0)
-- Dependencies: 227
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.items_id_seq', 1, false);


--
-- TOC entry 5333 (class 0 OID 0)
-- Dependencies: 223
-- Name: manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manufacturers_id_seq', 1, false);


--
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 225
-- Name: models_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.models_id_seq', 1, false);


--
-- TOC entry 5335 (class 0 OID 0)
-- Dependencies: 253
-- Name: purchase_enquiries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_enquiries_id_seq', 2, true);


--
-- TOC entry 5336 (class 0 OID 0)
-- Dependencies: 267
-- Name: purchase_order_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_order_documents_id_seq', 1, false);


--
-- TOC entry 5337 (class 0 OID 0)
-- Dependencies: 263
-- Name: purchase_order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_order_items_id_seq', 1, false);


--
-- TOC entry 5338 (class 0 OID 0)
-- Dependencies: 265
-- Name: purchase_order_status_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_order_status_log_id_seq', 1, false);


--
-- TOC entry 5339 (class 0 OID 0)
-- Dependencies: 261
-- Name: purchase_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchase_orders_id_seq', 1, false);


--
-- TOC entry 5340 (class 0 OID 0)
-- Dependencies: 259
-- Name: quotation_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quotation_items_id_seq', 1, false);


--
-- TOC entry 5341 (class 0 OID 0)
-- Dependencies: 241
-- Name: site_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.site_types_id_seq', 6, true);


--
-- TOC entry 5342 (class 0 OID 0)
-- Dependencies: 243
-- Name: sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sites_id_seq', 1, false);


--
-- TOC entry 5343 (class 0 OID 0)
-- Dependencies: 275
-- Name: stock_ledger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_ledger_id_seq', 1, false);


--
-- TOC entry 5344 (class 0 OID 0)
-- Dependencies: 215
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.units_id_seq', 1, false);


--
-- TOC entry 5345 (class 0 OID 0)
-- Dependencies: 251
-- Name: vendor_delivery_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendor_delivery_schedule_id_seq', 1, false);


--
-- TOC entry 5346 (class 0 OID 0)
-- Dependencies: 279
-- Name: vendor_invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendor_invoices_id_seq', 1, false);


--
-- TOC entry 5347 (class 0 OID 0)
-- Dependencies: 257
-- Name: vendor_quotations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendor_quotations_id_seq', 1, false);


--
-- TOC entry 5348 (class 0 OID 0)
-- Dependencies: 245
-- Name: vendor_site_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendor_site_assignments_id_seq', 1, false);


--
-- TOC entry 5349 (class 0 OID 0)
-- Dependencies: 247
-- Name: vendor_site_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendor_site_items_id_seq', 1, false);


--
-- TOC entry 5350 (class 0 OID 0)
-- Dependencies: 249
-- Name: vendor_site_pricing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendor_site_pricing_id_seq', 1, false);


--
-- TOC entry 5351 (class 0 OID 0)
-- Dependencies: 237
-- Name: vendor_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendor_types_id_seq', 5, true);


--
-- TOC entry 5352 (class 0 OID 0)
-- Dependencies: 239
-- Name: vendors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendors_id_seq', 2, true);


--
-- TOC entry 4916 (class 2606 OID 25019)
-- Name: brands brands_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_name_key UNIQUE (name);


--
-- TOC entry 4918 (class 2606 OID 25017)
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- TOC entry 4974 (class 2606 OID 25372)
-- Name: enquiry_items enquiry_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiry_items
    ADD CONSTRAINT enquiry_items_pkey PRIMARY KEY (id);


--
-- TOC entry 5000 (class 2606 OID 25578)
-- Name: goods_receipt_items goods_receipt_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipt_items
    ADD CONSTRAINT goods_receipt_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4996 (class 2606 OID 25551)
-- Name: goods_receipts goods_receipts_grn_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipts
    ADD CONSTRAINT goods_receipts_grn_number_key UNIQUE (grn_number);


--
-- TOC entry 4998 (class 2606 OID 25549)
-- Name: goods_receipts goods_receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipts
    ADD CONSTRAINT goods_receipts_pkey PRIMARY KEY (id);


--
-- TOC entry 4930 (class 2606 OID 25106)
-- Name: item_attributes item_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attributes
    ADD CONSTRAINT item_attributes_pkey PRIMARY KEY (id);


--
-- TOC entry 5008 (class 2606 OID 25652)
-- Name: item_batches item_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_batches
    ADD CONSTRAINT item_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 4912 (class 2606 OID 24994)
-- Name: item_categories item_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_categories
    ADD CONSTRAINT item_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4932 (class 2606 OID 25118)
-- Name: item_details item_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_details
    ADD CONSTRAINT item_details_pkey PRIMARY KEY (item_id);


--
-- TOC entry 5002 (class 2606 OID 25602)
-- Name: item_stocks item_stocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_stocks
    ADD CONSTRAINT item_stocks_pkey PRIMARY KEY (id);


--
-- TOC entry 5004 (class 2606 OID 25604)
-- Name: item_stocks item_stocks_site_id_item_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_stocks
    ADD CONSTRAINT item_stocks_site_id_item_id_key UNIQUE (site_id, item_id);


--
-- TOC entry 4940 (class 2606 OID 25159)
-- Name: item_tag_map item_tag_map_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_tag_map
    ADD CONSTRAINT item_tag_map_pkey PRIMARY KEY (item_id, tag_id);


--
-- TOC entry 4936 (class 2606 OID 25154)
-- Name: item_tags item_tags_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_tags
    ADD CONSTRAINT item_tags_name_key UNIQUE (name);


--
-- TOC entry 4938 (class 2606 OID 25152)
-- Name: item_tags item_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_tags
    ADD CONSTRAINT item_tags_pkey PRIMARY KEY (id);


--
-- TOC entry 4914 (class 2606 OID 25007)
-- Name: item_types item_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_types
    ADD CONSTRAINT item_types_pkey PRIMARY KEY (id);


--
-- TOC entry 4934 (class 2606 OID 25130)
-- Name: item_units item_units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_units
    ADD CONSTRAINT item_units_pkey PRIMARY KEY (id);


--
-- TOC entry 4926 (class 2606 OID 25067)
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- TOC entry 4928 (class 2606 OID 25069)
-- Name: items items_sku_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_sku_code_key UNIQUE (sku_code);


--
-- TOC entry 4920 (class 2606 OID 25031)
-- Name: manufacturers manufacturers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_name_key UNIQUE (name);


--
-- TOC entry 4922 (class 2606 OID 25029)
-- Name: manufacturers manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY (id);


--
-- TOC entry 4924 (class 2606 OID 25041)
-- Name: models models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (id);


--
-- TOC entry 4970 (class 2606 OID 25356)
-- Name: purchase_enquiries purchase_enquiries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_enquiries
    ADD CONSTRAINT purchase_enquiries_pkey PRIMARY KEY (id);


--
-- TOC entry 4972 (class 2606 OID 25358)
-- Name: purchase_enquiries purchase_enquiries_reference_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_enquiries
    ADD CONSTRAINT purchase_enquiries_reference_no_key UNIQUE (reference_no);


--
-- TOC entry 4994 (class 2606 OID 25515)
-- Name: purchase_order_documents purchase_order_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_documents
    ADD CONSTRAINT purchase_order_documents_pkey PRIMARY KEY (id);


--
-- TOC entry 4990 (class 2606 OID 25475)
-- Name: purchase_order_items purchase_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4992 (class 2606 OID 25500)
-- Name: purchase_order_status_log purchase_order_status_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_status_log
    ADD CONSTRAINT purchase_order_status_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4986 (class 2606 OID 25452)
-- Name: purchase_orders purchase_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4988 (class 2606 OID 25454)
-- Name: purchase_orders purchase_orders_po_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_po_number_key UNIQUE (po_number);


--
-- TOC entry 4982 (class 2606 OID 25421)
-- Name: quotation_items quotation_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation_items
    ADD CONSTRAINT quotation_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4984 (class 2606 OID 25423)
-- Name: quotation_items quotation_items_quotation_id_item_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation_items
    ADD CONSTRAINT quotation_items_quotation_id_item_id_key UNIQUE (quotation_id, item_id);


--
-- TOC entry 4946 (class 2606 OID 25203)
-- Name: site_types site_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_types
    ADD CONSTRAINT site_types_pkey PRIMARY KEY (id);


--
-- TOC entry 4948 (class 2606 OID 25234)
-- Name: sites sites_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_code_key UNIQUE (code);


--
-- TOC entry 4950 (class 2606 OID 25232)
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);


--
-- TOC entry 5006 (class 2606 OID 25629)
-- Name: stock_ledger stock_ledger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_ledger
    ADD CONSTRAINT stock_ledger_pkey PRIMARY KEY (id);


--
-- TOC entry 4910 (class 2606 OID 24985)
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- TOC entry 4967 (class 2606 OID 25332)
-- Name: vendor_delivery_schedule vendor_delivery_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_delivery_schedule
    ADD CONSTRAINT vendor_delivery_schedule_pkey PRIMARY KEY (id);


--
-- TOC entry 5010 (class 2606 OID 25678)
-- Name: vendor_invoices vendor_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_invoices
    ADD CONSTRAINT vendor_invoices_pkey PRIMARY KEY (id);


--
-- TOC entry 4977 (class 2606 OID 25401)
-- Name: vendor_quotations vendor_quotations_enquiry_id_vendor_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_quotations
    ADD CONSTRAINT vendor_quotations_enquiry_id_vendor_id_key UNIQUE (enquiry_id, vendor_id);


--
-- TOC entry 4979 (class 2606 OID 25399)
-- Name: vendor_quotations vendor_quotations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_quotations
    ADD CONSTRAINT vendor_quotations_pkey PRIMARY KEY (id);


--
-- TOC entry 4953 (class 2606 OID 25258)
-- Name: vendor_site_assignments vendor_site_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_assignments
    ADD CONSTRAINT vendor_site_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 4955 (class 2606 OID 25260)
-- Name: vendor_site_assignments vendor_site_assignments_vendor_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_assignments
    ADD CONSTRAINT vendor_site_assignments_vendor_id_site_id_key UNIQUE (vendor_id, site_id);


--
-- TOC entry 4958 (class 2606 OID 25281)
-- Name: vendor_site_items vendor_site_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_items
    ADD CONSTRAINT vendor_site_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4960 (class 2606 OID 25283)
-- Name: vendor_site_items vendor_site_items_vendor_id_site_id_item_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_items
    ADD CONSTRAINT vendor_site_items_vendor_id_site_id_item_id_key UNIQUE (vendor_id, site_id, item_id);


--
-- TOC entry 4963 (class 2606 OID 25306)
-- Name: vendor_site_pricing vendor_site_pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_pricing
    ADD CONSTRAINT vendor_site_pricing_pkey PRIMARY KEY (id);


--
-- TOC entry 4965 (class 2606 OID 25308)
-- Name: vendor_site_pricing vendor_site_pricing_vendor_id_site_id_item_id_effective_fro_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_pricing
    ADD CONSTRAINT vendor_site_pricing_vendor_id_site_id_item_id_effective_fro_key UNIQUE (vendor_id, site_id, item_id, effective_from);


--
-- TOC entry 4942 (class 2606 OID 25177)
-- Name: vendor_types vendor_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_types
    ADD CONSTRAINT vendor_types_pkey PRIMARY KEY (id);


--
-- TOC entry 4944 (class 2606 OID 25189)
-- Name: vendors vendors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_pkey PRIMARY KEY (id);


--
-- TOC entry 4968 (class 1259 OID 25434)
-- Name: idx_enquiry_site; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_enquiry_site ON public.purchase_enquiries USING btree (site_id);


--
-- TOC entry 4975 (class 1259 OID 25435)
-- Name: idx_enquiry_vendor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_enquiry_vendor ON public.vendor_quotations USING btree (enquiry_id, vendor_id);


--
-- TOC entry 4980 (class 1259 OID 25436)
-- Name: idx_quote_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_quote_item ON public.quotation_items USING btree (quotation_id, item_id);


--
-- TOC entry 4961 (class 1259 OID 25345)
-- Name: idx_vendor_pricing; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vendor_pricing ON public.vendor_site_pricing USING btree (vendor_id, site_id, item_id);


--
-- TOC entry 4951 (class 1259 OID 25343)
-- Name: idx_vendor_site; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vendor_site ON public.vendor_site_assignments USING btree (vendor_id, site_id);


--
-- TOC entry 4956 (class 1259 OID 25344)
-- Name: idx_vendor_site_items; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vendor_site_items ON public.vendor_site_items USING btree (vendor_id, site_id, item_id);


--
-- TOC entry 5041 (class 2606 OID 25373)
-- Name: enquiry_items enquiry_items_enquiry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiry_items
    ADD CONSTRAINT enquiry_items_enquiry_id_fkey FOREIGN KEY (enquiry_id) REFERENCES public.purchase_enquiries(id) ON DELETE CASCADE;


--
-- TOC entry 5042 (class 2606 OID 25378)
-- Name: enquiry_items enquiry_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiry_items
    ADD CONSTRAINT enquiry_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5043 (class 2606 OID 25383)
-- Name: enquiry_items enquiry_items_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiry_items
    ADD CONSTRAINT enquiry_items_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- TOC entry 5048 (class 2606 OID 25522)
-- Name: purchase_orders fk_purchase_orders_enquiry; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT fk_purchase_orders_enquiry FOREIGN KEY (enquiry_id) REFERENCES public.purchase_enquiries(id);


--
-- TOC entry 5049 (class 2606 OID 25527)
-- Name: purchase_orders fk_purchase_orders_vendor_quote; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT fk_purchase_orders_vendor_quote FOREIGN KEY (vendor_quotation_id) REFERENCES public.vendor_quotations(id);


--
-- TOC entry 5061 (class 2606 OID 25579)
-- Name: goods_receipt_items goods_receipt_items_goods_receipt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipt_items
    ADD CONSTRAINT goods_receipt_items_goods_receipt_id_fkey FOREIGN KEY (goods_receipt_id) REFERENCES public.goods_receipts(id) ON DELETE CASCADE;


--
-- TOC entry 5062 (class 2606 OID 25584)
-- Name: goods_receipt_items goods_receipt_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipt_items
    ADD CONSTRAINT goods_receipt_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5063 (class 2606 OID 25589)
-- Name: goods_receipt_items goods_receipt_items_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipt_items
    ADD CONSTRAINT goods_receipt_items_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- TOC entry 5058 (class 2606 OID 25552)
-- Name: goods_receipts goods_receipts_purchase_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipts
    ADD CONSTRAINT goods_receipts_purchase_order_id_fkey FOREIGN KEY (purchase_order_id) REFERENCES public.purchase_orders(id);


--
-- TOC entry 5059 (class 2606 OID 25557)
-- Name: goods_receipts goods_receipts_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipts
    ADD CONSTRAINT goods_receipts_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- TOC entry 5060 (class 2606 OID 25562)
-- Name: goods_receipts goods_receipts_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goods_receipts
    ADD CONSTRAINT goods_receipts_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- TOC entry 5020 (class 2606 OID 25107)
-- Name: item_attributes item_attributes_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_attributes
    ADD CONSTRAINT item_attributes_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE CASCADE;


--
-- TOC entry 5070 (class 2606 OID 25658)
-- Name: item_batches item_batches_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_batches
    ADD CONSTRAINT item_batches_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5071 (class 2606 OID 25653)
-- Name: item_batches item_batches_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_batches
    ADD CONSTRAINT item_batches_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- TOC entry 5011 (class 2606 OID 24995)
-- Name: item_categories item_categories_parent_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_categories
    ADD CONSTRAINT item_categories_parent_category_id_fkey FOREIGN KEY (parent_category_id) REFERENCES public.item_categories(id);


--
-- TOC entry 5021 (class 2606 OID 25119)
-- Name: item_details item_details_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_details
    ADD CONSTRAINT item_details_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5064 (class 2606 OID 25610)
-- Name: item_stocks item_stocks_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_stocks
    ADD CONSTRAINT item_stocks_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5065 (class 2606 OID 25605)
-- Name: item_stocks item_stocks_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_stocks
    ADD CONSTRAINT item_stocks_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- TOC entry 5066 (class 2606 OID 25615)
-- Name: item_stocks item_stocks_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_stocks
    ADD CONSTRAINT item_stocks_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- TOC entry 5025 (class 2606 OID 25160)
-- Name: item_tag_map item_tag_map_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_tag_map
    ADD CONSTRAINT item_tag_map_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE CASCADE;


--
-- TOC entry 5026 (class 2606 OID 25165)
-- Name: item_tag_map item_tag_map_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_tag_map
    ADD CONSTRAINT item_tag_map_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.item_tags(id) ON DELETE CASCADE;


--
-- TOC entry 5022 (class 2606 OID 25136)
-- Name: item_units item_units_from_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_units
    ADD CONSTRAINT item_units_from_unit_id_fkey FOREIGN KEY (from_unit_id) REFERENCES public.units(id);


--
-- TOC entry 5023 (class 2606 OID 25131)
-- Name: item_units item_units_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_units
    ADD CONSTRAINT item_units_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5024 (class 2606 OID 25141)
-- Name: item_units item_units_to_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_units
    ADD CONSTRAINT item_units_to_unit_id_fkey FOREIGN KEY (to_unit_id) REFERENCES public.units(id);


--
-- TOC entry 5014 (class 2606 OID 25080)
-- Name: items items_base_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_base_unit_id_fkey FOREIGN KEY (base_unit_id) REFERENCES public.units(id);


--
-- TOC entry 5015 (class 2606 OID 25085)
-- Name: items items_brand_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.brands(id);


--
-- TOC entry 5016 (class 2606 OID 25070)
-- Name: items items_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.item_categories(id);


--
-- TOC entry 5017 (class 2606 OID 25075)
-- Name: items items_item_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_item_type_id_fkey FOREIGN KEY (item_type_id) REFERENCES public.item_types(id);


--
-- TOC entry 5018 (class 2606 OID 25090)
-- Name: items items_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturers(id);


--
-- TOC entry 5019 (class 2606 OID 25095)
-- Name: items items_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_model_id_fkey FOREIGN KEY (model_id) REFERENCES public.models(id);


--
-- TOC entry 5012 (class 2606 OID 25042)
-- Name: models models_brand_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.brands(id);


--
-- TOC entry 5013 (class 2606 OID 25047)
-- Name: models models_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturers(id);


--
-- TOC entry 5040 (class 2606 OID 25359)
-- Name: purchase_enquiries purchase_enquiries_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_enquiries
    ADD CONSTRAINT purchase_enquiries_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- TOC entry 5057 (class 2606 OID 25516)
-- Name: purchase_order_documents purchase_order_documents_purchase_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_documents
    ADD CONSTRAINT purchase_order_documents_purchase_order_id_fkey FOREIGN KEY (purchase_order_id) REFERENCES public.purchase_orders(id) ON DELETE CASCADE;


--
-- TOC entry 5053 (class 2606 OID 25481)
-- Name: purchase_order_items purchase_order_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5054 (class 2606 OID 25476)
-- Name: purchase_order_items purchase_order_items_purchase_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_purchase_order_id_fkey FOREIGN KEY (purchase_order_id) REFERENCES public.purchase_orders(id) ON DELETE CASCADE;


--
-- TOC entry 5055 (class 2606 OID 25486)
-- Name: purchase_order_items purchase_order_items_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_items
    ADD CONSTRAINT purchase_order_items_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- TOC entry 5056 (class 2606 OID 25501)
-- Name: purchase_order_status_log purchase_order_status_log_purchase_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_order_status_log
    ADD CONSTRAINT purchase_order_status_log_purchase_order_id_fkey FOREIGN KEY (purchase_order_id) REFERENCES public.purchase_orders(id) ON DELETE CASCADE;


--
-- TOC entry 5050 (class 2606 OID 25663)
-- Name: purchase_orders purchase_orders_billing_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_billing_site_id_fkey FOREIGN KEY (billing_site_id) REFERENCES public.sites(id);


--
-- TOC entry 5051 (class 2606 OID 25460)
-- Name: purchase_orders purchase_orders_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- TOC entry 5052 (class 2606 OID 25455)
-- Name: purchase_orders purchase_orders_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_orders
    ADD CONSTRAINT purchase_orders_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- TOC entry 5046 (class 2606 OID 25429)
-- Name: quotation_items quotation_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation_items
    ADD CONSTRAINT quotation_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5047 (class 2606 OID 25424)
-- Name: quotation_items quotation_items_quotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quotation_items
    ADD CONSTRAINT quotation_items_quotation_id_fkey FOREIGN KEY (quotation_id) REFERENCES public.vendor_quotations(id) ON DELETE CASCADE;


--
-- TOC entry 5028 (class 2606 OID 25240)
-- Name: sites sites_parent_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_parent_site_id_fkey FOREIGN KEY (parent_site_id) REFERENCES public.sites(id);


--
-- TOC entry 5029 (class 2606 OID 25235)
-- Name: sites sites_site_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_site_type_id_fkey FOREIGN KEY (site_type_id) REFERENCES public.site_types(id);


--
-- TOC entry 5067 (class 2606 OID 25635)
-- Name: stock_ledger stock_ledger_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_ledger
    ADD CONSTRAINT stock_ledger_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5068 (class 2606 OID 25630)
-- Name: stock_ledger stock_ledger_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_ledger
    ADD CONSTRAINT stock_ledger_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- TOC entry 5069 (class 2606 OID 25640)
-- Name: stock_ledger stock_ledger_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_ledger
    ADD CONSTRAINT stock_ledger_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id);


--
-- TOC entry 5038 (class 2606 OID 25338)
-- Name: vendor_delivery_schedule vendor_delivery_schedule_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_delivery_schedule
    ADD CONSTRAINT vendor_delivery_schedule_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- TOC entry 5039 (class 2606 OID 25333)
-- Name: vendor_delivery_schedule vendor_delivery_schedule_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_delivery_schedule
    ADD CONSTRAINT vendor_delivery_schedule_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- TOC entry 5072 (class 2606 OID 25689)
-- Name: vendor_invoices vendor_invoices_billing_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_invoices
    ADD CONSTRAINT vendor_invoices_billing_site_id_fkey FOREIGN KEY (billing_site_id) REFERENCES public.sites(id);


--
-- TOC entry 5073 (class 2606 OID 25684)
-- Name: vendor_invoices vendor_invoices_grn_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_invoices
    ADD CONSTRAINT vendor_invoices_grn_id_fkey FOREIGN KEY (grn_id) REFERENCES public.goods_receipts(id);


--
-- TOC entry 5074 (class 2606 OID 25679)
-- Name: vendor_invoices vendor_invoices_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_invoices
    ADD CONSTRAINT vendor_invoices_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- TOC entry 5044 (class 2606 OID 25402)
-- Name: vendor_quotations vendor_quotations_enquiry_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_quotations
    ADD CONSTRAINT vendor_quotations_enquiry_id_fkey FOREIGN KEY (enquiry_id) REFERENCES public.purchase_enquiries(id) ON DELETE CASCADE;


--
-- TOC entry 5045 (class 2606 OID 25407)
-- Name: vendor_quotations vendor_quotations_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_quotations
    ADD CONSTRAINT vendor_quotations_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- TOC entry 5030 (class 2606 OID 25266)
-- Name: vendor_site_assignments vendor_site_assignments_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_assignments
    ADD CONSTRAINT vendor_site_assignments_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- TOC entry 5031 (class 2606 OID 25261)
-- Name: vendor_site_assignments vendor_site_assignments_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_assignments
    ADD CONSTRAINT vendor_site_assignments_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- TOC entry 5032 (class 2606 OID 25294)
-- Name: vendor_site_items vendor_site_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_items
    ADD CONSTRAINT vendor_site_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5033 (class 2606 OID 25289)
-- Name: vendor_site_items vendor_site_items_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_items
    ADD CONSTRAINT vendor_site_items_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- TOC entry 5034 (class 2606 OID 25284)
-- Name: vendor_site_items vendor_site_items_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_items
    ADD CONSTRAINT vendor_site_items_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- TOC entry 5035 (class 2606 OID 25319)
-- Name: vendor_site_pricing vendor_site_pricing_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_pricing
    ADD CONSTRAINT vendor_site_pricing_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- TOC entry 5036 (class 2606 OID 25314)
-- Name: vendor_site_pricing vendor_site_pricing_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_pricing
    ADD CONSTRAINT vendor_site_pricing_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.sites(id);


--
-- TOC entry 5037 (class 2606 OID 25309)
-- Name: vendor_site_pricing vendor_site_pricing_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_site_pricing
    ADD CONSTRAINT vendor_site_pricing_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendors(id);


--
-- TOC entry 5027 (class 2606 OID 25190)
-- Name: vendors vendors_vendor_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendors
    ADD CONSTRAINT vendors_vendor_type_id_fkey FOREIGN KEY (vendor_type_id) REFERENCES public.vendor_types(id);


-- Completed on 2025-07-14 22:59:38

--
-- PostgreSQL database dump complete
--

