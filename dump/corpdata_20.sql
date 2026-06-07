--
-- PostgreSQL database dump
--

\restrict 0ba240YQ2yhZ4g2eWnatxZuKDcu21MZg5f5vSwZCEfshb5cx00mO8SpfX7r7nSr

-- Dumped from database version 16.14 (Ubuntu 16.14-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.14 (Ubuntu 16.14-1.pgdg22.04+1)

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

SET default_table_access_method = heap;

--
-- Name: rentals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rentals (
    id integer NOT NULL,
    plate character varying(20) NOT NULL,
    customer character varying(150) NOT NULL,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone NOT NULL,
    price numeric(10,2) NOT NULL,
    CONSTRAINT rentals_price_check CHECK ((price >= (0)::numeric))
);


ALTER TABLE public.rentals OWNER TO postgres;

--
-- Name: rentals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rentals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rentals_id_seq OWNER TO postgres;

--
-- Name: rentals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rentals_id_seq OWNED BY public.rentals.id;


--
-- Name: rentals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals ALTER COLUMN id SET DEFAULT nextval('public.rentals_id_seq'::regclass);


--
-- Data for Name: rentals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rentals (id, plate, customer, start_at, end_at, price) FROM stdin;
1	А123БВ77	Иванов Сергей Петрович	2026-05-18 09:00:00	2026-05-22 09:00:00	8800.00
2	В456ГД77	Петрова Анна Игоревна	2026-05-20 10:00:00	2026-05-25 10:00:00	11000.00
3	Г789ЕЖ77	Сидоров Михаил Александрович	2026-05-21 12:00:00	2026-05-23 12:00:00	4000.00
4	Д012ЗИ77	Козлова Елена Васильевна	2026-05-22 08:00:00	2026-05-28 08:00:00	51000.00
5	Е345КЛ77	Новиков Дмитрий Олегович	2026-05-23 14:00:00	2026-05-26 14:00:00	5700.00
\.


--
-- Name: rentals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rentals_id_seq', 7, true);


--
-- Name: rentals rentals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT rentals_pkey PRIMARY KEY (id);


--
-- Name: TABLE rentals; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE public.rentals TO client01;
GRANT SELECT,INSERT ON TABLE public.rentals TO client02;
GRANT SELECT ON TABLE public.rentals TO client03;
GRANT SELECT,UPDATE ON TABLE public.rentals TO client04;
GRANT SELECT,DELETE ON TABLE public.rentals TO client05;


--
-- Name: SEQUENCE rentals_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.rentals_id_seq TO client01;
GRANT SELECT,USAGE ON SEQUENCE public.rentals_id_seq TO client02;


--
-- PostgreSQL database dump complete
--

\unrestrict 0ba240YQ2yhZ4g2eWnatxZuKDcu21MZg5f5vSwZCEfshb5cx00mO8SpfX7r7nSr

