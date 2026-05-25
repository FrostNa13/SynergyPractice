--
-- PostgreSQL database dump
--

\restrict xfv79wzAp9O3ZuBhdl5sWggn4TH7ZwS6zbxEPbNkVG7XXpMrqH0bK0hMWG6wSHS

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
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    booking_id integer NOT NULL,
    client_id integer NOT NULL,
    car_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    total_amount numeric(10,2),
    status character varying(15) DEFAULT 'active'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT bookings_check CHECK ((end_date > start_date)),
    CONSTRAINT bookings_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'completed'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- Name: bookings_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookings_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_booking_id_seq OWNER TO postgres;

--
-- Name: bookings_booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bookings_booking_id_seq OWNED BY public.bookings.booking_id;


--
-- Name: cars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cars (
    car_id integer NOT NULL,
    brand character varying(50) NOT NULL,
    model character varying(50) NOT NULL,
    year smallint NOT NULL,
    license_plate character varying(15) NOT NULL,
    category character varying(20) DEFAULT 'economy'::character varying NOT NULL,
    daily_rate numeric(8,2) NOT NULL,
    status character varying(15) DEFAULT 'available'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT cars_daily_rate_check CHECK ((daily_rate > (0)::numeric)),
    CONSTRAINT cars_status_check CHECK (((status)::text = ANY ((ARRAY['available'::character varying, 'rented'::character varying, 'maintenance'::character varying])::text[]))),
    CONSTRAINT cars_year_check CHECK (((year >= 2000) AND (year <= 2030)))
);


ALTER TABLE public.cars OWNER TO postgres;

--
-- Name: cars_car_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cars_car_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cars_car_id_seq OWNER TO postgres;

--
-- Name: cars_car_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cars_car_id_seq OWNED BY public.cars.car_id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    client_id integer NOT NULL,
    last_name character varying(60) NOT NULL,
    first_name character varying(60) NOT NULL,
    middle_name character varying(60),
    passport_no character varying(20) NOT NULL,
    driver_lic character varying(20) NOT NULL,
    phone character varying(20) NOT NULL,
    email character varying(100),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_client_id_seq OWNER TO postgres;

--
-- Name: clients_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_client_id_seq OWNED BY public.clients.client_id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    last_name character varying(60) NOT NULL,
    first_name character varying(60) NOT NULL,
    "position" character varying(50) NOT NULL,
    login character varying(30) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_employee_id_seq OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    booking_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_date timestamp without time zone DEFAULT now() NOT NULL,
    method character varying(20) NOT NULL,
    status character varying(15) DEFAULT 'completed'::character varying NOT NULL,
    CONSTRAINT payments_amount_check CHECK ((amount > (0)::numeric)),
    CONSTRAINT payments_method_check CHECK (((method)::text = ANY ((ARRAY['cash'::character varying, 'card'::character varying, 'transfer'::character varying])::text[]))),
    CONSTRAINT payments_status_check CHECK (((status)::text = ANY ((ARRAY['completed'::character varying, 'refunded'::character varying, 'pending'::character varying])::text[])))
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_payment_id_seq OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- Name: bookings booking_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings ALTER COLUMN booking_id SET DEFAULT nextval('public.bookings_booking_id_seq'::regclass);


--
-- Name: cars car_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cars ALTER COLUMN car_id SET DEFAULT nextval('public.cars_car_id_seq'::regclass);


--
-- Name: clients client_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN client_id SET DEFAULT nextval('public.clients_client_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (booking_id, client_id, car_id, start_date, end_date, total_amount, status, created_at) FROM stdin;
1	1	3	2026-05-20	2026-05-25	10000.00	active	2026-05-25 04:08:49.930044
2	2	8	2026-05-22	2026-05-27	9000.00	active	2026-05-25 04:08:49.930044
3	3	1	2026-05-10	2026-05-15	22500.00	completed	2026-05-25 04:08:49.930044
4	4	5	2026-06-01	2026-06-05	7600.00	active	2026-05-25 04:08:49.930044
5	5	2	2026-05-18	2026-05-20	4400.00	completed	2026-05-25 04:08:49.930044
\.


--
-- Data for Name: cars; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cars (car_id, brand, model, year, license_plate, category, daily_rate, status, created_at) FROM stdin;
1	Toyota	Camry	2022	А123БВ77	business	4500.00	available	2026-05-25 04:08:49.903581
2	Hyundai	Solaris	2023	В456ГД77	economy	2200.00	available	2026-05-25 04:08:49.903581
3	Kia	Rio	2021	Г789ЕЖ77	economy	2000.00	rented	2026-05-25 04:08:49.903581
4	BMW	5 Series	2022	Д012ЗИ77	premium	8500.00	available	2026-05-25 04:08:49.903581
5	Volkswagen	Polo	2023	Е345КЛ77	economy	1900.00	available	2026-05-25 04:08:49.903581
6	Mercedes	E-Class	2021	Ж678МН77	premium	9200.00	maintenance	2026-05-25 04:08:49.903581
7	Skoda	Octavia	2022	З901ОП77	comfort	3100.00	available	2026-05-25 04:08:49.903581
8	Renault	Logan	2023	И234РС77	economy	1800.00	rented	2026-05-25 04:08:49.903581
9	Ford	Focus	2021	К567ТУ77	comfort	2800.00	available	2026-05-25 04:08:49.903581
10	Lada	Vesta	2023	Л890ФХ77	economy	1600.00	available	2026-05-25 04:08:49.903581
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (client_id, last_name, first_name, middle_name, passport_no, driver_lic, phone, email, created_at) FROM stdin;
1	Иванов	Сергей	Петрович	4510 123456	77АА 123456	+7-916-111-22-33	ivanov@mail.ru	2026-05-25 04:08:49.926668
2	Петрова	Анна	Игоревна	4511 234567	77АА 234567	+7-926-222-33-44	petrova@yandex.ru	2026-05-25 04:08:49.926668
3	Сидоров	Михаил	Александрович	4512 345678	77АА 345678	+7-903-333-44-55	\N	2026-05-25 04:08:49.926668
4	Козлова	Елена	Васильевна	4513 456789	77АА 456789	+7-915-444-55-66	kozlova@gmail.com	2026-05-25 04:08:49.926668
5	Новиков	Дмитрий	Олегович	4514 567890	77АА 567890	+7-985-555-66-77	novikov@mail.ru	2026-05-25 04:08:49.926668
6	Тест	Пользователь	\N	9999 000001	99АА 000001	+7-999-000-00-01	\N	2026-05-25 04:10:16.080531
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (employee_id, last_name, first_name, "position", login, created_at) FROM stdin;
1	Орлов	Дмитрий	Администратор системы	orlov_d	2026-05-25 04:08:49.928444
2	Смирнова	Ольга	Менеджер проката	smirnova_o	2026-05-25 04:08:49.928444
3	Фёдоров	Алексей	Оператор	fedorov_a	2026-05-25 04:08:49.928444
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (payment_id, booking_id, amount, payment_date, method, status) FROM stdin;
1	1	10000.00	2026-05-25 04:08:49.931982	card	completed
2	2	9000.00	2026-05-25 04:08:49.931982	cash	completed
3	3	22500.00	2026-05-25 04:08:49.931982	transfer	completed
4	4	7600.00	2026-05-25 04:08:49.931982	card	completed
5	5	4400.00	2026-05-25 04:08:49.931982	card	completed
\.


--
-- Name: bookings_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookings_booking_id_seq', 5, true);


--
-- Name: cars_car_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cars_car_id_seq', 10, true);


--
-- Name: clients_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_client_id_seq', 6, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 3, true);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 5, true);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (booking_id);


--
-- Name: cars cars_license_plate_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_license_plate_key UNIQUE (license_plate);


--
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (car_id);


--
-- Name: clients clients_driver_lic_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_driver_lic_key UNIQUE (driver_lic);


--
-- Name: clients clients_passport_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_passport_no_key UNIQUE (passport_no);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (client_id);


--
-- Name: employees employees_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_login_key UNIQUE (login);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: bookings bookings_car_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_car_id_fkey FOREIGN KEY (car_id) REFERENCES public.cars(car_id);


--
-- Name: bookings bookings_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(client_id);


--
-- Name: payments payments_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(booking_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO car_manager;
GRANT USAGE ON SCHEMA public TO car_readonly;


--
-- Name: TABLE bookings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.bookings TO db_admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bookings TO car_manager;
GRANT SELECT ON TABLE public.bookings TO car_readonly;


--
-- Name: SEQUENCE bookings_booking_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.bookings_booking_id_seq TO db_admin;
GRANT SELECT,USAGE ON SEQUENCE public.bookings_booking_id_seq TO car_manager;


--
-- Name: TABLE cars; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cars TO db_admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cars TO car_manager;
GRANT SELECT ON TABLE public.cars TO car_readonly;


--
-- Name: SEQUENCE cars_car_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.cars_car_id_seq TO db_admin;
GRANT SELECT,USAGE ON SEQUENCE public.cars_car_id_seq TO car_manager;


--
-- Name: TABLE clients; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.clients TO db_admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.clients TO car_manager;
GRANT SELECT ON TABLE public.clients TO car_readonly;


--
-- Name: SEQUENCE clients_client_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.clients_client_id_seq TO db_admin;
GRANT SELECT,USAGE ON SEQUENCE public.clients_client_id_seq TO car_manager;


--
-- Name: TABLE employees; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.employees TO db_admin;
GRANT SELECT ON TABLE public.employees TO car_manager;


--
-- Name: SEQUENCE employees_employee_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.employees_employee_id_seq TO db_admin;
GRANT SELECT,USAGE ON SEQUENCE public.employees_employee_id_seq TO car_manager;


--
-- Name: TABLE payments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.payments TO db_admin;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.payments TO car_manager;
GRANT SELECT ON TABLE public.payments TO car_readonly;


--
-- Name: SEQUENCE payments_payment_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.payments_payment_id_seq TO db_admin;
GRANT SELECT,USAGE ON SEQUENCE public.payments_payment_id_seq TO car_manager;


--
-- PostgreSQL database dump complete
--

\unrestrict xfv79wzAp9O3ZuBhdl5sWggn4TH7ZwS6zbxEPbNkVG7XXpMrqH0bK0hMWG6wSHS

