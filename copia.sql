PGDMP         5                y         
   transporte     13.3 (Ubuntu 13.3-1.pgdg18.04+1)     13.3 (Ubuntu 13.3-1.pgdg18.04+1) H    '           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            (           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            )           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            *           1262    256278 
   transporte    DATABASE     _   CREATE DATABASE transporte WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
    DROP DATABASE transporte;
                luis    false                        3079    276183    dblink 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;
    DROP EXTENSION dblink;
                   false            +           0    0    EXTENSION dblink    COMMENT     _   COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';
                        false    2                        3079    276844    fuzzystrmatch 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;
    DROP EXTENSION fuzzystrmatch;
                   false            ,           0    0    EXTENSION fuzzystrmatch    COMMENT     ]   COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';
                        false    3            �            1255    276123    impl()    FUNCTION     �  CREATE FUNCTION public.impl() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  rec record;
  contador integer := 0;
BEGIN
  FOR rec IN SELECT * FROM passenger LOOP
    contador := contador + 1;
  END LOOP;
  
  -- insertando valor
  INSERT INTO passenger_count (total, time)
  VALUES (contador, now());
  
  -- Los triggers tienen variables globales muy importantes
  -- OLD es lo que estaba antes del cambio
  -- NEW es lo que hay despues el cambio
  -- Si retornamos NEW es decir que el cambio procede
  -- Si retornamos OLD es decir que mantenga lo anterior y no ejecute el cambio
  -- En un insert OLD no posee ningun valor
  RETURN NEW;
END
$$;
    DROP FUNCTION public.impl();
       public          luis    false            �            1259    256440    journey    TABLE     �   CREATE TABLE public.journey (
    id bigint NOT NULL,
    name character varying(100),
    station_id integer,
    train_id integer
);
    DROP TABLE public.journey;
       public         heap    luis    false            -           0    0    TABLE journey    ACL     O   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.journey TO usuario_consulta;
          public          luis    false    209            �            1259    273308    journey__trip__relation    TABLE     u   CREATE TABLE public.journey__trip__relation (
    id bigint NOT NULL,
    journey_id integer,
    trip_id integer
);
 +   DROP TABLE public.journey__trip__relation;
       public         heap    luis    false            �            1259    273306    journey__trip__relation_id_seq    SEQUENCE     �   CREATE SEQUENCE public.journey__trip__relation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.journey__trip__relation_id_seq;
       public          luis    false    214            .           0    0    journey__trip__relation_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.journey__trip__relation_id_seq OWNED BY public.journey__trip__relation.id;
          public          luis    false    213            �            1259    256438    journey_id_seq    SEQUENCE     w   CREATE SEQUENCE public.journey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.journey_id_seq;
       public          luis    false    209            /           0    0    journey_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.journey_id_seq OWNED BY public.journey.id;
          public          luis    false    208            �            1259    256281 	   passenger    TABLE     �   CREATE TABLE public.passenger (
    id bigint NOT NULL,
    name character varying(100),
    address character varying,
    birthdate date
);
    DROP TABLE public.passenger;
       public         heap    luis    false            0           0    0    TABLE passenger    ACL     Q   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.passenger TO usuario_consulta;
          public          luis    false    203            �            1259    276117    passenger_count    TABLE     s   CREATE TABLE public.passenger_count (
    total integer,
    "time" time with time zone,
    id bigint NOT NULL
);
 #   DROP TABLE public.passenger_count;
       public         heap    luis    false            �            1259    276115    passenger_count_id_seq    SEQUENCE        CREATE SEQUENCE public.passenger_count_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.passenger_count_id_seq;
       public          luis    false    217            1           0    0    passenger_count_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.passenger_count_id_seq OWNED BY public.passenger_count.id;
          public          luis    false    216            �            1259    273289    passenger_generations    VIEW     7  CREATE VIEW public.passenger_generations AS
 SELECT passenger.id,
    passenger.name,
    passenger.address,
    passenger.birthdate,
        CASE
            WHEN (passenger.birthdate > '1999-01-01'::date) THEN 'Gen Z'::text
            ELSE 'Millennials'::text
        END AS "case"
   FROM public.passenger;
 (   DROP VIEW public.passenger_generations;
       public          luis    false    203    203    203    203            �            1259    256279    passenger_id_seq    SEQUENCE     y   CREATE SEQUENCE public.passenger_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.passenger_id_seq;
       public          luis    false    203            2           0    0    passenger_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.passenger_id_seq OWNED BY public.passenger.id;
          public          luis    false    202            �            1259    256300    station    TABLE     x   CREATE TABLE public.station (
    id bigint NOT NULL,
    name character varying(100),
    address character varying
);
    DROP TABLE public.station;
       public         heap    luis    false            3           0    0    TABLE station    ACL     O   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.station TO usuario_consulta;
          public          luis    false    207            �            1259    256298    station_id_seq    SEQUENCE     w   CREATE SEQUENCE public.station_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.station_id_seq;
       public          luis    false    207            4           0    0    station_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.station_id_seq OWNED BY public.station.id;
          public          luis    false    206            �            1259    256292    train    TABLE     n   CREATE TABLE public.train (
    id bigint NOT NULL,
    model character varying(100),
    capacity integer
);
    DROP TABLE public.train;
       public         heap    luis    false            5           0    0    TABLE train    ACL     M   GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.train TO usuario_consulta;
          public          luis    false    205            �            1259    256290    train_id_seq    SEQUENCE     u   CREATE SEQUENCE public.train_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.train_id_seq;
       public          luis    false    205            6           0    0    train_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.train_id_seq OWNED BY public.train.id;
          public          luis    false    204            �            1259    273295    trip    TABLE     �   CREATE TABLE public.trip (
    id bigint NOT NULL,
    passenger_id integer,
    start_trip time without time zone,
    end_trip time without time zone
);
    DROP TABLE public.trip;
       public         heap    luis    false            �            1259    273293    trip_id_seq    SEQUENCE     t   CREATE SEQUENCE public.trip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.trip_id_seq;
       public          luis    false    212            7           0    0    trip_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.trip_id_seq OWNED BY public.trip.id;
          public          luis    false    211            �            1259    273335    trips_post_noon_mview    MATERIALIZED VIEW     �   CREATE MATERIALIZED VIEW public.trips_post_noon_mview AS
 SELECT trip.id,
    trip.passenger_id,
    trip.start_trip,
    trip.end_trip
   FROM public.trip
  WHERE (trip.start_trip > '15:00:00'::time without time zone)
  WITH NO DATA;
 5   DROP MATERIALIZED VIEW public.trips_post_noon_mview;
       public         heap    luis    false    212    212    212    212            y           2604    256443 
   journey id    DEFAULT     h   ALTER TABLE ONLY public.journey ALTER COLUMN id SET DEFAULT nextval('public.journey_id_seq'::regclass);
 9   ALTER TABLE public.journey ALTER COLUMN id DROP DEFAULT;
       public          luis    false    209    208    209            {           2604    273311    journey__trip__relation id    DEFAULT     �   ALTER TABLE ONLY public.journey__trip__relation ALTER COLUMN id SET DEFAULT nextval('public.journey__trip__relation_id_seq'::regclass);
 I   ALTER TABLE public.journey__trip__relation ALTER COLUMN id DROP DEFAULT;
       public          luis    false    214    213    214            v           2604    256284    passenger id    DEFAULT     l   ALTER TABLE ONLY public.passenger ALTER COLUMN id SET DEFAULT nextval('public.passenger_id_seq'::regclass);
 ;   ALTER TABLE public.passenger ALTER COLUMN id DROP DEFAULT;
       public          luis    false    202    203    203            |           2604    276120    passenger_count id    DEFAULT     x   ALTER TABLE ONLY public.passenger_count ALTER COLUMN id SET DEFAULT nextval('public.passenger_count_id_seq'::regclass);
 A   ALTER TABLE public.passenger_count ALTER COLUMN id DROP DEFAULT;
       public          luis    false    216    217    217            x           2604    256303 
   station id    DEFAULT     h   ALTER TABLE ONLY public.station ALTER COLUMN id SET DEFAULT nextval('public.station_id_seq'::regclass);
 9   ALTER TABLE public.station ALTER COLUMN id DROP DEFAULT;
       public          luis    false    207    206    207            w           2604    256295    train id    DEFAULT     d   ALTER TABLE ONLY public.train ALTER COLUMN id SET DEFAULT nextval('public.train_id_seq'::regclass);
 7   ALTER TABLE public.train ALTER COLUMN id DROP DEFAULT;
       public          luis    false    205    204    205            z           2604    273298    trip id    DEFAULT     b   ALTER TABLE ONLY public.trip ALTER COLUMN id SET DEFAULT nextval('public.trip_id_seq'::regclass);
 6   ALTER TABLE public.trip ALTER COLUMN id DROP DEFAULT;
       public          luis    false    212    211    212                      0    256440    journey 
   TABLE DATA           A   COPY public.journey (id, name, station_id, train_id) FROM stdin;
    public          luis    false    209   cP       !          0    273308    journey__trip__relation 
   TABLE DATA           J   COPY public.journey__trip__relation (id, journey_id, trip_id) FROM stdin;
    public          luis    false    214   "y                 0    256281 	   passenger 
   TABLE DATA           A   COPY public.passenger (id, name, address, birthdate) FROM stdin;
    public          luis    false    203   _�       $          0    276117    passenger_count 
   TABLE DATA           <   COPY public.passenger_count (total, "time", id) FROM stdin;
    public          luis    false    217   ��                 0    256300    station 
   TABLE DATA           4   COPY public.station (id, name, address) FROM stdin;
    public          luis    false    207   5�                 0    256292    train 
   TABLE DATA           4   COPY public.train (id, model, capacity) FROM stdin;
    public          luis    false    205   �                0    273295    trip 
   TABLE DATA           F   COPY public.trip (id, passenger_id, start_trip, end_trip) FROM stdin;
    public          luis    false    212   L7      8           0    0    journey__trip__relation_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.journey__trip__relation_id_seq', 1, false);
          public          luis    false    213            9           0    0    journey_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.journey_id_seq', 1005, true);
          public          luis    false    208            :           0    0    passenger_count_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.passenger_count_id_seq', 9, true);
          public          luis    false    216            ;           0    0    passenger_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.passenger_id_seq', 1003, true);
          public          luis    false    202            <           0    0    station_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.station_id_seq', 1007, true);
          public          luis    false    206            =           0    0    train_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.train_id_seq', 1008, true);
          public          luis    false    204            >           0    0    trip_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.trip_id_seq', 1, false);
          public          luis    false    211            �           2606    273313 4   journey__trip__relation journey__trip__relation_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.journey__trip__relation
    ADD CONSTRAINT journey__trip__relation_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.journey__trip__relation DROP CONSTRAINT journey__trip__relation_pkey;
       public            luis    false    214            �           2606    256445    journey journey_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.journey
    ADD CONSTRAINT journey_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.journey DROP CONSTRAINT journey_pkey;
       public            luis    false    209            �           2606    276122 $   passenger_count passenger_count_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.passenger_count
    ADD CONSTRAINT passenger_count_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.passenger_count DROP CONSTRAINT passenger_count_pkey;
       public            luis    false    217            ~           2606    256289    passenger passenger_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.passenger DROP CONSTRAINT passenger_pkey;
       public            luis    false    203            �           2606    256308    station station_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.station DROP CONSTRAINT station_pkey;
       public            luis    false    207            �           2606    256297    train train_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.train
    ADD CONSTRAINT train_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.train DROP CONSTRAINT train_pkey;
       public            luis    false    205            �           2606    273300    trip trip_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_pkey;
       public            luis    false    212            �           2620    276124    passenger mytrigger    TRIGGER     g   CREATE TRIGGER mytrigger AFTER INSERT ON public.passenger FOR EACH ROW EXECUTE FUNCTION public.impl();
 ,   DROP TRIGGER mytrigger ON public.passenger;
       public          luis    false    203    229            �           2620    276125    passenger mytrigger2    TRIGGER     h   CREATE TRIGGER mytrigger2 AFTER DELETE ON public.passenger FOR EACH ROW EXECUTE FUNCTION public.impl();
 -   DROP TRIGGER mytrigger2 ON public.passenger;
       public          luis    false    229    203            �           2606    276131 ?   journey__trip__relation journey__trip__relation_journey_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.journey__trip__relation
    ADD CONSTRAINT journey__trip__relation_journey_id_fkey FOREIGN KEY (journey_id) REFERENCES public.journey(id) ON UPDATE CASCADE ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.journey__trip__relation DROP CONSTRAINT journey__trip__relation_journey_id_fkey;
       public          luis    false    209    214    2948            �           2606    276136 <   journey__trip__relation journey__trip__relation_trip_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.journey__trip__relation
    ADD CONSTRAINT journey__trip__relation_trip_id_fkey FOREIGN KEY (trip_id) REFERENCES public.trip(id) ON UPDATE CASCADE ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.journey__trip__relation DROP CONSTRAINT journey__trip__relation_trip_id_fkey;
       public          luis    false    214    2950    212            �           2606    257811    journey journey_station_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.journey
    ADD CONSTRAINT journey_station_id_fkey FOREIGN KEY (station_id) REFERENCES public.station(id) ON UPDATE CASCADE ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.journey DROP CONSTRAINT journey_station_id_fkey;
       public          luis    false    207    209    2946            �           2606    257816    journey journey_train_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.journey
    ADD CONSTRAINT journey_train_id_fkey FOREIGN KEY (train_id) REFERENCES public.train(id) ON UPDATE CASCADE ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.journey DROP CONSTRAINT journey_train_id_fkey;
       public          luis    false    2944    205    209            �           2606    276126    trip trip_passenger_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.trip
    ADD CONSTRAINT trip_passenger_id_fkey FOREIGN KEY (passenger_id) REFERENCES public.passenger(id) ON UPDATE CASCADE ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.trip DROP CONSTRAINT trip_passenger_id_fkey;
       public          luis    false    212    203    2942            "           0    273335    trips_post_noon_mview    MATERIALIZED VIEW DATA     8   REFRESH MATERIALIZED VIEW public.trips_post_noon_mview;
          public          luis    false    215    3110                  x�U��v�X�m������}�Q��δ�L��ʪ��/�K(Q�$夿���\�<Uy'�KĊ+b�������1�ǧy��!+�"o����xΚ����λ�洌��5}��}����i���h��)�>{w�M�Ð�������&{=,��벲MyQd�v����̺�ȋ2{����IQ7YW�9��s����c��.K�����ø�5m�T��hλ��Y�a��ޜ�wYQ�YYWy�eW�����X�#)�0o��qڏ<�5�׳��vr���M����˰����pΊ�ʊ./���r����鲦.��>LwLi�Y�o��+�����2�Y�'�'�e�]����Y���:/�u��X�����m�v\��i;febkٸ�����d�.���Lxv��Yf�f����a�M�x{�<�j�]��=+n���s��nz��k7̌�2{7���Vr*��WUv����
{��Wu��]�������y�v�+x�e6��*�����+U�UR�e����.Y;���8,;v�����՛��iY�Y�j�R�,���0����#e�ix����]m�*���Ӽ8y>\�;>���Zmj6�������l�֊犜y�Q�lNUw�r��?��aVaM��u�>�Ӗ�K���=+�;�ﺼa{�ۅ#�5�j�7E�z7ϻa�uEY�0Xf7�w͜G�Ğ7U��8�0�.�q���Ow��ƚ��F�ĉ�����6{7>����m�6�^��[ψ�f�1.��ᷞR�g��Xsˑ�e�s���lC�ǥ��ۂ��oǽ�u�^f���N'軬j�� �ۃ�;�� ��ƠD��a���y���ڬ���Vg_��NB@���?�&�XTBF���U�ŧJv����ÄI�v_��F��)0Æ)w�v?��&+�&ﴉ��i�Q��׹Ã�!��ʻ:��5�7찾.f�q�~Gs��#0�i9�M�k}��ﻔ]�s�5��U�g��ix�+<�[҆-�xo��4]���r�]S���=�rr�^�5R�C�lXL��`�֓�`y�4��"2iTU��0c�L��8A�.�v<���e��)e��9�����LNM��A����� �\)���쯬�KΑ���OO��ª��_ ;<�]l����w>�S�}��'�&��-P�6��8ܛ�֞�=�LsJ����[�`)��}�}wZ'��)�� �/-�s/6�Σ3�-6��)�_G�U��<���1��D�p8�λ��:GJ0��/��9�2�Ŕ�ł��h��Xsϒz��<�e>;��c�%���V��D>=���f#�l��|?�U��ݷ�y��3@
�+��_N���Ml}A�#�̘/�P��O����~N��w��2m���>���i$���H��A��U
L�`Io�["�k�X
�b�?1G����E�j<>5�,j~G�{5�h�NCx�e��j5���px�KܫwFk�;�]�G��J<���a�jgXo��Ĥ9���iwK|���#��+�1���RҀ�kV�k�`�
��clsr�����SÂ���ߕ�N�����1��Sf��)�p��fÿ���7�z>�����8�=���i\��_�����8�����T����¡�v�����Ak�	b��Hx���Yu���zF�̍�ruZI8T5�_�#�t�{�t	���e�����&��o9⽟�؎�*� ��t�8L@���|�x}���|��I��b �:�pG0��a[̫�  >ņ�=�w���͋�,�Q\t7���L���~�=%�X�ҿ�\�D�����aa�s@	>Z�N�#�A��l�����+)km�m`#==}e9[��Ŝ9#"�a�nɒ�%?	�݌�'�$�ˊ��W��	6Q����Ѻ�[�k��ʜlt�0�Vd��E���In��j��B����������:c�F���vD��\��a�lD	#7��9=����  ���|�y���՝�z�L�x�ee�C��N|��0��j�·��!v��t�_.\YPg Ed��0�b�R��]V�*g��~>?����N�^&y�Cx� a�B4Jfɪ>�z^�EU$��q��7%B&�Ha/қ����Y+O�&I�!c�WOí�)���L������/�G��o�ΏӉ>�2t}1�w��A����Β� ^��#����3�.�^p?�.DQX�6��̇���$���ʯ�2������

�bbdǫ�_H|��%W+���������FZ4�1���J��do���D��%������n�*~t�Ė\�.��� N�1����;'H��'��1XS�;�+Y�c�SC���~��G�Ё�u�+1�f��I�,��!Z�;K<f�~=F�V>E�6쿲ߐc�	�-�$�%���ִ�%�n������X/��t��~�k�F'v�+}�[�+�.F�=B��đBV�+=�}����G��lU��<<���`zZz
;񄑆U�Bk�����ä��~�C��F�,;���d��;�$}�$J�Y��|O~FD+l�Ha+������O�Ϗ��p��az����s�D�g$0�$���%̣���v��W3�%EJr��h?��M���O֧'��h�j��M�a��s�	��&13%z6\s��Kĭ��VXCG -�1 u: �iY�Q�J:��Uf?��!?�W���l�9xB���/G�c=xVF�y��h\��1�ܛѰ8&���/�g�	]c�b���/KNhk�Pv�]�} (^����� �j��G�O2�0�:-��z0Fس���c4���[�e�2��ô���G�X���@��3�M����_�t����S��̱�A�D���s�n�~m8e����ޞ2��#��!�F�v�Vi�;Ȧ3b{�D���Fx���������Z6#u���\�d*2��t3������Xuo�H(�ޒ�*V���@���.��d ��'�f�#!}�fFI�gpʵDzj�VveDj��4�8Ba�)S4��"��MX�r�*O�O��2�Vr;�O_ηSp�D`,��?0��p���kz"��Φ����#�<��|�}i�} ��s>�`I��ә���޺oI����ʱ���?��,��*Q�8{���s��(V]�"��#��jW��4+Z,S����ҁr)� P�u��U�Q%x�*�B��~�:���S	�X�'�n��cDۛ����1�E�%����Mq��lp������M>l�S��x�7�ΓojA��t�<0�ɿE�c~&�~����&%av�[c�_>TD���h��b����t�0��=�+��jnk���܅'�Q0œ�qt�V*�4��^,�A*Fڗ� 7��<e+ްBpCj��t�V�C�g�7O\�Hg Ϊ�m'	�4G�ר��B�Փ�!�O7g�E��\��HYh�-�$���O֫C��BF$:{H��-�zL�
:��L�eKS�5;��
�\��"i:yCvE�%Q�k$�D؊M�&�6��cz_��_%Ǒ�(�B�O�P]S���E��1���O3�L�faʺ�����fk6����ȕ��/�@�p�P�H||����Ρ>����������Y7h�=�
W�)h��Sn�_��P�aV��/��p���Pq��W�ִ�o}7�@��̨��:�2ݚ_T���]���w�>)��O�+'�~��dKJ������~\�+�z�L8N),��É�"��ah�x�,�wc����Ը��:,����b)��*�.���bN��"�Z5 �Ud*�e9E�����m(��d����SM�c���ݳɕ�!�K՘;-�c(F�Ƈ}�a�^�΢�Ъ �@
���s����F�o���;��x#!؟��s5Y� ,"�!�j��Ҭ��o���w�oZ�(S�?��z|���"��6��ē�\��Ȃ��j�l�q��mV�_�!,�r���W2��A��Ҫմ���}T�Z݄��n8?)F�+	����eq�p@'���HR���BB�y?c���!�Ƈ��,V�A�r%}ʪ���X��^��2hl�:����$3R_ج���h�`���8,��K�\���`C."J��Q��b��΄��8    �k���K�L�W>!K$aϮO���2�杴�a;,k�+�B6�
km��T~ǰC�W�U��&�%�olQ�J��ϻ��$�̨�0
���"�;�$�=�"r���&�Af.b[Et}��+��Fq����n��v�-h��?H�v �?K$o�46��8~{�[�s�P���{P|�H� L�+P0׾9dZ��T�yY/��zخ?q'm�q���L��.�����<����E���5&\Y1bc�J���QO,t(#���_W�����77f��i�y$FB���F\��cW��x��$��gX���M��@H��jj�+�̭�
3��E
6P��N�����uض�=F�;bi��`��l�]������w��1&R�6���5��n:��2Ȩp�`��}�G�T��C�[ɱ:���lZkL;�����~��}�_Z�m�Ūe���U�:��Y�?e�x�Tե�s��X������(�=Fk������j&�%��Q0���g1�&�~ZYgZ悐�ֶ�,A��2�F��iV�c��Czm"@�`����)jBM��&���v�A}�ef9�k����jNe)ed�@S!��<�F�~+D��*��M�R��A��֦����|�ffAVu-H����}
A��]W�i5�`�&T�;Sg<]\s��fO��3�Rkq��]�8p�.bpM�}}ޛ��M�������@�.����d�g��Q<د�0��z����&4-��n4�;M�t���Le�� �)Ċ����tO��,�Xo�	��C׼�V&��a�A2��Sm"xM��
�tpz��ΞYƑ���Î�N��6d�a��R���՜�bσZ��[M������!��!
�ↆh��^����d��B��i
��`Pu�A�x�����D���Ӡ�2��q���[<ucq"'���=�6���N�����P��u&"$�l�ح��T�C�iq�(ճ�_.�!��}W�}��J+�j�J���Ca��މ�k�=��{�^ɱ�q#Tt��U����]'�1n�k>g�5���Q�p�f��-E"C�U�[B���L�k�MȬ��0o\�X��c�G�i��c�o�4_���)DB�c�f�9��.��0�&��'�O�CP?��k&g+ܼ4E[�d����OTb3ބ��R��ڽ�;HLݻշg�lڒ���;{b��Wjf��w>FJY�R欻K��j�V nGMh|�Z��l"*m��d�����y:=V`y���:�!�2�v��}����γgd� #c�8�Lbc�g(� �;�$0��k��|�I>�j�EA6�!}�n�i�x+�+����5�X�u����&Uh
UyR]u!�c�})׻���LٗQwk�::L[cC�"x@H]4-��O�"?@�N<���9���+��p� �۰rP�����]�&؞\)!#V�nȼ���H�o�_�E�_xYuC(��,i�������%��6�����w|��gm��|�&EߐR��|S^�0W:��ax��+_��sq.z1.z�_Ix��"d;�0���|���d �/:,Tk�"���"���"��׌�����Q���֤�}UU_��<�Mĝi�+[r�.�+�w�BI(P5�����, ��ý�O*�qԚv�w-=*L�]���т�^�D?���7"��}�
��A��3�K�ZF�C���P�'+���f��j��#1�����_hK6&�峊�����j7D4������MV.�˨��e؎p�6��N��rhYW���o��w�tӘ^ED�/4r���I^@n�������K��`����<*9��߰˯fH�s�לWD~�/�?_��p�����`������ذ4�n/�z	`6v,�	b���Y��Z`�|���c�$�˃�� ofN�h��6u��½`#����TR �wD�5	��K�d����Rf!"v!�C�j��r���G��x^�C�%��Ma���1(�SW6�o����
�C�h}c%@�;p��^�&����v%Cڰ����T��1���e��G�y�?�&%N�-����_�w	0��Somm�4��,Iw6��=�l�~���HΑ�����cf�F��ھ4?�I���%7��8Fs����bo.�����Eƚ�H��\�����n�O�b�x?}����>a��d!��IR��3JXo��t
���Vcx�pzO�Z�#M���:b�z��Ǟ�`t��[�[��j�@��Qy�~'!�u�W/R����+3����`܀s�$�s�A뿵�U�g�D��C}g��*�av>�T�:�Q�d��i��^-zc.�]w��@�6����ښ��>���D0 5ٮy5�o^n�O*�D��s���㧽I�!�ޜ��iO�����eM�䙡ƴ�,�bdŉ�Ll��"Y�m��+��QӪZr%�O#��D9u�7�+U����F���ȟ�z�|�{�ѭes#�U�|�W�1p*iٱ�n���t���r�<ٻa��D�7����l�B謭m����)@���:bxh��lzd�סD�L&�կ�?m� ZYriC
^��C���y�	&�ƷeW�ʌ�Q�RF��>��Sؕ|�9�T!���t�nK��Z"���^�7���74`������㳟���V��1�p�l�x�����Φ�����5õ|�_�~���7��MQʱ��u�V}xX�M�l2s��B1��Y�jL��j��Y�O���� u�#ݥ�T�r[���ZvL�9Z�4b��݅x�N?L���8��u��&�v�nXPO0�f�P��Q���)j�gjV��ݟ��L;Ho� gbx��[|���dǤ��d�c��A��x����(`2�L�x��,Q�ӯ��h��Kե0���"
t����J���I÷!U�A�-/��g�Okh�h�F�Ȯ�F5 �
0����9ߺbۆ<��2@Y�3{<�;�����#1��=/4�3ǾG["d`���x��hA5�Y�c��ݥ�km��PT]�Q�K�/jb�d�v�9�.zlv��H�`xuj�Kt.+@u/��A!��&�7�{��:Ssd�Hl��{��W��9j��ۨ����إ��XӍ�������a�I�`�lkg�Orۢ��^�_��>%�����X��#f���t�̏kk-I�v��C���l{�~��z��2h���9>�G{CklewԩL�= ���s`���u̶�O6k�k_`��g~d]�~�D�N�����D\�+>�.3���C��?��i 4�ʱ�Gj�6�c����z����]d�-J#�F�?�e�� �/'�$��r%V"�8�B�	�Q��PCL�U������V�_a�#�[)#�X��%��=~��V`��"�luY�WȎ(�U���V��8�����m-�u��=&�6���4�rgI�����ᡚ�w�y6$���uB.Mz7a���N�8��|\;���:�߇�ô�7��v�ZFyo��Y�����8p�։6�U��q�1����>�Xp�Bg�<��o����IluY�UZ�_���8�a�5:5�fw�:�ꚲ�n���/,��C�-��7��%�L	��b���1�gͩ4&3RXBյ��UJ����
˹��I�LEˡ�����ZH�/>.E��-��*z�B ���'C-���`;Q�­{2�T�)�jWWo^:e��K�rS��n�!'l�����P^��t�
��g�%�-���jr��s�ެⷅ�h��i�w	,rw�K�d&)&���H�o�S�2����د"��#����n�.e��Zʫ����n�M5'j�qR:5K��jn�k�q�f��k'.V��tq{&��V�����<��n�������tZ��lq~�<�*�)����4�=L6�Y�(�7/O]YdV�J�m��|W�����g�hKmմՎ���oO�C�8T�\i��������4�G�߲v|Z]3��D�~-Ja��N���Ҍ�L�8�i\�K+\tQ&0O8^�'4��E�Q�1��EW^�S3߮��X������M� ��iy��4��a��_h�Q�e����0��!���L$�V��mz����ս���֥���m����S �Ӭ~V�R�NϋEr5R�\.Cx;�&H���xh�3 �  �a���-,q=��닝%���"�U(sܛ�8E�e��)%Kp��4Ľ��}0���*�������g'kG}}�XLm����k�J����������z���N�v����Ʊ������vUE��!�#���ۡ�p{����[׫"`�|������sBR�������nͥb�D��^g�N�`t���6uԝ�%�i>�DwݬT޼��Q�X�f�Ӆ7:}OA�,c	�>Em�r�������].x���˓�
��E �A7>W!]E�&Y3$���{�L[a/��:��՗^��fV���&���Bg@`"�b��/ѸQZC�1_���&��Z��ڤ\����4��nL��梑�w� (o�o
ɕ�����ǩ��s��3��ki6�h�M����UQQ������TF�e������YfJe�`���|$A٢��N���}�AO�Z��������^Tq��tbk[���Ddj��)��.D�;Vo&k�ێC���=�����"�Ȫ6�Z��6�C�K����������2����`�m�yu��4\Ҙ� f�� ��ު���v%N��&c�n���6�q�'E�pt4FU�M�{b�b�~��0��m\fS�(�q�L����F/u5�O��Xԟ�Jva+�\�m�3�I_��g3���M;-���	�f�$���w�sS�DԊ����K;��E�~i`��S�'�H�����N0��,x���{��8@wCi�{�X�Wv�ԯA�C4�'BG���1��RO2?�ҦK��H���d3q�ikn��$3r�fT���{w}���P��i��� �!��ݿ�W*۸�b�<��B+����ױ���Ӭvc]�����B��l2���FA%B�`u����p����δO:��.��3l
"������t����-	����oO��D��<��j�i�����w����|*~���k����ϺR���֖k���sH�*���!�̽��>fF�����m�ŭ��[7��"l��GJx^���P�RR9��G̭��k}����Cڴ��z]�����e���˵-%�(E����ܲl�5���}��t
���C�j�*��y߂i�?oVo��5�RrNR����/���Mqn��cL��~#������_Hjfo��V�Mp��[C�G/�����]��l�f�%0O`�}7-���tk��t7�-�"Sȶ!)��EY1�_��=����><z���.�����/��R�7꣮:+�{�Ns��}-t��ܻ�l���{����
���'6�}�ժ�������I��TB#՚�^ϡ!4qyy���c��߬�Q���r�@�CM�����/�)���[�}TS�Kf�w�<Es53�`�̓S�7�Q������f�x�3�h΅}��D�ϧ����nV�%�wM��)r���y��4�ͥx��wcKo+�fB����8��r���Κ�����<��r��EW0���<HN����q8����S��h2���V{�B	�Q飨n�y)�)��H������)d�u��[ޱ��|آ�¢��;�&y�h��־�[f�v�5u蕆��A	��lPz~Q�k?	����2�D��ظU��s�'�UN��ā�g5Û"�5�2��ѫ�Z�v������C��q��<ۣm��M�^���!�qKX�Wj&���Z�?�L�w����x�N��)�j^�����ֳ�8λ���j��a����w��z+�}H�$��@%�X[
�x����i��ɦ�nlG�fl)����z�Jidb��r\�I�2X��4 ���~ ��
-^��nJḦ)�G-�U�H�BmѯI�����Ư�:P{4]�a�����z��~��/
؊�����Ol�'Yʽ�ٺ�����YE��ikBU�לzf|��(�-��J�,�D(|�&���ލ�?M��b�}3��P��&�OJ�v�!1�v)�?���Yޯ}�~� o�S�_��\�� R��v�Y�d&�z�ޢ[1��� ٟ�^��a&zXǋrK�ެ��6,�'I���p��Q�t�Z�g��?�������<%���f�M�]�/j��g�S�q>���\ɕ�d]�}�5�5���}���0_$�2���`z��^e�/=j�u�M���G�4���?�y��!�rl� L�um��5�G���t���W���L��9      !      x�-�۵])���ڼ!��T5����6���Z-��k��v���N�~v��}��4~�������7gY�Z�_�fٿ����������Q.��z��!��g�R������W*k��������h����h��:�
����7k��ߥfG������[{�����X�M�ZKk��}�uO�����s�qr��̈�����7�*�/�7[/�j3h�Z�~\fi���뫱�[:�l~��*�F7��E���������+���l�[?���ڽ�]PѮ쳌����r�Q믱��~#s v��)c0cc�U�dF�G��u|e�'~�"c0)q��w��q�Q�J�&�)�}.����3���*�P]��D�ug/L��p���qlv2M���ux�_Y,t���j.�ah�l5��z���Zh��Ņ
��n�`~���4��4��3�5v�/f��~�smE���l&����6��Oy�*̢�+Ccu���|h�����|;���L�/5���a%F��W͑����h�r��C��b�����X�#}��zc vȱ�Z�p,���l����\�B���rYkߘ�����־�`�mj���t5��^�nᚍ[�(�9V���W�x�����݁㢋��*c���з�����g��zVGV�^���19��8=���Wӿ?�mt��J�p��4{z�g�W��an���X�q����&�;�{��̭���U�2��[���.2y�ڴ��:Q�E~��P��Mg��;2J攝��m�{�N�����$�q����*�y*�	��|��8���9Lżq�lx��< µ�9�z 'B�����^?C׀��u�x���.�S�\4=�hp�Y>�`&�� �-�l9@k8era�-2J�B�JM��Ͷ���5v�cq���N��#8DDA��:Ġ!Z�s1�����ѫ,!Kb�)�y�3.pU"�{��B�ݟW�O���g���~����H"W�<����E�	�9G(qNΪwe�#�º����p�>�ud`�Z��-��ϰSlo������T^���8%�=��O߲�2.Y9������h�q���I���oS��{��V�����G�\�Ӱ*÷������x=�o�K����Fi˫����~�����.�?u
�G�6d{�n07b0�ti����(�70��j�gY1���)T�`��>c��3H�p�]I�n�(�iw����,l��A��W������J]�C�i�E�'�e;��P@Aw�%+��XV��Ql���!7���ǭ�5�2&�؍��M�@��A^�B��`����c�<��|�y�k�-Z�h�DⷆG���
x�d#�U�"��?èm����A"8"��61Kd�<�eq�P4p�5jD��Ɛ�P��m�>���� h�*���o�˚:���}�kXT��`mU�O�݄GK����J�6 "����22*��D�6�"@�tj��,Fm�VonS�*����y)��"�9��%Q�ؙ=�q�.��o��q�s���Þ��34���
7@j	~�������Pv���qٝ����1�g
�i�a�Z��P4�,ZT92��0H�}TՎ�'w�n��N��މa}k0r�X�a��\
�հ�i��*�(YVU�� ލ=��2�^��	����;�VhC��]S��y��a=^q��R$V���k���'<{l�8�!����m���O�X_�#ç���A�kz�(-w�}���mEb���7�qV̠�Pz�����1z����ݰy��L���tK:��.0��ļ��'��r
��㏜�!1�$}�O� ����ޘ)`�lVF0b;2���1e�շ�ha��a�7��/Gr:.ld��B��xX7�q͹�Ff� �\�	�!��t�=ȃ�+l;�w�،��?u>�ٿ�Z7y�%�yz�a��)�P܆+�H�d�p�=�΃��P�>4b���w`t6+�W��}hN�:}��F�h\��Ȫ����.�i���o7!��]C�Y�k_+H�%@�bb-��#cy��mN���?X��v�4"�bG┩��(ܥ������R>�W�h����5y�3d!0fo��׍y»h(6|f�2Y)c��qC��܏��r���a�a������V�B�!
���ۛ�h�k�����{�4	���Iu�&F����$Y��oQ�9�n0���|�H⚒��M L}�Me*���X���m|�T7�'���]!���qji�N��Xqp,��/@&u����& � 7S�pZ0�����Q�p�-�5��s���.NeV*�����M��>�jYH����1Ǭ:c�U�S_27p�+�S$�S<w��A�h,�Ds'<I2VS�䈌���q.Q?��:�����H�է�<(��~�tu1d���F��!f��4�j�6�`#�i	���ڐ.���j�k
�I������zѰ"d�0�D&�C��OZ��D"��w��V�[��9��Ho�dHF��5�x��V2b���^	���V-Ù���F�.��&hl���2��汱A���dWՆ�����G�<	[t�u�xX�b��8�D��Rϓ&yp|�P�;�DeH�K�f�c=bhnMڞ�w|,;�(���,�bIwY)�R�T{���U��dN�N9D&�G;5�3�Q���QF����
0yݻ+������M6l>9ΗB���px	r��L/�$�g;��}�����>3�"���K���j0Q��ې*�
��k׃ݤN%�*a�����5�}-��/� "i���&Y]�g�I'��^Ĝ��n�����*eX�4#5p���6z�,��F2�).Օ�&�['����`�4���3E6���d�eV1"F?�	��LlC���ˊ�1(��*�3�T����d+& Ϥ����w)��|��h69����+��~Z]20Xm�,�c�R#+ݖZ�J!�#6	�X��x���&8�e�Ӹ�.͔�W� ����jB`����U��}�E7��d���$ɨ�	 V��Y*X���dlGM���E%#+�I��'���
�ײ�)���1XdZ�>�3P�֘��u���@���K��+��G9��K
�$�xb����f X:��&6'!m��%�)�+֒����%�f�\2�}�"O��4v��b9��N�Ϝ\uNn��ļtS9� d�K*Wd-=U�W=�&����_�,��/���Q��pCCAL:�0�Ze�:�g�I4G��򧞲���՘�޽���YR��/ݟ�T��ٔ��eYf3��"0Y-�� ����w��B��^ )�n�G����#߯5���м�5�`Z8�Y�&-2�5 &��n+GEjh��l1y����y͒��9�̑@���R����؄Y���V���F8��>��9{����6��UOd	���pa��i���lY���LX�%yk1��;E1΀l�u�VjLQ��f�˞VY��ý֚�i�i濿��K�,vi�� � �c�UЎ�S�2��re����3��i�s��$�Θ��ӗ���5m
I���e�H�V����Tv�2�#�E6�~�L�.�%TTe����,��/ ��d��A'� ���5x�fY�@0U��kU��w��>�Me�W��k;R���א���&�L�/�fz9\��wf����n�I����e4���Ԓ�B��Kl����Z��ށU=�ʍ٥L����2��T[-y����jH����gKx!�)dMe`�Ȅ�C���Fښ9_?/����2D���j+�\M���LM�n4Y�r�w�<��;�r��
��J��Fd��R6��$o�@�?e1B�f��N�ٰs�nճ� �x�׶���yO,XG������n�e���yK�;TW#��
-�1�8[��!#m��l�y��m�̱.�UΆ-�~��e���l�p�_Zu��ٞ��J~yI����ؙ�(�j;c4�1;�	V�-`�MWt����ݖ�!�ΐ��M+C�S�XȂ���eΐX���dw�`!�Ȗ[n�U !].�S\� �=���ie��N�-X�@ (  _�ت�f�b���z����|M`�]"o�y[3_AdY����t�Oa��6}����_����By�nYv{��=�<�r�符l�c�=]h�7��k�G�.��I�LyK��!��S��,�v�9��(�w�,�L?yۜ�eA��;�7�?����P��b�v-���'k>lA�&I�����b��ks�}i�)�9��i�O_����~|6ҿ��rBM2*���ǭC�����D��ص��b}kK���x#Z�T\�,��!b{Y�Is{'��I���]�r�R&1�lY5P��%��KG8L���/w:v�m6�܇��4K�0%�����)�Aj!>�!E����.d�q�6l�[rɽ���w�w�'����#�ջb��6�ܰ��ښ�
an�JV���"���V�����oS�������J�g 
`W��)��[L3�=D�E�ZN��9��-g���_@�9�0f6�O�u��A�W[����ܞ��|[񘡭{R��1Ϊ�Nlx$��<_]�$��}J�Gc&��Q���[�rux�^lͦo�ۋ4p�E�.��I����_i��´%�d�=����iM��� ���P�OsE�DI>6���1�ep���ʳ@b,0��Af0�"���껏Mf��6��}��>]�ة�Y��b���Y����L�|�"#�܃��T�'��{�'��Ǻ�����d��N���/;-�i;&i���-4���޷@�@@e��W|v��k���0<�|/�6!�ߕW�����<�����y�Sn?�%�/�۬P���Y�$|$)�I`���>`AƼ5%0R�����W:���������yc�ି���*0��ؚ$��'ڿE+�D;;o�����!��@���\�#m�����'��o��#_�HN-gx�Wɻ��	X���,>K���]�?y�a|RM�ʤK_���h�˱#6Y��Y��lK>Ztr�1�{1�y�~�����������K�OhzU��j��o����u�����ؾ� 4�lsm�
��27��=/�|�t��N�j�,�M����Z�JV�f_q������>_�(>2�/���֔��-V�x�Ԋ�S�Ϙ�]L���w��M��T}�C����dJ�7�_���P_�奥�A�{�i�y_%�l�_��"fb����ǙS#ϳ6�� t[���IM�t]��=SP�$Kxq"���ʷզ嘼�4E.��4�R�2�Ϋ�V�OZ��5���$�Eo�����ǋ��5S���y7/�v��V���~c��U+w��Q�㥮>߱����v¢BDs9�'�Gt5����7u�A�t?�������`�yqiJ`��ޏG��Z��"�T�K� 	׮�:AÕ2��k�o�4��ג������Og�:�L����G�}�����';���h
���ch>�t]�"��P��=�o���$�å�t�kDZ�p�;]��#��e�M77*��wֱ�-@y���{�����$�� ^-��|�xOҕ�R�y���O:���P��ir������^;JT`�G���l��E��gbcnSx��6�o_��H��{�z}�$Z�B2�&����R��-ce�            x��}�v�Ȓ�3��� �ӣey��ض�|�Y����#�P��d��߽#1dB��mDfƴ#vD���vw��������ph���f׮��ou��޻Wy�J�*{:ΙZ}j���Mw��w�*�^�ʾw�f�(V?�f�����[��Û�����هf߷��XgJ9gW�}�n��y����v��ի"U����ߪ�ڦjo��U�>5�׋�Ui.l��i��>s��W��>���_^>�>��e��}��r�[�z߷����<�-��|�v��2��Տ�~�=��z�g
���/�<{�m��:���羚���r�JE��in�m{:d��M�m���q~NskssQ���v�o��3.1~[��(T���4����fέ��v]7}_��N��
<�/�*�\��8(��ѝ��䨴|��#��y���O���h��n�Wq��Ea�O�eW�N�mӯ>��f8���f�����;���j���ݴ���[%�Ktٗ��D<����z?˘�o�e�����6+��c1���Sٟ���n3���_:����~I�,���8�{,|{�ݜ�^�W�{U�ReWݾ��t��ب����ٟ��d�M��*��g�+V��������~������.��{�]��xù.uQ��=v��T������L����l�j�S�J��g�E_�/t܉��(]����s�[3[f���0F2X��`>��o�r�����w����6�~��ʳ�uj�=a?�Տc�4�OBkU�}��Am��s��7���UX��P�%�����/��=�p�e���6X������ږ�K{�F'2������3uC,�(Z�yy�4t���ԙ3X��{|�V���Ƕ��V㘔�~�Fԙ�8��]���Wg��DV݅�ٷ��w�. f�S��'9�ϱR�}:��v+�V�.����M����0|������ DE���u7�ΉN�|�����|������ӻrJRi/��}��dƨb���<��mQ��L�2{�;o�&������9�yc�.*��j[�ˢ������}L�NQ=+��_�.+K]ZX��	r<=f�^�m��NX���68�c��Bd���L�vݝ�~���m$}�h9d��f?���so~l������~+\Ń�\��t:�=�ߖd�o!���Ch��L���6�>0�G/fB]�<��Vg����n�v}9#g�Vd���4�Ɍ�==,����2���{|J�Ӧr_�Uh1�B+l_E�
��}_Ïn�Y~�+��ۇf{�z���u��:x�d�a��&���B�+J����A�G���6�<��B��2�G�Qr|������G\���@;5|i�����l^��U&�E>��)[]B'�����Յ)�率��1�ō����Ŕ���� �Ͷ�3�AߎM3�����Ϭ�y)���S�)J��*�XC���f��m=+��d8x����C��Y}��xL[���0�Q���W0<�5�ا����"��s�fW�S���t�?`ӛ�@�6Dp��m���x�zi9W�O�����ۿ�]��7�#sTn�g����j���5ϰ���%�8���mP�X��<+�_^�2�w�@�c�;l���N��Y�}ۜ��3t�z}:�v��&R���4?=b#h��6�z��a�1�{�RM[i%�\#��h��vs�OQL/ߋ0�}z�Zx�Ç��fy��@l�;7����<���9/�����.{_7�-��~�q:Ҿ�*$v�������'�?��Xh�˩搁V�4}\#���9����s�]ʼ�s(溩O˨�����n��\���/������T�w{{����F��և�F8��IW�up"y����C��Ss������K����v/��o�����쪹�A�hF[�WEr0W���H���]�l�X�(l����9ėl���J�<�&b|_9�G�%����QĹ�q`"���s�$j׫+�3��u���V�q�t�u�d��5�_f�88X�.[����^@$"A�e/��~�tZ4)���L"&���=��ZO;}>��Ģ�xt���{ �����慙.�;M���VpM =X�12bA���r�Xs��\���;�KbB�1܅Ǒ����a�(��l7�#ӆ��Ex���⧌�J"�ݮ=F���� �r��=��v{��s��<Tm���,�%-��f�OY�jΊam���xR�iHb�Q~���劆�E��Rq�8�Q�$R*�^j�NԔ�vF1Z�Cg�HnG����b�مdy8 �WW�CwL���P��"����cx"0��]���s.�|�����6O�%�L��	�$v������8�q�l�.����AB oح�91|JR6@��_�	b�C����z��J
@�k��z�0!�0�f�l�4p2�F	0yۛD��Aa ���-����Ù5��Bi\��m(�q�u�=P
�RB�1�݈@V��/{|�#��p��E�W��(o����@l�������]JqQd���"*�P�9��=sQ�<]�!Sph��eY$ ��S�2�4�WMO?�g5�����	�m�� =�x�l���	���4��U�k+�8� �w�D�r�n-�(�|L	(�{�P��,bq�8c �^y����'.�Qr �W��y8���������#`��uπ�b«��SO)? ����d�|ap6Wp<�!YN.�b	d��==�Ye�`�k)�FLP���1,��xٝ�ӹ�C� ����v8�
���i{h ��h_ ۇ����ѫװm�m��s}��8�P����fԇ/����034��@����d֌�u�m?���א�V T�5���aCٕ$�>�qC�4�x�4s���*�-���M^�:���1�,+���-��nKT�f��yk�oʄ��L���R4��-�~ ��;_�e�~%)�2����q� �	�+ƻYae��������|���� ����	^��a�gRo5����/�mVj��p�?��u��� �����	'x�5�m�7,%�WI���Ŝ��S�j��hI���)A��a�o(�u�x�D��C$`W:��(��������ֆh1wI�hZ������p̺��x��QPbd� ����D����-T�˱��"�W���;u��̒�![�s��FY�8��{ ;D��Þf	���kQm������Y�Z	�,4��Q�'�@�r�ql�5�z�z�x��e��>��^d_��z�(��<����X����kh��i��8i���:ZB��:�5?�I��VC����?��Cf��r{jV����fE�M&Z*J	Q]}>�qN��A�K/�g��8E9$�ne�0V)��
/ʀ75!�Y0����-��Y������$g"�0@�-�E�+^D4&<��Қ�M�h!�f{�s��F�t�@5����	��66{��f�@5z-���L��d13�g����J�*�B�1Fq�nY&��0���������ߴ9C,�V�����_�z'�C�eKh�]� T�Ƨ�W��*Z���ҭ����k�*�Ϥ��oa�`�MN}�(����e���A#��W"�H�q]!*n���� P�`�D�P9*,������>իw�	m#(��:"�m�Ucv��� ���#~8ԇ��Ӄ�4��$V���\ވg+��2��DQq�'�Fඓ��'�c�ssN=uP&y�����{U��8E�H ��Ň��0�J�!9\8NO/��iSKm`;a�B��Ӳ�$(�?ǩ%Q�3���w�o�3�㶎��2T8��6G�B����� 0ox>T
��v���X��	t���*$�%G0U�.!�}8N�S�֧-S��;�(��dM_ ʒ C�إ�Q�����/d�~�r+���vNb��z�XC�v�o��%�ܟ���)n�|�O⫱"Tx�}�o�uko�E�(PWP��1$�+����n2�W�`&�b61�-$�g�;�+�r<��J�u��{ĩ�ð��Z��6Iχ ���C�wLm"��=v��2C^�$�)N�k��ZP<�d����9�    #$��AG����F�î�(�wD���P2D�� Y��UH�6D�s&	a��y��}�3��}o�u\�a��/�w��P��^ʒQ�$Kg3J�6�[D"����z���>�T)e������3O�żŊa�f�Z��2Gp|s�z����®x	lSN/��)v�;R�ٟ'�s����%P�Q
1;Og%��~:<,
>�C�E�]5O-�$�Ɋ5��)�T�!�X
�&�@��=ua�?�p�8b��(&z<�Bg?�F��U	���j�ea����Al����g��%���NB��8_��c\����!lHw���!�|�l��P4���bC��B�Ż&���xA�3�X8x��T&�6,`�w;ć�	���&J�����゘M��$����:�$�J�|(;�_��G���d��/,6E	��7�e��v���G�i���`n�0LEfB�LX��M�@�x���β��$���V�ª��A��<�_}�.���@K	�-�*x�#}6��,�Tw.��><��R�'�}g�5_<��7�g�7~��H� 	�4D�B>T4�� L�<($���  ���운8d�+ß�x�<!�U"�$Lɪ��y|d�AM��4O6��o�c2�oWN�6
nQ	��o�cV��%�Q����,��H��;#�� �Ǳ�3P\U���&CL�T,"�ۖ���]}:�ܔx �`���yKf���{>��3����S�4�$�q�:�
���gh�2�/���L�Wr���VB�!������K���l��ڬ�n#�P>�qJ����8���Τ��}SE��:R�>w�: ��WE�
@���7˛��M���_t�O�1�}{���(	N��L.e	��]���,$S4?5\�pt������9V��R��&�偀K�h�	"ʰ"�MI���ݓ���?����Kw��� ��	o�k�CF�KsN����(��YV:g>׫��$<ɧ*�%����TN^����%�X���_vg|�ӈ��{��ű=��d�>���O9pDJ�z�j:R�`5��Ң��(
�p��H��U>��R<�Ր��pLF�٘I{� �J���nǐu,��������������J �o��=�d�D־���*��'�]Z�(�e���P��V�/63�'�)U�/B���x�4 �Ґzt���C�S�,G	/�¬R��y1�І��<�V �����]^��8��-f��K�U(�ŵ0F�x�Ⱦ7O��!UoL~����҆z&!�z��p�(g�$��S����qI=�Ȅ��O���Еy��
�H��b���?�n[���]�(5X-�4>P��(1���D�7;9HU���	 �"1:�ɳ�_u8�n=J*$�Zha%p�U�/�E��$e5����?�c�.����wLz=��Ƣ_�=SbR���@��<��ʇ'���=\=���������׉� �j�9nB�9+X�-������9��Oy���u�>CQ�̚2^��C��dٿ�r�R��)���u!�Q ��m�����8�O�𷽈�x��r�r�%� �]�䫱U9�E��Đ������
F�<!��K�=l� x��[8O`��X�#�+����Dit�����0Fz�t����`�1L0�d(���t�{�"���1�� &NB�T�D�����I%���"�<QK�ł~���E�"��6�cS��RT	O2l��Ko�T���� �/;�"rx��O�Iއ�[�� ����8|����لo���yY�B�J�>���T�a?���d�c,4�
�4���
|�i= ����B������4����=.�594��l�]�s��M/0�K�� ����L(Ú"^o�t���H$j�����#�,=�2�s�bu/��Ne�8������	��L��|�=�����?Ԣ�2�Պ4�r�lWͺ��P�J�tdM�M�
����7�E&V(�
��{}���L,�$��ުm�E, �JRn���{��~kw�M�q������P����m�i�� jogk���_��A���z7�$���c,�v'ꊝmw����3��t��XB�\¿�#8`�5M��Ή<d�>�x�+7���O���ǟeC}��bk�&�?<��x �Ͼ4�fU���T��r�����><��	�E�Vߧ-�p���9���*��gQ�zQ�+����¶�M�;�P
�1.�
���\�Ԋ{]�('��O.d��(�I�/0�@;v��p�=n�]�!{���!5�}�I6��G��)�R����y41,��R<�5R��E���	���7�"��%݈��,��f��>lfYm@0@N)���
X?֛��[&�oR��C꥖��>$�I���
ku�i�<K���~H�DD;�>��e�0�k�$K���c���*V�?��͑[I�9s
��CM�țEl�p���߻�v/��z������t��0ԄM�'�����p��Pv<K��@m�@;T���5�n��C�y�qb�X���������9���d_�U{��ߐU�k�3�@EE���L�@�TCGP)%��J���x�2̝D���x)�I>��L%n8�p���ô�}�K�BOP,�6�ܒ���vs�O�"h�G�>qM����@mc[�s�c���)�C���lZ%ǡ�����ɉS��E��p����<[ds7J$T{>�`?q���5v3���k���Q� ��U�Z�h3p<
v$���21����0x۝�d%~�oa���l; �������6��mS��G���[�(ֲC�ב����c�$�b�hd ���ӷ�1" �8`�r`\(CV��jS�ۑ�DU��{��. 돑۴�zH��l�3iq*5��wl5������� �ASR� �3.pEϢ,0���_�[�4߀���ook��D\Lh@�����z�{쨳N�� !�$����!e����(`z�k9!�[O�:BG&P���z@��E�B�&�cJ�^	�%Ҋ}[R��%[�w����<�=k�Q���ee�I=�-Kv�m7����L�no�L6D��0T�Y#������ð�AfFB�|��$`�H�t�K�+w��I��Љ� �_����,�*��VH�
��>`���>��S��rV��q �/eQM|��n#��I�Wȭ�0�!�{\rq�@�l6)�ds�H��Ӵ�@o���J#�,MRΠ�j��� vz���e��P�G���xhSq�~�s��A0R���v`$�#����$�(������L��@�\A��#��盖[���Fr��n�X��`F�}�#�+�f�8
� ��"{+�닾c�%0�@������!8������!���bey~�B�S�:�K6ϼ���={��;Y��$Ccpʙ�ʢ�
��b2��� Y�;fnf3�o��c���,�<A@wq�5���z��LzPC�"����I�jd��m
R����!���X���b`���_�����k\�_n��kW!V��tdB�V�_��1�x��v����;��U��B���%Ţ�o*���Pya���O	Ϫ�%�O�>�M���]����S��s89���*�c�w���BW��_``��`�ػ6Pufvh`9T����Ge��J!&���`1Qe>��#����
���u�.�yYUS7CLK����١td���M��r"��~���+������C��{�E�'×4a��4�vR���=�[2I�T �So�C40&��&�24�:a��[i̧�J+NT��ᕞ��4�ŽLI�{X6��-�D�@��
��u�����U˿�;�elY���Uxe�fV[����P=+�y�$� M83/�g�\��A�M�@oI9EU��J�������Eb���fH�W���Y�sy17�ϭa��V�R�j?`e$�V�����3ːx��G	�
V�����$�d�@�eC)$��5���I�ge�����1h�_�k�qYUrH�"b�d�ʒh�Q�"�(������g��)U�����F����e�F>v}+ַ~�%�*��� �    ������3,���;����_�_o�n��Y4� f��Y)�<�%���Y]Bd7i�1������!A�K�+
0""�K]�t?�j��{5�}U�9��{!�%�rL�T�x߬�/L�$�i?�$$�B�o��O�j:el$>\�qU%�|��۔���� ��2�)��x�9b��(���ӆ�μ��aI/�RUI�����i�����/g&��^���bb�h��<�rl�sj�?��e�Ɓ�7@|j��G��N��
6| �$�
��U�u�[�#��U���;�_t9@��CAb�
�|v���^��r�L4&����[1`�wP���Z��]d&bC�����5�U�v5pC>*�Cx& �W��Gfnp,�B�4Ã5;�96H[�i��ɇ'�h��8l�Ř���*��5l ~$wl⤅�37LY ��V������_�4�,,M(�T�̾vs���1(v�pnH�%^�����ȌB�"_���?5G�4�"���_K�̘��O!Z��<��tG�?�a1��, �ej�$�I�/}	0��M{ķ�cB�>Ke8~h$رO�),ɴM�b�	��@����EB%��Ґ�W�6�\�����G�YI�/��ҋU���!reF��5+��uB�����㦯7�.S�lhK�����X�o��dLP5�����
����s�� �ww�)�!�d* �#��*N�C�hoBƦ�l�`�Բ*qD�%^&JIA�쿄M`f�ut�aR�ǌ��""��h g�H�\p`�7a1�A(\!n�T�S/���\)�J�K��r�}�2ɯWN�`���, �S�.v�!+7��4�(1ɀ�bi���ٟ2^��v�}��Ch�{k��N�2��,R|���#�`��1�\T���+�G5�9]�t�ٯ���xEL�@W>�ڿ������ôۜM2m��U|�d-�����j��	���b`�H��� ���El�1�	���U���wY^ ����v1#6��*����%��M����9�_�]C�}LI��Pv���/��ͽFsSO��U�����c�g��C�Ɩ�j�@����A,HL=�j�Rj`��$i;�(I����i�����	do�ƳH�KP�s%E�3���V��s:�,�  �^;��L�(o��fp;���?�����z�T?'��Pb ��3�a3L�+a߷�d�������f��ì @��̕a���$h�*M�6Wݤ�
�6�{F��(&.X�.���xf��)8MLX�Ŀ&��B"�0m��'��i�`�KX��M��9��{!�&�o�ZV3rL�����{��P��5�^qYR����L��r�^�^���`�rBY0�{\0���:������\�G'���1S+���ƒ��.ؒ�n���ʣ�iL����.	Z�A'yn��8���u�tr0L�Hj� ���l�c�9���Aa�p_�k����C+�?�p�J<B�>	a�!��KHڐ�jQ�`��E�_Ò��v(�FC�`���_��Uv`n�qi�ZN��$D]�,L��B�<�و|nC�yѴ��+ؿ?�yE�As�s���ʳ��$2U���vi��Zbx9À��9z�邚�{!�>d�)d�3G�~�x�m���iy*2�aY�Ғ�ƒg��hW����>��4)��
�!(fU��H�����8� ����J��T�'���%�RR;����GD�g��]��F�4�G��s�`����xs���B�֗2�3�7�L=RO�@����l�Z�>�����G]�g'F��f6Xh0Ƒ��/�B
ƛv!K#cG����=�{_�>M�vP�GZ@I^]J��n�&����p&���tai˰v��F\�1��=�"	���Ov�t�\Y��z0��u��D2�e��T��8���<�ZD��j%����Z��@�j��~Z3v+*>��Kg��UF;T��ax�\��Et�T�W�i�f�����V&=i qD(Re���(��%�98�c �o�m��d�G�o؈�������5��_�i$ ǯ!�BL*;�$%-�h@����Еqu�X&3�k�n���\"I�h����A���<��4���.)gΏ]VC��� T5���A#��{1T& ��r���p&!	%�_еP����Ԑ�A�?Ŝ|�g�ڻ6+�0.L���^itӖD��a ���m�N��XQ��F�� >ӆn2��k6I불t%ѡ�?RP*5դ�JS�q��/�>��\�\:6'p����[�<>?�q�DR���b�]6��>Q���p_$���I[�ِhj��͌�������a�Gxe;ÀM`�˾=Y;����r�	ٔ
�U�B��+��ż��4�K7[M^�i�W�C�(=�wpr���}���a�f�V�;�>B�u:n:�.s�����D�D�ۙ`b�h�;Oh%��{�('��X�_/mrc��}�l.��vl����+����Z��(���晳��BgB��4�@���ւ�ǘQ4��J�!���f/$C���d�HD%(���Խ���d��$���߱�}��A�'J��s��9dޏ�h2Q�aՄsF�MR���q�ݴo%�2�tVe�+u�Nf�Di �F�կ�3	�M^�����aG�א#S#���^Fj��m5h�L3��&�ȏ~'�(�yPMĹ0�4�D�1��bΦ�L��c_��ǣ0|���q�Q�����x�Sn��Ŵ�Ɖ�l���s���%��xD�v�҆I2	y<��Y��?�$�1�xN&ٍ��0gs@�FfR��B�<�,�f�8MNL�Ux����<��}�� �d�07�;��������9nɌ-yn�B�,y�)+�^soX��e�(��o7������|@����`�\B-����}|<ӥē ��P@:�
����M��燧L��f;W6g}cjL�a��9�c����=6o���Dc��k߾h����KDճ�10��>di]5 �Wm'l�<�h�mW�	�d2�ü�A����sܒ��*��.$�h,�En�/T$H_R��%�p���pTlPd�J��M[�Rf~��#�+F<��+0%�����Z@"_*��4�c�C3r�����o�L�=��>	�(�*���V�Mx5�Z��Zc�M4��1��e���s]n�
6W�Tx�p�0�DD�Ӭ3@9�Hs\����S�?LK0 �ߛ_�������*�� �#*��w.���A���4!d��<?��8j����PU6��Z���*����ܢQ��~�9��G�+1jp����-��,�;�C���2@�۽�5�|h\4��Wu+#��r��"&EAS�0���vH9�{6��W�P���o�g���L��o�1���� ��yڶG��nw��/]���1 �l��&��?͢��U���@�}e�G�G9�����D- x����E�݅Ws����i���s��vJc�D��g~�̂]�D������b;6/��������L���*�ɅS�լ��l�]�$�	���#��7 ��e2ǯK&�WC�d �'��p�b�1��fD�5��0�9��o���a�8��w'�M���[�X�Ŝ%!*-�Ł73��gTN��cNFMdsWNd��;���0�[��n�ˋy1�Ԕ��8w/��p���_)����#9'3わ�ǌa1�sR!U��L}�̰W��K#�}�3%=`<?C:1�^A�<|�,t�n� �����l��t�+�p�`�9��&xd%sA%�C~�;ס�˲��7	_;L�7.��#g�W�u�8�c#���"U��p�����=$FӒgu��_L^��������ǔL	���t��q��s�s�".��d\�k�2�*8�a��L����P0���<�My�Mf;���w�z���b��84f���3e��iǨx�=�m��ȵԝ���c-���S7��B�eũ"c�&�/Ix�7g��:�c �B��;�놫��,���9��SK�}9׌�$���ɠ�I�R� y�F�֩S#�$�bv���ۃ4���ga�    -�,B�	��(�8k��hGxr.�06�L����A5����g��"w2�}과0c�c2~���i����vӝ��y�@����(��; {�Q�qE�JƇ�м9����(�W6�I�]#��"ǂu48*4���NC�Y#S�FOT�0�W2�R���PjM�Z�t���������),ro!���z3��/JA$з�_���I�H*�P#3¹ߒ���qP����[��Q�PU�yXtx�9�8�������]aL<���kr�/���!C`Y~���=����.�Yp`�c}h��s��:i|/�U�K>�i��c�+�"=ܖs�6�c�ѳ#K ��,��s�/E��^?�ڕ�|K�}�|$�JmV_�lJNR����@�d����œJW2r���i_�gpj��������}�kB8�������#�4�c �S}{&E2�L�msJZ#�"G�6F���	�
�2�]��y����̰�X |ij�����b�aZ@�wa���sP��K7�p�\~s#�?_���c���I��� �c ŗ����aK^8t�K�T's�We�[�
Y��#�;Ik� �K�� ���P��Q�[��usBYs�������V��|i�2i;�K�d��-��nۆ!�&& $ً��q���9u)�� �/�e�����A]�
�����m�>I�>8���{?�Z����%���HR�Po�H�w�%aI���ɾ��i�IB�{�vz��\����Q ��m�B�1��y�'C�,����%���0Q�d��e��c���@ ٪��©"�Y/.��HZF��s�_U����bP?������l���s�-�k�)�.���2���3y���Gͬ2�����$���j����:��h5{�8�Q�`�zf��R؀�8���n�kg��pX�(\TC^��>S�5Q�\B��-����{����.\TzDz�0�л8y-�Y�b�p$�\٢��_׌���fۯ���3�z�%˾c���)-�4B%'ɺ<�p`Y�x{�b�=�ȟ���ȩ�6@٤�p��j�0�3�%���$K��>Иۈ�G!JV�x�`.G�=��7�_=\�he>^�|PLXJa�\�%�M.��y�������9&�$���*���t.�,�r��V:Ff�2_���0��;h�s��yPY����_��D���H��ԛ����l/������V�%C1���1���m�~+w�(%��'z�-��Uk��$�T���A�v,I�C��r]�+��	��0{6l)��0'��&?�x@�@㜊3��|Q6c���=�^a�QF)������0�_>nә�2T��yy�����r2m��E�/�@ڣ�i��0sڲ��r��ĩ���YgV�e���(L��`c����|��L@�ŧY��T�j�h.�@)�� ��y�=�y��b�������u��
��NC��e%���I�䎋ee����T�uû=B�A� �H��I�����Li�Nf��o�������yl�?`�k)>��-C��+���\)튷Ti`Z&�9bL��ciM�LI.�:�o��������Fui��.6:�S|�A,%��.9RL�o5��Joz�12�I�T��̘�?�\����e�=��$ŗ�趩��e;��g������y�_r/��5�~��F#������D+���
�w�t�h�B	�}���E]�o�d�W2'^�kv�K����Xe@'~���X'�e1�2���n_���2 ?N�n�"G�\h4��ȴ.����Kz1E��5	�6V��/�a7�ui�@�CV���;��D��sHˏ0�.S�Nۆ�5�b��h9�[��B�x�����̂
+�T',()������M�2����J��U~���{y�cΫ"��1F��-�fΑ;���iI����+�f���H�x�en����� �ِ�t ����e�\��839�{P?�|,͉����P>}q��k���,2�w��7ޔ+	w��&��&K�2s �«ZN↻p��9�떔ڠs�i�&wp�x�pN���it:85>�no��^'zקe��q��yK�T�ǱQ��^�=�]#�`w�/z�<���h�C6��i!�!W�,������s)�(۱��Ɉ$�91�{]�ti,~�r��r/��P��y}����-XM^J���b��lX<�8�`\���	�"�>&6T&L9@��M�b��ia��L��@�[���O&৓�ŕ�ʕ��������uL��b�G7N<
���c��p�w}?��A���0ُ�/�4(0�]-a����U���h�C'-N
 �M�e��l1+�~;2^��r��1�#@1�N��5���N��+s����v60�b�!`��s��li��χ]b�̫-��#�q9���
l觓>O���#b��Ezp]4T&��Ӳ㡝�<�bw�J3a͎�B�[8( ꯇ01��ɞ���*F�B�FXf/&S�dbb�[���It�t���M��w�JKA�؛�O 4�k�<tY�`�,n���T�%�ؔ@�M�(3�A�H�}���qIG��T���IX=L=<����G;;b&@.A���ݧ�I���q�F�D�ب�&�K���y���>��i�(K:��2�Py9��{�B�������9�c�HJ�$�jh��k�"�+δj�q�a�q�xǅd5����p_/(a9����َ�v���d��&�|�`�
^�񡻻��I��q@�Sm�(��sp���{/�93X�B���:��wi�t��l����trI�O.�r&���g\}dq9W�Sv�y��BU���(�%�gg8*�1�a�4��AiBt����!�_��pKW�
+A��d�xA>��B�O8�|� ޟ���#b���0x����ɑ��Z��[�6*g�R��5�s:�Z��;a���<r�5Q�t�$WS;xkv�|�~ݜ�x�XH&8A�r������7ji
�=g��kg�L���W�K�n4��IɨѤ��;M(���N<��i�آx��Vr�U ��ܔ�磐8�=v���'����i�%7�O��P���M�������tU��7|82�'%W��G�-�T0�5�\J�󭷓�/�����I����2D�v���I���!�g�y*(�\�=��˅T�9�;��_��ʹ��#>y&�/8F��j�W.Q���r<���U��0�8��z
Qp�{�?�b��RX�����6̃������o�`8/���hi,�\�5�H�!ږ�w�3l�����7�H��u*���(����d?�~mc�����¨�ٸ5�`��J�̵����?�0p�f/�S{3m���d2��%�ס_������	1����� E����ʆ��-I$�����8�:����ɮ�a�/�AAx�խ��{�'�yi �Z�&���L�~��E�&a�%RxQ�'�?��w!Vy����4���C��K�� �8�'��s�]�Dń(7d�f�"ߦ%]�l�HS�������T���c?��Ʉ���J�]=��]ҷ(���}���A����Yz0=��Oޡ�����z���{����.�':�O�W�H�3g�\��D997$<���`5
��Tэ��ɝZ��]î]N����a�z��j��TnnM����a��l��Q������ƮmN=�7>G�$��!ȱݮ�J2�bH��u���'�k9L��r�쏗�z�a�Vtyqp����L'�!�l�h�e1^�C��o����)� ^|[pZq�o8�q����u��	��?��!�bVN³��۳��	=�i����,i��-_Z�= 9�A���x�$I){v�s�56�	�a���A�#���� ��0Q[D�y`��,�x^�,��h=�(��(�?r�G4�k���9�/Zvm�!G6'#C1���e+y�^���3Jp�����^�p�1�;1+�5��A^��f˞T�(�N�ۍ�{�e��wZ����_Ό�*3u���Jp� 9  �t˰i6;'+�Ql���q�t�dɠ*>/��'��M��k���a�y�\����$�߳̕��n�Z�vH͹�QJ�;�����c�#��62����B�f��n�.�W/d�=�����y��f��51�B� ﴍ��k�bj԰�(U�ץ]�4�b���d̓���_�x?���%���b阅��+ʼ�d�G�%�"=�#���|�>���}`^3��w�QX�6@���립�D��E���䞳욖����v&T,�S
��ܿ�'��]�]xj��hzre���[�<rϭ�̒QO���w�u�i��Xp�y��\������ˉ.�f�g6o����ƽ��J��Ms�,��'��p/,~y�f�9`*s&m�Ҕ�������tɶFD�ۥ�Ni�Ǟ�d@jD �����i�sb=�� |(@~�/j���e�,Ύ{f ���H:�� �H��4:�*m2��p����W��w���ֈ��G��\g8�^�Y���0~1�-��bH����P�����3���fO[G�ָ�.e[�!��U'ff�;�R�B3�k�Y���I�#���YI{ }�yZ��nSU��
�o�bGm�ú���B��g^�	+�8Eȅ)j��-[����`����rh��l��	��>GE�0A�[���q$% o�k��h
�q�����J�Pj_�mx��.��Բ�3������(�E��n
��xE���vjԌl��f�X����[���C� Ҿ�	�[ηR�3c�d������A��v�4��YT�J錄QnP��6�|?DFn�k;�_�g.z+�&�B:ɇ�xz�.:vXmx������C���vƶ̊+��M�R��8e��d�P�ZNǃk��8��G��l��BZ&/��2�ߏ-��-W�	�����֯�3�r�S�^Nm�]�5�Q/�{D���Sfc����m8iq-f'҃��'���v����6_��x�tc~�a7�OU����s��^:x茄�9|���sl�qYI+·��<�N��\���9���W����)��S�?��������~	�q      $   i   x�=���0ѳ�K��M\jq�u$�# .�Ț(F�V|��Pw�q��%y�Qc�� �b�H���'����-�^��n������s��Ն�����=!            x�m}K��F���+q�i� P��R[:�d�J+��ݠ��&��D�T���O>�
�,f�a�I�*_f~�ٛ_���f76���i2�O��ӷ��5��7��q>4�盭l����x�~�����e>w���y��ew�ڼ�.��i7��a3n7�ƛ��t2.C�|�O���n��6/���_8�i����^��v��|���i������/Ӳ�7�o~��__ѿx��ŏ�`��Ϗ��n{ڼ����E0�����O���e<�6��y5-����6������q�qZn��>2.�O��d���&����|�N���a��|:�����|:��n̰y=.�?������̫�v��<�&�n�|��;nNp�/�Nz���W��7�Y�����~���Mf������Ͳ�?l͗�r����WxE���������y_�a����/���Z�3��Ǜ���\Ǵ<����]�����nj<�W�y3���<;������i�ޛO<�s��<�&��p����{��i|>�K�e�i:z��������B~�/��Oy{���9?���~Ǐ�z��?M����<��+>b2p\�<�NK�j?��������4��W��f?��[���L���v6���rA}g>��nǇ��e>?����vw���ߧ���7����M�a�>��v~�N��W���_m���=%>�?��e��͗'x�?wp����`>����X��&��#�`>�ޙ������_A?��|�=����o~E�0�mAP��v>L"�}0���y5���Do=��~??���Ѽ���ͧ	nk{\in�������.�O�=�y�*Ai��P�e��_�t�f{��#����'���� B8��̽��y������i�g{�i8d�i9� ��dBؼ�����Z���f��h@����p=-wxz`������i:���y7ݡ64�>�Z�������:�aڂʉ��ͯ�n���o�(� K�����t�7��~�ӷ��?�s�Ew 9�T|�3�Q�_?�E��|��[4��e���$�d��_���	���V.bh� �� �G2Q�w�#��i��O�	��,�y �C��7����� w0��Û�n~\m���͎��G?x�����;xyk��`���N;<k>|qZ��Ͷ��0�_�lT��	O�r��p��Π���H�=\	؝�+���G�/K֛�w�p���ͽ�Zh)��/�V��9�4`j���a��fpn���I����;���Id9v`\��L=�k��'�Ѱ�}|���;H�@g�,���N�?�>E������<�~$��N�y�z:�1�pրRܣ'�<��Wf��}�7J$���\)H���%���5�6�~�F0ub5�3�������>����P��7 O�=�Zn�8��G����O���x:�,�6�~��4��� �C�D��jCw,��|�ق�F0H��w�rW.��]�-�����p�hz 5�naZ~�wC���T���w����������wr�7z� O�Iސ����[�vZ�`N�hA�6��w�;�e~8ހ��`��;��`2�8�R��w`��w����gP:i���ߢYk^��cM�����U���)Wx�������t��ᕏ�ml��}�V��ԟf�_���y���B�ۂQ�8����毑�7�g0��W�N?�[?��@�6vz��⵶�Џ7o@PA�Ĭ,��hAL��?������=۵е��/�u3�УƵ����@dnMD��,��r����͛�����,%�������7�/��x���9�mr�İ�μ�6-�il>�����x����'���r�hp1�!��6�=��L ����}��G�}wh�.��	X�C���>��-$���Ä��8�`M�v�N���3�(Gl����+�;���נ	�n��;x�����t/�4v��0��?��a���^��(�{�jD�uݩ���?���?�F>Z�$����L����ue�\�����a�2	fy��@(z�A	yt���H�O�{��&E��8�e���O�vivP�=��r��CK�y�;�����8��_�����<!\n�F��7��)�et�r�O�� ,���m������X��%�ŀ����.�6#�$7:�1�s]ܼa���e�YHR� �F~"�|7�>)��3 �YB¨d|xh � j�0����~^�ƆG `���F�k�o6�+�|�p�fbې �>����D�Ab9�S��6o·�9*^r�8����K^Ç��-j�h�T�n��.�������hڮMq���7�-����(,X���`&h@�ʙ&�Q�|r{Eq�A����A	<%�,a]ۂOY�;@�˴Sd;*����I3_�k�8vC�NtN`�_/����ʑ�������n|P��p�.��CJq<Q�@qbk!�� ��W�kM���0(���u� ��t��p#V´p1p���&���u�pd���D�p�p,�Q?������-�>�7��[|<0�f���|�-Qk�b|@�,&��p����xs��]���9F1)�9Ɨ@�M����% H9е����z� P��ژm�p�u�#���`_�P��)���7��O�`���O�'��՝5A��|����!(�:�g�	�mF]l?*K"x;@����3��:G������:܈�t���4�>������Ż���Dy�hޝoUJz�@S���5@��Z�����ѯ��7��Id�O�?B�*�R�ߡL�����QsE./��W ;��y�
䗺4����Ib���.x1���'V�ޖ8�Np�&H�KRۃJ!.;5�M���X�zg���"�b�-W�0������k8��#x�����絆��"YNj��/w�6o�$*
wgس�'��������|(��!��pD ��yE�?J��, z'<փ��/xj�x�͇yϐ��b�9�+T[����} ����Cl	��n{��g�X���,��1;{07����p͸��w�w�OO�1�@W
!7ݝȷ��|Z�y�?߾��S��Yg@��]p�̭�������@1q�K�� rp3��~��.���r���H��F@�?����\��(s����(��&��ͨ��jC��
<����	*=94�h��gi�n�0��C�A!��w��Og�.f�A�|�Nm�5i���M���Л����g�|�Q�Xg{��{��6�DԆ��ϧ��0�0 �X��h���RRL���� �]0�a�9/`�!�x�C}f�� #�?Q4o�Ӹ2l���� Ϛ�M�Q^#���Ǜ��k����L�f+����vG��S���� ��#L#⦟� �H�y�{��s�� n	���\�����G�?5.��^劒��g8����P��F/�o��%>���i*��^Ck� �*�SK���)�rqo�~������%L����f��f�o��6e�عHY"I��X�7; �X�MF�>W���[�F⟀��I���F�s�#�I�j����5��E��/y�3�V��������>w������b,4k�D��<\ê��D�,� X`h!��u&����LΣ6�A�ᜌgw��AЫ$�3/��Nx3�\����,����D�IJ K�s����� A��3\&a�d�A��'*̹X�rGa]�`�ɂIgق�9L���C�q��
 Vpy�_��"E�*V�B�����dJ��B��6�O{T��w�7�tI�vYۃ5�:� t9CmOO�����ARx�� ����
NE:��J֎.m�GPPJ�]�Gqj�U N%G�..` �Lb2�d����W�=��x�-u�F��
�vp3�	���|H&g���?mRb��?�_�`�b�0�x��jn�3�ғ���U�+�%!~�|2U+;�7�b�J&kh=f:翯�K��Sr˵��A�߀�;��U    �`�A8q;� Iܗ_�Bف4�=�7˽�)��W�	B��v�b��"��Ϭ�;vՒ w�qZf[�y��:{�vS��@Kt-2~��0Ð\����T<�`��V��Z����0�N�����7�B�A�(��kBw�څ �"��S_��eT	&@Z�K�+M6��L�Y� 0D��̐d�*$������*W���X
��$g�ؖ�`�z0���a��J��!E���lR�-�J��"� :r��Zp���RE�S�d7i��+�v�9q�&)%��[DZ/�� �oG#�L� ��҅�mk����M ��V� ��OxP�+zm�r�Ӊ�& `KѴ��謜W�&�'�6��9?�� 9�����,};�ң�ڥ��?�����3+�W��[A�]G�}닥��Za/6�j=�|P���U0�V��z��	VJx'�������\c:6�_Q��$ܦ:7�Э0x�ܣ%�l�&�$���B@���4�v����M��}�aK��^���u	H(d"�������$��o7�5?e��#s�K�\EzxX���?��O���[�y����(�GF ��ͼ��\S���aW���I�0/��q��S>�������*-��*#^z��fr	x��E߁�C�����\�����ۏ`R�&�y�ޚ/[�|t�u����>�=��]��7�x� W	����������*@p��2��z�5ŧ��}�K��w3f�C?d�J�mBK)��0S������b|�.^l9��K��Ƚ��EYL�aɃL�T�)�b,�C{@@>�Ϫ=\�c���!2����B,��TR�3\�e3WDʶلX�8{d�*~����*���F9�$�	��L1U�(M�W���8�~�#�M����>#~����"v`���Iq�Mp�!J�!��AB�r�����e�z׏I���`�k$Q.��D�d��z>܌�k�]5A�� �)L��5_O��]1�pw���6�夵XD�{A����~hU�
�h-�"{E��(sV����O��C/5e�H=Q1C��� ����7d]�-�΁s�-p��o�����B�I���PЍ*����[�(�%�\� Q���܁�U�b��Ĺv�nh�^`~���������h^�,�J�Kw�� G)*����;&�^!y��(�3��{��g�Y5���p���@N�H������>��;��U�4�3��aW��ܬ�f��yr��Ӫ�����*/"���Q������*� �H4��tl���� �����Vy�޹�O�d@�_�O��ʯ㋻�Ν��Xln��#>�$L+ u�J3�]ﮯ� 	)qX��2����)�@��4}�Tjzl�z�u�[Q�[��[%S�b��q,��j,Q%l0_�������{*��7�c�1��
��I)g��GO9?LD�DC��'�E8K�?���F'�w�<�°�?q5�y
�B�{u�b�=�=�����R����]$,>3��x	�!S���	+6v�0�B�'��� -R,��
n�������ԍ����sET�C��y��7�$ |;���H4�h�%��Tag-V�0��C�H�/;�A�<�`�s�mD��},F(�/�>7=��I@���n��u�PZo�$B`�P����3 �Ϙ�y�������*9>��BQtV��ʯ�ݼ$D+�[�������&z��R�Z���K��6^���5
p���g ��)N5��JR�W��K4���L���d�>:2`=�'����;+���'�B��U�.0��埏ۊ]���5��1����G�V�����N�ݧ¥�# ��_a ���|X��&y;C� ��Z#%�+�`����s��*�B� �0�������X�i�8�)����?n CX�x̪�b��{"�5Q�����v�yZ�#���pL�'���gdH��'W�& aUO #'-1�w�-%��'oXQ�iׂ5���#��)�+$�S*Hf ��.�	2K�fӄY��̆\������A@aJ��G��]�c�PB=m[�6�Ä��	��i�N�j�>���w3R�%�L?nJ41
U4s��� ��z<?�����-R+�����˒�z��K�m;8��R�Ӽ&�k��_�-��|����0��I^l/�a�`�����}uB�e�i[�n7B���tF�,rb�d�]y�AZN��ZL#`ʏ�(8����|�Vޫ���B�,.a+�/�%�	X{<Pf�N9��&�B@U�;����|�`V�~��î~L-vW(&��w����_S�t�%7�H���C����|���������.�|J�;�wu�O��C[��H�#X�YUL��C�.�_0�	������/L1r5��J4eh��f|"�_�R����%eJ���}f�(�P��H��U�J��[SP.�fj���\��矒�������SÜ��!���t�ni���ue`߉A�	~a��  �4���L���ҋ����*Ԍ��F�}�ξ�;�Q��'�@�I !����*Z�aR�fB�܅�*��_�v�ۃo�1�,��L�>��)0����7Xk����`#�� ח��o-����逕�|���4\*�̺IRb,ӪT�/��F9`�� ���.!k��D�cm��t���/�L:/^Je�B�#�8qd}�6/ϧ���bhKO��*5{��5:E��3|[ɘ�mzN��[�nՖĶ{�\Vo�.����F>v��)N��n�5߰������`Ҏ�xnt��m���ѓ������զ�V�zu��[e�����ѵ�y>˹��{�6���O'fA+�c�L6��U�pݱh�Q��y6����2�Z��P�~b+}�v��:8�'���(?G��*6H]VŃ���Ow��!�QF��U�X��9A��R��a��K�KxSjNt1Bb-j���X_��+� ����������V��˨�a�ؐP��Y�Š&����qt �\N��X�9TA�/8u����a������P2Jሠ�~�FJ��6C�rTy�^&�Hѹ��]�}�?h?T�E�NH�y�h���
��0��#`���n���YJ!�/MG��e8��g����/H����^�3=�b�Kd�(z�E��"�@��j ��n���ϊ�_X���^�kA�)������eۚt[~7��g�<������1l�d�D$�ؑ��ۃ�`�j)d��`h&0_Tw=�@���UL�S��D=t�d�eܼ���e��&�UB��w��k�cK,�Jv�
���X�kk���X�P�C�D!��&�ec�\�U@:�5�
���uw�-�����ȼa������s�Y?>bӣCC��X����C,��}d���R�Lm8�Kr�8��7�p�`$��a�����X@�k��B��	<��f�\@���B&&���9~��R��{�g!���k���K���ZB�����F��$\n*%����i��]6�-& �b&��ˤ1!ec���B�*���O~�~0��-����������w�A�V�_Y<�+e-��N�H�KJ�>�����!� @�u<ޏ�参��D�!�'�XHֱ���;�<C��{�-t��\���1`Y0Z s���Ð4�n|��@��[��)fV]@�I���^S#�R�ҷ,�����
�jW8��ԀB���7b��#D��nܗosj�8 s���<x�#[�p/-<j=�v����W�&[5���0.�!�F�sik�X�����`S.e�-��R_'D�/�OPnR��O�I�7���l�H���ͯ�K���8�٧ݷ��_�cP�O~�R��k�5}Cg�`����ң��R}̡�ڢ�|�yQ-%�J��p���)g�.�|�x��<���q!��-�� U����D�]UL��܁!�~��"�.f%l���Ƌܙ42wIjՒ9d�.����\��ƣ6	�Q� ���-��F�CߕT6�[���kwsB1��{�'A�p     &��=B��q�ݞ���j�eh�t=C����O��D��J��O�r^T?�?^O+:ŀ�?������s~�P!Unbo[8��+��<rCS�8S�����|&q���I�
��ۼ����k���>�ט��-�J��UK�zo��`*^ ްC����Z�<�����3�n~�u;��B0�B";����J��x�lY�)�`z?� H
"��`+Va�A�`��^��۠t�<�a�#gA.�-�mVi�)S�Ӻ�.���������S���Wp�X��=
�+*'�ѧ��1ҕ�`�x��ʇ8Ե��n�f����:S�Yn���U���͏� �R��ݝ�L�Ƚ����݂����Dlb���*I��'L��|�p'�[D��?�Z�F�,��Gp��F��+G�@��Ө�!��j��[G� ��O�׉-f�aQ�Ӓ�'%Π�p��v��hJ�zOQ���d4���B��B��8?8���ػ�=��b/`TD	{�딙d�R����~�p��lԕv�kZ��m= �G|��6�n���hrw�j޸�&�3�:`s�'��+yu�Y�J��mNf�[r�@�a{��S�&���6�)U*��/3}	��o:,�]m�l<�$z[����BGV�|:�
�o>?"ٚr�-�4�Q���Q�PU�����XPe�o�'>���s�%>x�0��C.)w���6��Ŋ����L�{U}��8k�s�z��S�Hڊ-�Z�2%�x$1�:c"����)DG�s��P��s�v�r�JN�+��Z�r�"B�ӏ�+�Q�_��Mf����}g��\G�E��-7��D�:Iy|�[R���}���w������&�ֻ�#4%�c���-�~�h($���y�&���U��XVe_����-�����3T�nt�����'�e��D��3�dd�di��:k��B&z$8��v�JWb�C�<U&�I�P
�����	��H�*79Dox�K�Jz�j�
���W~��ӉL��B;{N�e�`���9d5r����4n:& t�G�_jʛ����S�ΐ:�c<�Ԛ_�f�Jb�C�ǽ��P��p�տ���M��#b����y�3TY�`!^x3c�(+Ur9Y�i�>��� �O�31a�J���0RV�u�G,D
���rv�Ȝ�aH1O���w.���*d�;"o�yѐ�JUC�� �-ec�D@�iEm�	�2M�Û<b�#���+.�E+z,+�����F���Ge�P�^i��]�s&��0~k/��2�4U����A&�V5Ƶ��v출ř���k�~������D]�����1�huxCS��:`���(<7����S��";
?�⨐W����5�]]�äê�"e�X`|{#��u'**������w��q��,�|�;i�c��p���PK�XA���D�m8�݂�� ,U�O��r/����Wa��Iu��FT�4�;ߖ�y �GV�W1���J8LR�EC3����k���d���T�2$��g�d��8L'p��X�ʫ�"S5�_��H���|�-��7�:���7��m�ͩ"L�I Yas�>ĸ�B�F6��ǌ�t.W�tR��x�'M��8���Ĺ��(�����4ѐ�x�s;s�@[�u�&��4#�q���wLm�G|XQp��(hE���M�o�{{�߁z��|l���؎q�#���J�l���xF��罔i�)Z+���Ժ�%vC����X./h �����~�]�u?��$��O���X/D��*����XO�r�<@� k���܊�7�-Tb���	S�N���tBQ�mjp�V�;L�b��3̀��y�a�;�6�D��A��	4�*���1��]m��H5�?�b�Cla�,O��s�6p酫�a5D��T.nɡ:x���[g%%vd�Y���@�\4��j=>N]-�&
Z���C9<���g��ۈ�r<��5�6�G�醤OA%�j&^͵Z�m�Y���up��̯��}#�KF�<�BW�՛w��"�X��Q엳R/S�ί�3
g�9��I�8��R�}���M;g�>�\�[�rj.��F2��2e��xq�I��ST�Y�9?f��Z�9�Sֆ�*"��)Sj/|��ҍ����`����T���1�&��o�^o�F��9��K�b��P*�H*��\^H�aZ�!ԉT�Kn�h�>~�����ʤ] �ŗq�0�G�o�>/cjtj�|O�h��Jk�����f[�թS�w �ֲ�o*[�SM��P���v*�/[��������������]�S�%%���mQ��cAJ������iD�[5ί{'].z1V��*��q��U2�V�3j2HW�Y��W���>�:����rX�OUR?�f����!�P��_��Vi  R�ޣ9*��4���a�8ͧ���z���D�z�LOl���Į�׵��2��l+�
�K�QCnh[���X��U�K,G!�)��8�H�Ȃ �u3/���C�.�]7;��槈��h۰�ȃ�,�̟H8�^1�Iq��Y�(��C^��q��k�u�fA6��,�1��X�A�-��h����V޽N�]�!��	��!A�F{���da�σg��h�r"��S�SJl�֔�*�i=���"P	tDc�9�����/]|r�]A8�����euJ2X����6����PO�^�Q%���!���D�hx ��ڶ�s0�O*��U ��E��z�!p �[f�	N7) 	��<Ѷ�2x�z��RKA��۞�5���O�3��MՑ�֮M�B�N8�����|;�	)�Gl��D_���P����k5��i�<m��-�s��p.u���W��S���v�'��1U��𡔼�����!��)�B���m���8-�Oѵ�/(�_�����-���B��~��I�jb&�e8����aV�[�_�����߁s�F3i��-�drus7�@'��GF4g@�tX�>��	Ƽ'�Fy�x�')��Zt�r���24j�qҞ��n��Qcno ���b���R��P:��cֶ�<l�R��bZ����"�w4C�W]Z�������H����!W����`m���pY�xn�av݀@�b�מ��������fv����jlHD�;%m�9z�_����y�;��>��wt�8.S(�F��Ι_�Wa�cv�T�(�è�L��mz^�
���8����d�����5J5X�bd�mK��A��z%�<�-A�8�=dl-�q�����<~��i��0$����w �ʘ"oq����FVa���
���m������e*x6�6�:�A�DD9��ǎ:���z��{�x�
`��5. 	u�A�Yè�ae�	X6����4D� �AN��ه��ҟ�c�x~a+��0h��ˣ�j��@�
')O�����у����ܭ�i��L��Q��旿qo�_͡��!�´@C��Ee��;�|��Q�o%���L;�HL�<Y���yh!�q��~�;UY�u� �V� �>��K�DWb%�^�`���5#��v 옽SI��ab�J.x��¹�t�2)C^gDD�k(��mҕ��:����I��%�E�U�ު�!��/E�]��$��b%�H �O�U�r��@��8v7 �\.N��쥡]�[x\ŀ��F�&�6����3%0вt]J�b���.,j�d�Q䌵�Zv}5�-�D_r?"`~�A(�l�[��ɝX�l@�Zm���`P�p +��4K]���s�|�����W��
�VM��2P�{0}N�?����,'�p4t	�1���ߊ�$���0���-�%r�B�<t�քRث�(����I�}(ޅe'@�0�<Ϋt�d�C���-4 ���(Ƈ|��U-�
k�2#(C�ૹ1;�2ܓ�ݲ����?�
B̸�u�j&什���_gaR��*ilK����u�upH�~�>�2P���|���2R�8�@;+�!ۭ�*��[��4_]�������n���2�9s��O�ُ�    �Z*A�-4Q�2=e���T/����0�Þ��1H�/s���Y�*1V�<�E�AD\�C�B�8�CD������S8*�L�i�pه/w�:m�� �/E�l�p�Au]W&��ő[�V�ӯ���i��!Cs�����<9]�&Ю�&L2��fAso�mF��q\��kK��K�(��5��i@;ڔV��|Z5��2�m���~�iF�D�.R�жdT���������*z��2�`z8���o�ZڞIˍN`���+-q�֮aa�V^�y>w��
<,N�+S���G�����L�6n�V�o ���E��8O���̪�̿��tl���m���Oռ�3�y��ߢ�,ڨk4�!m�*M/�d�	�)2M�?t��:J����,2��r�.��!�ܼ_Y�F���4L
�'�v8Zk1�d:[!�p��<ϯ�ZZ���H{%˰�g�Jӂ�έS5�k�X\5��!�J����Ą�pRi^�'ۃ���-&�L�i�iel�n8�R��܊C�V|��Q�|�G}�}e6C�&|��\.C�зe#���Vn��t��	q4�A36�=��óЅTe4d������F��-���L�A<��H����sՓ�l7�~�`�;�5�;b� ���H4_\�#��/�i#p�ow�Q��G�ы�Kj4Y{(2�O69�I�|aMF��`ͩ^e���4y�
)��m��I��jq���)��=�z���z�	�:(��?%�MN{1�\/�e�Կ���x_Q?z@(d9�Zb֠��k��i����5�bF�CV/�#�����S�v;���vb�$�=��+px�3�}v��Ȗ�Ң��� ���e��a.��ѣ�.�L���2������އ0����j6�,tH؞�#K���F*�U~ ��E�Ƨ�~nȉ%r��W3�:�.�r
4�~V*7��!&b��.8�3���'�7�O}5H����jʙb�)���<���~��%����T�g](����ˡmݐ��D>qN�P1����?��(Ip�c��x�%��W�F���2��qu����y�����tz�4�a5#0�Y�+�J�,ŕ�\,l�V�XU�iJ��]�,������Wa��j�<`Z����n?�R�$x����(upƽ93Q�7��1���85�NW&"͌�7�� ��D�ԦZN����^�sT{��Nˌ�-����4y�Ϊ�4`���N������o6��)�X�|�eQ\��Y}1���X�\�'���ju�r���P�T@��45�{M�{|�
d�&�]~"�Q������-��J�M�j璧�Վn)e3 ��N9)j,Co�m�Jqa]�}�G�@�_��!�j�� ��&]!c�[->���//�x��u� _"MD�`��X�R���e\���O6�d^O�tB�-���]���R??ߌ���'��ʏ$l�ix%��G�k~���+@r����{�pM����α��������r�n@V�p�s&;�^홯~X\_p��	[3�[��!��v,�N����Pc*9?�u`��E-'�w�z�f� ���_�ކg��#Wʘ��lJ�㠣�B��U�J]����8{���jr�ȋ��{�IŶ��2A�D!��^R�E;Y{RM��  6��eJe��Ũe]��l��NC�_r�)�\r�"ɩ�V=�(���0�����A
A:����n~B���
�@�p�fj ����.og�p#%��[y�d2	�]l�
nJ�e~ri�q�B��Ix�h���e��zXi*��m���U#�����rg=gl�d�H�Pyg���0���Nj���c�{r�U1-!�8��$6Nĩ	����f3�>OHhXu4�Ǳ���cR�I���1���AZ�0t�z���{�����Ne�{W~0\��3m�p�?�uG�qG"��=���z
��w�z	��6[�\��5bg5���[��܈s���Ґ."+��RۮP�y{��ɖ���	�$�:���5'vA8���!4�� ;utmo�{%�ԅљ�]��F;�]�����F��d�j�YE)m^�Ë~��Ȗ��F�&�ǾWN�zS�a�=δ��r��,е�|僿���(�mx��/���շw2;Tv�۸Z����Պt�d�(����<q�A�3�[��@!��U��ג���(�ATS�BW�	Hc����.��d�rW(�Ģ����'Q�!	�]��ml�=D�ڪ=��ά(l�l�ǩ�>�nm���H����8����Pg#�bY/�h:R�\��gq-[�v �{Ŏ� �4�sc�C}���]5�C����]�n��L�$��)pu�Lf��L������
X �ռ�8��T#c@�kj������)��R�����9��b�2��k>���"K�)9��Wg^6Qoɉ�/�W��b��B/~��-�Q���]�g3͛V��p_��ʃ�'W|YQEܚ@��FX�0�P����*���jiK0NH\У��ߒE��B1Ӛ�5;]Փ�G�N%g�z��P�诜�P_���K�(c�i}z2!Q��\��DJ!���bX9�[m�M�A��j�}Pش1�c��^A�/#�.VS
0�H�]��#�:p���	Ө
7s�z��ZsLH����p ړE��w��@G��U�N�$c��\(�c�)�'IZ������#��6�ë�1�m����T�RVt0@���zø�1����5fbU�^�mYS)�QJd{H7��D���bet_ն_q���y�pD�s��1%@i����IJ5Y�q^���i^j>�q��s�M壝�L�LW�}�3�?�$ ���,�rm7vu�0�D�4�"�!I����aCĴ�ȼ��K^L��W[{�|�c@}��.cOj�˾�"2���6�0���Je��Ox31�Z#ؑ��+ZWs�pYpZ`���1�W�6�ןNj�w86��}P1�F6U_��ʜ��)aK�L�c��T�
X�u�U:���_�a���0b��U��ד�� `CX����pFڠ��Ag�>�AEW�����{�rU'��Bcw�A�8-�x��ᧈ�}�x;iKv��q��+7}�Z�8p8Vm1��p���y��A��ڈ#_-4�ͅkS'����,��f~ �p8���q���D��u9b�p��9�L�n��v������1�`]13E�Ұ�j8���\+϶�UO-� X�6��KTc�J"�#沱8��-�!M����U2�R��֛u�FD��n�)սuk_C����[H"R�ʴ�F��+�?L�=�RL�W�)Th�,3���:%�e���_�'��x����s'Yjm�ɥ]�h�J��zڄk2�K�]GF��Y�m�5��s�0_�c/r΂�-��Rњx*�wQ�yl"�B^;���U��)S��T����À��jhv���t����>�麂w��<	0>�-����s�<�{]Q�0&)�V�a�^����aoUa.r��l�M����e%L��ͬRKoZ��*'G���Ṉ^W�k�ҏ�2��*a{����y��E���ܻ!#4��NX�L$��B!�5��~�oe�X�r���L�;�E�+ő߮�e&���dή�q�S`La���i����<Y��P��X�1� ��:e����N'lU�$y柃��t�"���d�Е-��sr�6�u�U#5�\�w!X���CRFU)���U������E��K�-��Ui�����]��&�8���julo�]NH����RE�㗵Xh�~>���
��C�d�L�hh�p���N����i�BQ9���ˡ�z~���]T�B#'��dC���Fw�� ��m���Q2��[@�u�����@[w����M�7R`��b�����hI�Ն{�Y�;�KH��#���$��Eod�i��ty4�2�3����a�#�BO�t��(�0h���	UCA��c��� ��"^�f	)�-xq�q|��S��;X�<{���ˠ�1��I����%�	��00R��sHjWW�(䏣Cct���ɵJg�� =  ����"�:��G�	|-:o�s�	�������-�r�S�[&�ŸL'LZL�V���@)���ɹR[j�g�[ǿrL�k�Z�%���5Z��d��\Ȅ�6cay�3�)<3����<�:�B�Ri�%�I(�=�1ߚ_w�-q��ѣ,'f��§o
���"�wssDe+�<	�J�Xo�"j�>�?�y��zM�ȓ�2�oW<H�W۞�/+��Ik�g[{���j��ED,� ��`��UG�c�y�g�x{��V��)}��SNRC��%ؓ������f�8�,%� .~P�T�7�L^\VON���ʥEm��蝂5\-ktv�4HZ�S���_K��"@͈B'�Z���U� ���w[5���4G�u�(��8��R	YB`�J#\�pV���x�,R��x�y�-W6�B���U��Y��!�'�C��_��q>ĺ��( R{����#�$�~[���.��X����,N,���i��#���k�jN��î<��N�+\�����i<#�UA�^��e��O��R�w9I!*Ȭk.��ƨ�^���e��|&�r%�i�`/V?���L�KZayĩ��0Z�Rʉ!]S�*}��=,��K�L����~�pW
 Âm+�{=�!X�J���X�u�h�;�c�$Jɱ�3n�O����,V�βb����j4F���󮍔b�ok�æ<m/�˴��ǎ��qţ�^u-�T8��j��P�%!Ϗ�[�t�K�F
� �gz��|�pd����HL������������pcw;b��=R��3��7�#��żݢ��/���}�������D            x�u��vW���O�Q�X�i�E�r�N�`1���$D��(��-����>B�X}�� Y�kً�8�>{���M�4�e3/�1���js�}k7�ۿ��)+W̬����|�"3g.�۴���v�S��f�\6ˇ��$�f�~�t�'�k?����=����,�����am�TW3����3%����\�W�v~�l�k�fee��E�e��)p]�w�7���ъrVZs����v\�zV:s�|]��'��fq�h7]�e|ge0w������h�)+*���0Η��0�g��f��MU����|��լ��e�i�t�G�gU}��d��5o�nLYT��r��Y=�Ͽ����-	��*o�=<��05��s��5� ����<�b�U�\�v���y�+7�9+k��.��L�ì��y�X�,�yY���յ��~��y�}���� ��1k{�$�8��9o���N���ڛݹqE=�9ή�l�ḓg�h>�v��s��y&��_��lB�3[��������{�����r���j����ي�l7�T3[��v���l��`���Ӳݘ2�`y�[�P�D,��Y�;���U�s�}�[ot��F�2��;�-�'��^s�������+�j�^2���2��*�x���:t��(���Gd�
���Ϣ`�Ρ���f5�$�X��G��j�y�����r,Y�:U��+y�E3�3�*6�M��e�5_�E�Ҭ�~�U����VX_�����PtoGm�،w�;�"o�n����c��mw�V���`n�/{�Ҹ��||eޕg���s�b҉�T�0����D����ӁZP���4>6^&Q΂M��hS�#� �۴���e�o�#
?�X�`D4q�6��W�_8R¬�!��1�U��9t�=ۢX\\�3�"���꩝߬_�������t�|��bm~Y��,�->�[JH�=��ׯǲ��*�?���zD��ĺ��8ZM~>,'����I��R�o]�ڧ�!�b���t3�U5Kձ�D�K���VD��e���]��u�PS^�r�ɧĦ�7����^��z�a����>}wcƞ�F^o�&�:`�|����J�)�%^��V$\pQ�t��
�7-j\�o���w/��_/��jV��rᅓ�b�c����'�O.8߫A��<x�#\�0�NE7������� �#Kf�Aǝ� �`Y38r�5�f~}�CL�=<�׆^� ]�-;9��y�P.7m���@b��@�����I��A.Q)	�%�����4l��ou�>�+8s�_=n�" X�فHQ�گIhn�赗-r]k���}�Ϗ�G���2H����&�+o>�	�eh�`*[Hǝӈ�ܵ�?98-#o���!"W|dv#�O�>!i�i�y�`s�>ዝ��Y���W#$�E��y|��\�����N��A��a-�1�F>�,3� ��5�A���v��
��Й��ASJ�f�a'MpޯW��,
ܹ\��X��"�����ͦ�v-�J�����l۵	QWZ��<�&!�_�';����}���呣xE?"j{svg�N����A����a�m��z����>s�,|�{'��� N���7|ţpZ	�s�G��K�\n�ͣ�/�x&p��C:���A�Z`���>��������ٻ@����:2��o�сF��;jY��kL%K��# �����n6��wO+�ؑ,ǂ ��1W�/�o[,U6�� �n�20t#�6A���;�A'ð�ٛ���9C���`��͵�5u��R�tN����w+e� �s�zY���A����dy�Ɋ�=ȵ�i{p%������o�U=�_��C~1���$ih@� ���"�m�øP쇝V��t��ބb�S��~��e��"�W�����.ϸ�/�����y|�	.}��hG��?zsʎT���&Q��B������XZ��hY�-M�{�w2'"��T��4��'�R`T�M�c�cN^���j�ܭD��~��E�*p�Vp�~�C$�+�( ���J}��4����"���͓x#��{�	s`��\ޜ-� ����RDUyD1Q�
 ��:b�,r)q���`�Z�!h\�'���r4��n'	�4V@�@�'X�DY��U%������� 4м�it��DHd��
M*y����:y����s����#�r,�fU�#ﲧ�kM}���8�����=.wVI�����K��	k�$��N��C�,T��Iv/Mv+�4:�����s��2k�<M�c�Ñ8̠��U#֬��~Ꞿ��5��h�"����X�B�t�Z=I��;H�ǡ�]d`[�z�Q��k���c� �w��RB�X����IJ]����I���d4=o r5����]����zsԥ,K�p)�0MQu�+7���,�Zx�������W����D�����3�����v�l��%���SD�
�}������@�_�1�n 9>���ܠ��m��L�
$c�ާ�:v0����)�J���D�%z`J� K�d.�P�Ƕ?W���Fa�]�@Pډ�Az+�ꓼCau!f��1k�^MSH�W�{�#O�[��ktZ�� -���!�_����Fԉhxl$LRl��kxu���B&�^��Dn�_�A�/�us5�:2J}�@l��ҧ<������b<�]�H��Q��M0��j)�tT�Q�[�j�p$:��1]rI��gBrI^i\��a��')G9?�d�g�������܎�A� ��h�C;���pRL�Nf�*�B�a��һ]��QQ��[`u���ǵ�;%x J}��j`��z��k�*�������#N����}�	�+��Z�Q#'STPP�@�p��%� �T+=�T�_��/c�z���|z�(��$P�<����f=d��c� �违rI`���ʷ� �'H��\���C�t��|�	��S�Q�\:Wnq�(=g�`S�n̚+G���)��([�O2[
]j`震���&,l�#�� G�5�t��Fv��>�p�5���͐--�|}r3XV(�+Cz���~�K�s�1X��������r�!h7��>��FG���j\��*�䁢���*k[�f9�DǸ�Em�wXe�w��Hc��Trџ�ZN/�X�� �ywg��C���'���y}�ϊ�����t�z~�7��f�-�2��'�ҜTZO�L| ׬�9��rU�yIPN�د]��Cr- �J"��t�7���%Kp�lX꓈b൲v���P���
f �r4\J� Ә/52���PEJ
 ��'TiYL��)�5ETj�q~�!Hʺ�4W:j9��(��0������`���V����d})u]� C�3j�|�R�n�E'k �|��hR�}��S�猯�7�`$�z-�5JfE�`���|�iw9�yq]�$Fs��V%��b����҆5�t-\�� ��a7�z�*� f�c<(��K�iT�X�4�J,�TO�t0�X:N�zY<����@��ALp���MD@}���u�v�R1��I-X%ߓ�_��Ӵ�rdƵR�!Q<V?TF.K!��>���BJl��;h����.�ۜ����K�	��n�r֟�����2��{���-P���}�;�c>W�ptE�=s�EQ�/惡��,D:����jA������M�E�k���Ԓ_�=��*-�TC�ߖ�(����K�h�N�3$�2����i�8~ւL�Z�����L������2�����k�ɒ�:5�N����z�h5U�B5{���1�5*{��#)n�uyZ����
�^��*�Z��
����쯛�R{vY�������(��E��>������\D�m��)���a��o�?�ۖ0A����4A<�R5�Ю��XЋ����a����lK����R�ɩ���f`1*3LQi����y��#�p��U<��~j����	�%��T�?���&�|-.�:9x�k��^k�,04Ơ�|���[I �E��t\��	�-��D��Y����F{f}�����*҈6��8V9�� �  ��Χ���wZ넨q�C�s�����2�/���ϹY�n)�����ħi, i�W|�Pa���0������VFԜR�!��gx�niI�)�@'z�W]ڂF��_�u7d�¢юy]��$9�c��1 V�Hڻ�%.-�t���Vh4�#%R��&��� �1^du�UP	��x\UQ$n���F�+��xc��0�eNh��3�Q�͂L9#������Nj���}�J���J��%��j�:R���و~9�60m,�j��WU=w�f'F.a��6g�T�)s��J�;\����D� �&L~YuqW��j�X�S�i�M�P1�P���T��r.L4�1��� �t�����f+|<�󑰀-H�
O)��.��D֨~��rV��C����Q�0���x�m)��G���#�r�����P'�;`�O2���:�P'�(/��֛�̠V�Z�ކ"�����}�i\d�^��h'4KI��).�^�t7��]	�fr��w���1��(j�@�?T�Q~��+w�בW�����F�LQ��/b�Wc�%%��_����a���1'� G=���͜rxC��@(6Wi��F�?�	<��>7�8@���,�ԇC�F��փ#U��E��ꚳS�/�	7^��$�V7���s�PB�Q-�i����&�Βdv��-)S���*l>F�h�Q#�g�TM-�;�uX	7X�^}8D���ɝ��ZY@`��O���3�"K֧��G	Y�ȁ;Yj���;:�Lo��c�+�����b; �;�{���-%�]1.:gc�<ތ]+�H����T��qS�K�)l�i٬�CwT<*��
c����[q��r�Ł:�'��s��z�6q^��9]�le�����=�J�jO���&�\���l��Q�b�����7M*���T�R)�;�ܓؔKŘ�P�ƥ�Cj�r��/�K��;s��乽�8gd"�����H? ��ݽ�J�r(�����.�'��Z3x�7*���U{ݬ����ri2�}�8i��)��T�M5�|\�rl*n��\�PÃ-�g�}Uӫ84��u0�U��Ǫj=�r�=}��5}2׵��gE|?�wk��$�ϥz˲��y� G�R,�u���
�<�R��+�v窥K�1@?w�0���=B���վ����=�j~;Ts��q��ֹS���T�R	�:���M�d����hk�t$��;��L>[�K���_�z'@�p��Z#�S�W��멢����!�@�U��ټ\|� �]��-�C��^�G�;5Y��̅����W=�ʥ��R��TFU��7 f �TvT�����42�
���u�Z�a���>00bas���r���6�|*�N1z�
 �'��R�^А�M���M�;���i��p��-�P0j�� B�v�pALr�a�*��%��m8^����FO=�xh��|����Y^5�#��r�l��Ľ�	ʦk?����I��s�[.�(]���w���p�|2z��`���i�nXJn*�sAz��r?�E�a�8�)��B�!��^�����p�Sf)�Ƽ��gL|Hc��[f���=Eʘ��b�jkp��7��q/gj<8�n��۴}+��{-����|� �q&�iij.�
G[�z�ŷ�h)�MֺT�I�(�'�ɐ��+�p�).�`�~X]�^6�m���}�
�T.F��L�g� Ř��u!�@��K�
�x�r�%�Q)�%�ӏ�B��ev
I?��:2U�!�5�� �$C�J���:B��i�F^I7�H���hQ��B˸S���dC�,8����ON���U�;���bCiG*�4`(s���B���?�)�b�zٚ/96�z:h.���4�!pd������(���cg�&W��hکD$*��k��Q������$A��Q��e�����5�1��|^H��Y=yQ� ��'(�B���W�: #}O�P�I��	�Ю �L��J-���x�� �ܻ�@��2��㛎hq1b�W}N��,�-7�P%NX�%�Y������k�p9j}��l=��L ���Pu���s{ /=��z;�d�٠����Rݼ�aک�*�@�X_�ʠ6�[�3���ַ��2/7%��Q��m�i*".]�a2	0�����/a-�v@��H� �\~��
��ONQ���˾��V���ӕ�X)_��d'lQx��(��^Cr�-��I;G��P���iz�e1�@2�B͕z!r0�1&�t4@�qR�Ν�U�@�5&(�k��A��lO��4;H|p����9*8��Bu��UR�'�^
��׫Jv)�Q �@b��q�A��!֯Z�{KoM��D"q&�R�����6�a!����x�P�Zvȥ���4N*�"�I�ڠPddx����p,e��d�٪�3��NbK�5��
�L��s]m��#�����H�RE�66 �NE�$9>���v��s�٪���)�Q W@����>iR�(d,�fӠ����^�=i?ڍB�X��Nͭb��#ȫ��t�=M�YT�r�*��!@)5eY�y!%�"�s-�cvJb[M�/F�%��jX?쳢U\�Idʘ�����"��ۚ{`�@�P��d�q=G��qQ +�*๙_?\�#RX�BU��X��l��=�FY~����Y	ZNX	�@��lO���}B�f�>m�I�M������ Q��b]�i���D�:�;?��ڿ�P�S��ĉ�� o&����E��Q�����\���=��r�17�Y��qZ�Zϝ����4��J�]�)��t0�l���;�44gEw��W�H�mb p��W
8���c͗s_Pa������STF~Z�{NIe�����z��}Q��D?�r,��?)4��ASS�+ق`H��~N:-a����\z��"�n��)��ИC/Pv)�ϔЫ�M�����N>�PM>|0���:0��>�}1K0A�O��:�#Z����F�2�@����9D�����t
�?���Ɛ�,����^67 �o�˥�O��R�'��ɬX��^�F��#�r��.���(�W�2�Rs}d!��1ye5q:M���s����_���%���z�%Zp�U"�,���#67C�N��rg����*gRb:��Q����m�E�8n� ���{�`S���^9$W��Wͅ��%�Z�t��O��>���jO-�j�J���
�g$�%H�����H��6~왻Iߝ���Q�_<��Q%LFz�ٗ 5���E��0s�.M���=|�U׺� ����+��i�ik|.@�'��K�r���IU1�z�q��o���͵��w2�]�1S
��A�i������#TKA
�.O��\�j�U��&�:P��f2�?������zn��c���%P��j�W1)�aBaA����c�I���T�6V�r���n����=(�����+=O ��e��)�;�!Y������b�ɞ~ØYHz��,���m���>7�m[�����m!�(=�S�yQrP��J���K�ѳ`J̏";Nq��rT�J"4W{``�ˤz�����9�&R�{����+ǚ��sGr'lb�4Y���_C��	\9�!�W�rݗl�,D��������\,��퀹����m���m����ҡܫ�?����?"Vfk^ֹ�Yw��N��#�`�O���4;�z��?�WT<Ma�hEʧ�M�/������3����hs���=;	S(�����ձOl��d�CS���R&p�Rq���:qq/;�'���
�7�	��9��_L֙=�ھ�3��C�S [��nu`V�3�j�G���C4��H�~\&T�G_��3Д[:r�-���s@���ȳ����?%2=#|�K�e�����B����A�@�\n�rġW��j螔�fF�����o�Gq><�%}��}s\��'���3���v���yitj(9�?�9����'x             x�U]I�%�n\gF�yȳ���O�j�i�/�A�����ϭ����Yk�i��{�g�����w��z�����{�{����[�?i����91���oݿ�|�g�ο/����V~������w��'��,��w~F���_J�|��m��?��i�N>g��~�Z~��|1^��d|��>���0�'����37>a���_�1��az{�
�
��G̻u��q��i1&'�a"�M��;�k�b�����6�t-G����>|�9z��|�?X��O�;�&x��i많߹~G�����k�g��1�1���A=��V�Җ���5�ɿ����_�?�7.U�?+�w��wc�-�������ţ�TS���k��r�8������x=?����rI0��3���F�u���9��1*l�������0�6m�eg�{���ݝ����~0�{�1�,��y�b��*ڤ��� L�����rNF����a�����Ec�p�������jV\p���~�ǮV����pB��C�d���t�I�z�����X\r<��Q\����֞9XO�h}|������_X��~-�ࣸT���[s���g������j�`Ϝn�_����miܧY>L�o?���� �zVm O��G��=����������
3Ò�!��\�R~��Pd����Ml9���T�X]�'~�n�w`VX/	^�1�Jׁ����\N�&�=�\h�>��h6��e�s�>l���T9(�_���s�tx.��U�Y����4����4Dl��wp�`�]k�խ���?978�p��hI��0�
˅_��r���Gak��ܚ�(�����;��M�aǙ]SG�>lӨ���/���-���^]x �b��-Y��޸��m>M&��rK>��qߡ-r0\��m�o���Y^y�}�S��_��&���Q�n�7f"�V���kQȒu+��X:zgX��C�h64�߰�V0���6epX�mK�GFݹ��s�z,���ߏE,��`���ǀ�߉�NY;|#<ߩO
h�����t}{��$�p����k����)���^��[0Ѥ`��;�g�����@ā����2;k�-j|��6-Wa�������Qt:
���{�r'�;�]|7�p����n�G,9�t�Wa�0�����v໧��_D�L�q�g��x�.{|�;���h�����	�Ъ��_���
u�Lស54������^�r�b�#jmZ�AL�v>[gS�����YN�����SW�>�tV	�|m]^F��?�~N�mqeC��~�w^��@�n���l�=�o]�����K����B�&}���e�: �x�1-��Z�Q+>����B4��oCK���+aܕC����8��}��g���)�S�f1�T���r�_V�!�V���� @w�`Xb��)9�'���)l��5{azO�`�i�CQCN�	�U�9Uth�BC��b��P��=3�p���d�:C>~ě�5_Zdx��y���b���UAsM�3���&(����=� �](���a�֫S��nx@�^�����(BQ��R�/V���s� �q�07,�$�2 1����u�% X�k�9:b�*L�n���k{�k�_�C+
���!W������F�F�� u���Q�O������~a���5�R�I�s�xNl����z�3�Laq�� R���铀�<�c�����0�:sFç�Z}`ˮ��X�z�\5§�7�H���M�8�>G�CX��+&:�����b���N{j���æ�����59='h����!H��)�`kP�BW#��� ��	E�d�<��LO�a�����}+N��
�H:��V�w}�}v��#|(�f��H8N�|�[����vN�*N�g�m6~C��;�3؋
��0�'i�Fp��>�3P������X��;ѡ#hK�ﶹR��~����us�p��~iA�p9g��P5B7-gM��B�샛/�W�͔���%ʰ�+_=#u��T|�``cJJ����B����U�� P�� Nmً��Ê��IsK_�0��j	�-�H̚Xv:�A�o8q �����Ya+f��j�n=iI@�~�1�[���Q���W�17������۸�x���g�6�p�K�0&h���J�U �ѕ�*�</���$4!w�4y�&O	L��H D%�	ui���>1���Ud�' hqr[V����`�~�9I�*�<p��h7Y��q}q�����eH�k��h�52`(*g{�ՇN��vBuЪ1i��vd�4''��`	�f��ġ�R_.�PSO�9��"����6�2�!T�./��p%V�K4��#�Y���������A��1�ϥ�j(e60�r6z"x�Mn��(9~9O��b��\�VCO��r�����I��8k �����vIa���S�'
h�JBB�~�����t��+�c1���]3�}2/>뾶�c�@���GpxI�yd�quxƊl
;:v�����`*�9Sta���y�#�h`U΍�����?��فC֍�T9,fy���%3�C�̛�3�#�S�����jt�`�`S܂4p�V��{q���GтI��wkO�t������4i����������?
<��C� GJa��#8
��NŰp@��T��TLjp�)�^�/P��p��!R�RWQ?��gG$=��y���w�o@K������D(>���k���I���&E��Q/������i������#o097,��K�E�US�|�T�[nG���0,���ƸJ&gq�&(�d�(����A ��i|�V�n��@�h�},�97�w�>���-�X!?����㕅��o��{M�ݾ�!�#;�A��ۇ���?�� �)�P`��������.
�N���OB"�i�)$��m��}�EP�x�췉�"ʽ�d�<�\�~C�z���F6b��c���bm�JcTG$8��3�(	q�R\��bT��z2�lp�c�W�91����1�У<N������7�ؘ�-b�5�k!i��L�ߒ�]JV�EĮ��<ɲb �9SL�ט����̇j����	�D���p�W���U����}Q�5��2D�9	��@�]�,�@K� C:��;q���u���VX�$�)��2Os���9��-p�M��h�L]΀S{�-��E�V����F'����hq{�
U7{�k��9ćE�&ݍ\e�*�[:+'�V |H;���x3�&��&�L�{�*��WX��kA#,�=27�;��źˊQw��`����^��M4j҆>��Ԥ��	���%��ѣcjf�+�l-�%K^�\�c������G/����:.�i�`SzI�ڻ���}��H�wN�(�ِ��[�C�^Si��!B<��t�������-���aG%�0�\�]�3+V�h��Qq����8��-���U ��:o��ak�4L@-�X�l��/����3&�#�K���+�� ��)��CGˈbFXu}j��<E��Jp䐰D�W�$�8�������~Z��k������a�kZ��8��[�O&6&��3e�����&Z�2G!�A�{�Ha��Tg1x���#�/�a����qC{r_~xx����5w����N�BL@a��L���<���#�	������X��c`�J���I�T&�k�����HlN��@@��d�:��)��@t|cw�o��~Z���Y�y>:x?r��h��[uW��'��aw�,ܘ{jH���ܒ<�.��TI���=�m3=�y_Z5�Ԭ���\�Z!�c��j.޷M,�9w@�Pf�m҇" ��hR30E߃�rDN� ��MU�gB�PPfI�#�ƦX�Z""G�Aȏ�6�΢d�q���p��B�R8�/��P���3uF�S��� ~��� � �$�qJZ��|�U]��a9��;�չ��c9�4��v�*NH5Z����_�A �
��@��    E'�r�fP��I΀<��Hq�+:,0o3#՚ك�C�Lِ���:s` 1��gs�L�c̳T̀Dd5�`*^�� ޳�64L,T_M%��r@tW�I�k#":ѡKZ�j2Ѯ�D_L�+NY5�#���u��`KP�Y�d�S�a' ��bO��Syg:<v��@�`B�����\.~�M;FLqo"��$�����7e�Z��y�`�E����̰E���L�D�6�٣���S"�#
%��D��l��h�C��^�+ً��� t?<W��aj@�#!^Z*��|���i��&�Ӊ�z��8�=	7Ɛ��R#��9��p����Ô�+#B�r-��/W�!
2��#�^ܹJg&58ij��&�*PO��uɁT����!��@/�)@��Ш�!�%5��%��԰���p�q�����a�8���A_���c_5����F�L��^;::�m��	�1F��H�S^�R�} �o�"�'�pc�:�ET�Ke����}YN����B9����s�T��J�H��:�zi<e}��TWQ�.�����D��*T�ں������?�qS���cV�V�l��e���?'�{�D��:��B7:"���B�Z����
  J���1$G���\̥���)L�˱FF�	4�.�*W�&�C�{(��R�8Q����R��0�`J���ƫ)}��ڋ���"����F�+jr����u���
-��5�-�ՙeuI1	��^Uz0H����'u]�ف�pC��Z�CYbq��tq��ߣWr>NO�E |�A����k`��pp��(S������X�ª4G��.�5�4ԏ2��(n��X-��H�5L]�N� �լ�G
K>lysSz�Xx�{e
�Q:MF���qW��6^	�3��$ɽݗ��ǲ�$�V%��I�Ơ�o���g16@�'Q�S�
������jM��#��-�E��H�1}���J��	����~��zj$H��%.��걅1$\�R2H*�kҐ1��9�:-X��aż�:�+��tY@^U��� �g��ƶFD�����aW�,�O�?c�'ڛ��"J$õ?<=�/�{��{�;�VK��6|��C�$��k.�$��e��IZשr������9��I)��b���#%n-Χa���oaKh�pw���'Ya�O����鶿j	���$���޺D3C3K~���Z1²኉N�@��#�M9�I�:_:��Q��Z�AU�fֺ��+|���XHIB犞3ؔ���barl�@y�^̠���:߳\�S�5�ݭ��#-Q����Mr�����H.V8���R���E	x�!�yj�%̳ڵ݇gm��y��"E4��|2��o�HM�i�R�b'\��T��5Z�e&�'$4>�G[;��$y�$T��^N	Oq�e��?W8|z7��"�����`Hϊ���'��?S�̈́GIeT�t�b-= ̧Q�m�r&�`E/�1%Ԑ���0��C�E��Th V���[����[
������P"5�=��dS"ْ:�+z�k��CK`�8�l`דZ��j�m$,a&���Y�0�^5�	���_L���x#�{�o���;�JX�Y�ٕ��|i��Ӱ����@2T`�Ǭ

����xrj(�?ȱ<q��"L�o�O9���BqX���vd�Ş|���r(d`��$�C�I��5�͘�G��I
��V�XH1�`N-�PM���'bvNG��8^�]Й�?������nqnַ[C/>~��3p���S� �(�Ig�g
gL��9�Y!?,X�WR�#������ݑ�Qz3�#�KȆ0�_ٮ���ʔK�'�3�*`��UQ�*1s�]�2�Z�-�*(D��7�܊�x�caT���$�']bm�c��@������n��L!�O�g��|�9�=0�5(QN�ѺV�!��QL�lV����VL�ڷ��i��~6��4
Gk��.�H�2��`�F]����ԧ���e�+�����l�Y'2��d+�^,|U�O�ȵ���[�g�9;��g"TD��X���Z�#>Zk͚�P�8cK��8<d.=��]�>��a�X��t���6L��!�:��:Xp�(�:U#�&�N�'DR�:��R%L�}k?���>�}+�{E���;C��sX�=���"Z�Q��?����Ӈ�9ݙ�	�Q�~J-h�{���}"�D-`�:	,̍t��ev����)��Z}�ˀ�<�7\W����d��{��ž[<�ı<��{�<�fy�-9��pq����u���/�J��)z�n��ϱ�?i7'{���+�w�[F�R��2�,v�x�"��6����(���TgHp�������m� �D��c
$���We�����j�	��JH�&��.���.	���e����BDM��;�婾�v�Qy
���������5�6�G�+ ��X38���L�}��"�6�lR^pg�
��܇���<��Վk6�.��؍��H,1�BK+z�X6-/�;3P��@�/\"T���n��<�iX��(���i�Q�]9Kփ�_WQ}�#G���������\ҡ�_:�Ps�'p_���3�zv�ܧ�nO��#�H�N��הJ-������%8'�6���Mp7�݁h^�4�S�޺ �����N�b�G�D@�T�΅�1#�Sգ�fŠ�"�u��Ų��mY���q���9�����Gj�d��R�·��K �����GaU�ĕ�XM)��I��g�ʱ��f���z���ߐ��;�����-��Xvs�x�!t?��nm�R��c'��jr������\w�<��U�Y��,H��(��F�_�/��:DR��~��즽�).Mc#Y��ge��#%�aU��O5*w���$�>%�yZy�(.'AĺS��� �'��# J>��zZVՂ=��"����@��3�����a;�rx%����x�E��*�a+�_��|=e<:8{���XZ���ø�y�M��e8�'�����x�)m�I�k��4��{���Y��cОzJ�1v	 �G^AG�w1R�@QM͐�4�4���:�,�g%?�����#�Wq�K�$�.�5M��O�+0�w�Ù�c�]�t�tO��m'����8	��-�����sWQ����Z�XA����i�)D��c�j��Q��]<p%dC>�g�}3��j�1���+?)!^<-� �2��[��r���2���rq&�]-��r�A�͠�ܜ�ř|�!���Drkam@Y�"�����s&��#��i�����+����@-���h��t�D�-F�I1B�X4"�#T������|�e�&Tː�|-v׽�:R�|J�{��ο,r�>_D�lՊpu��X�k-)O,j��A,V|1��s���f_�6�����Hu��N:k95�C����xB�)u�̙jp?�Œ#K(�͗��]	���"A���pE�5JL��k����`�ڎ�x�V������u�GOk����'�pLv͕�^�� |��Z��ЩU�N�_IDUayw
RI��P!��'�U~%�õS�������PGS�M����7�M�����o�w����oX�� !ֿ>�'>�{p�Ss���P8��X�Ӭh��~.1�.��Dq,���gb�|#<�*��n�pU�xFcj�� ���s�s6��N�W5�j��w�Bi	��=�Ŝ��F��Id�	�/c�"���zZN����c�6a�y�(�U��|2�u"���T-],J&/�WKG��Ö�Gn�L�Ѳ�]�$�3s���))Z��Cnc�yo͙�0L��jV��V�Ib..��* �O�M'���Q����ߔ�l��e��+1j��vY�[���ɑ�O��^k��n#Qϻ����: n *�wMw! Z���Lp�|��eE�d���}�:�+Tc0�mé��!�[���3�:��n	Of�rF����y��"���ᨩx��k
d���:����U�>�Ag
��Q���>������,��n��h��|waU�D��w��;�~M���������	�؅��Ϭ-%o�C��;OC�A��,���8	��N78 A  �h��kMZ���d|YF�mW�S*X_�����o�HbD=���b�I
���ԛ����+j��:��v�J�=��Z^�̧�0��������yH��6���
Z�QNF�8Wy(��V
JE�z�V<��N�,r�t.�!�B�z�7N~��.�]���G�Jd�'�b�z7������3<~Z��x��rg�x�P�-��pE�p�P�s�:i/��O�\����_OU[��-�SUL(^�)2�e�q>�y�x.NifU|�θ,%5��Y�U_ -0`Ć����>��q7'�d�E�m#���B!}�
0�}$���M��iw��W��扃7dy��0W9hm�4k��ȃ�[~}D�p�1ܮ��h��N�@�3��I�i���2���:�kE��"Yh�H��\6b�eLMM/ї5�J��)�t��n�9�~\5^8Sf�!I:��}�[_n�ᾙ{��j�۬���?�4��wθ����p�O��g�7*����®��1a�����ќ��t��Ss;��\У%���ks�.*��/�a3��aCU$ �Mm�84�}�R!.�(K�����1���+�݈��n%�����3u���"��a��O?F���b���X<����'췿I��[4~'��}1\����jΛW�X	%���[�v�Y$_\���I��k�(O��CEa�S|�皝#x��φ�s�H5�z|��S\��m���q�(9���͉#���;o8;�(��a��b�R=�*֎l�PI�f�l]ܣ�<e�)FdsY�ݵܯt}��P퉴�G�`����#�Ww׽�/(�cV�GI�	Lu�R�s]���q����=��K�����E�˟,q.;$��J����d��eY���n-��=0�h(W�%�r�$O�A%�����9GN���%������7q��P.���J����$H��[�oG�����\���T=�Z\8w�{
��7����bz�����.��=A"_����b��� �[�_�VeᰋD����;œ��c}vY����Er^ٿD�V��!��G��:ZkN�1k&{}�s�V_��z�����l�z�U�@݋GW��[�K+�dx�YV���Z�	��d-@�C*$^��;5�O�8?�x ��Ly��>OV�ό2פ�TjK~�����;����1t�˿V7dcGw�<�=��&3P�YG]0�%2�N�on�}���5δ��7��$6L��T����]$iSxq��%,(�̱��O��+�*����,A�O+XSXo��m���w[XK� � ��j��Y�©��x��39j8 $xVgM��=�^����$�b.k�����`��D�x%)w����\�]�ٴ�������!�p("l���MQ�ң6�æ��9^�`Ȗ,U�8����wW�K�ҮS�0���'���0G�!�ǻR��"�s�����R[zb��כ^�Ch���
��l5�a�����9�n��ڮ>���Y!�&��f?"C��~����C��w1�-=Mm�g��r����/Dd�_���R���E+��H4�F�Xe���E����~�ʜ������~jG�B|�0���G��<������z� ���\��#�v�=�s�Z���A9�ҸU��j9Bfg<�Ԍ��">+Mvz��L��ǉdg��L�_�nM��f���3 4du����|v�`b����[F�\2��D��ѬyMnf9���O۾PO<�����p:��x��cpYA�F��9���D���;=���[�!��w߂�?KFD>��7]�0�;￴��fEWP��Y�ׁ-k\G{*[�[�u��R�+'a�q	K�d%�fxuA�Hg��`kR��a�R���1o�����P򜹚)&��\~�R͜j=���&�O�ZT_��ޢ��j�x1���*	Z���.|֏+\���GQ�,�?�#a>%�ӹ�;���1��x�ĕ�Tu�����3����o�`��(w�ʪ��a��	9&%�i��ɝ9�U_�{�ں�긼vz�D���Ʌ#�q4ݮ�����f��'�e�W���W�1t�4�&�����Uy���r��b�|��*�c���-g�~���켞���<ޭ58q$k��Ѓ�� `��Dl�����g'~�c�.�����ӥ�;��u97�`�&���i@*����t�5��K�.vp�����c�Q����J�����i��@#��m$�5r	^SfM�0��̬����sE���F���/��O55ۮ:�ڻ�z<���Z�.1\���נ�p���������l�~�KsY+���ϒn��^�\j(j�Li
�j�X��D_�n������I%s+��_9�V#����컺R�A��}��3�&���vb�s�eQAw_��[�_��?�K�ZY��v�!�dڴ��%�ָq6�����������e���WGc��n�;R"�k��NGfXo�p1-� �.���E�7����_��>��k�M�rj��E nܨ���k�ĴY6�ҖF�PX�5|�/�@��+�	?��|t�g���sCg��Bt_��b}0F`���2pˌ��e�In�ҍ��u�m��/��cN��ݞ(�5U�3��Ó-;Qy��M$���?w��!���w�V�MР���+��="����:�l�����ZSr8ߕ��]H182���-xJt����F�ȹ �Ч�����Lӗ鷿²���>B�X�+[/�CWR�b��y�~r��D���ď�0���q��h�z���(���)�K���T�1ib��0>"��r��4�;��*6�n)|������C�����/Ї��bV����2��F�ot������}��ת�     