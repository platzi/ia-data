
create table categories
(
    category_id   smallint    not null
        constraint pk_categories
            primary key,
    category_name varchar(15) not null,
    description   text,
    picture       bytea
);

create table customer_customer_demo
(
    customer_id      varchar(5) not null
        constraint fk_customer_customer_demo_customers
            references customers,
    customer_type_id varchar(5) not null
        constraint fk_customer_customer_demo_customer_demographics
            references customer_demographics,
    constraint pk_customer_customer_demo
        primary key (customer_id, customer_type_id)
);

create table customer_demographics
(
    customer_type_id varchar(5) not null
        constraint pk_customer_demographics
            primary key,
    customer_desc    text
);

create table customers
(
    customer_id   varchar(5)  not null
        constraint pk_customers
            primary key,
    company_name  varchar(40) not null,
    contact_name  varchar(30),
    contact_title varchar(30),
    address       varchar(60),
    city          varchar(15),
    region        varchar(15),
    postal_code   varchar(10),
    country       varchar(15),
    phone         varchar(24),
    fax           varchar(24)
);

create table employee_territories
(
    employee_id  smallint    not null
        constraint fk_employee_territories_employees
            references employees,
    territory_id varchar(20) not null
        constraint fk_employee_territories_territories
            references territories,
    constraint pk_employee_territories
        primary key (employee_id, territory_id)
);

create table employees
(
    employee_id       smallint    not null
        constraint pk_employees
            primary key,
    last_name         varchar(20) not null,
    first_name        varchar(10) not null,
    title             varchar(30),
    title_of_courtesy varchar(25),
    birth_date        date,
    hire_date         date,
    address           varchar(60),
    city              varchar(15),
    region            varchar(15),
    postal_code       varchar(10),
    country           varchar(15),
    home_phone        varchar(24),
    extension         varchar(4),
    photo             bytea,
    notes             text,
    reports_to        smallint
        constraint fk_employees_employees
            references employees,
    photo_path        varchar(255)
);

create table order_details
(
    order_id   smallint not null
        constraint fk_order_details_orders
            references orders,
    product_id smallint not null
        constraint fk_order_details_products
            references products,
    unit_price real     not null,
    quantity   smallint not null,
    discount   real     not null,
    constraint pk_order_details
        primary key (order_id, product_id)
);

create table orders
(
    order_id         smallint not null
        constraint pk_orders
            primary key,
    customer_id      varchar(5)
        constraint fk_orders_customers
            references customers,
    employee_id      smallint
        constraint fk_orders_employees
            references employees,
    order_date       date,
    required_date    date,
    shipped_date     date,
    ship_via         smallint
        constraint fk_orders_shippers
            references shippers,
    freight          real,
    ship_name        varchar(40),
    ship_address     varchar(60),
    ship_city        varchar(15),
    ship_region      varchar(15),
    ship_postal_code varchar(10),
    ship_country     varchar(15)
);

create table product_details
(
    product_id  smallint                            not null
        constraint pk_product_details
            primary key
        constraint fk_product_details_products
            references products,
    description text,
    picture     text,
    status      integer,
    last_update timestamp default CURRENT_TIMESTAMP not null
);

create table products
(
    product_id        smallint    not null
        constraint pk_products
            primary key,
    product_name      varchar(40) not null,
    supplier_id       smallint
        constraint fk_products_suppliers
            references suppliers,
    category_id       smallint
        constraint fk_products_categories
            references categories,
    quantity_per_unit varchar(20),
    unit_price        real,
    units_in_stock    smallint,
    units_on_order    smallint,
    reorder_level     smallint,
    discontinued      integer     not null
);

create table region
(
    region_id          smallint    not null
        constraint pk_region
            primary key,
    region_description varchar(60) not null
);

create table shippers
(
    shipper_id   smallint    not null
        constraint pk_shippers
            primary key,
    company_name varchar(40) not null,
    phone        varchar(24)
);

create table suppliers
(
    supplier_id   smallint    not null
        constraint pk_suppliers
            primary key,
    company_name  varchar(40) not null,
    contact_name  varchar(30),
    contact_title varchar(30),
    address       varchar(60),
    city          varchar(15),
    region        varchar(15),
    postal_code   varchar(10),
    country       varchar(15),
    phone         varchar(24),
    fax           varchar(24),
    homepage      text
);

create table territories
(
    territory_id          varchar(20) not null
        constraint pk_territories
            primary key,
    territory_description varchar(60) not null,
    region_id             smallint    not null
        constraint fk_territories_region
            references region
);

create table us_states
(
    state_id     smallint not null
        constraint pk_usstates
            primary key,
    state_name   varchar(100),
    state_abbr   varchar(2),
    state_region varchar(50)
);

/*crea indices que mejoren de la siguiente query :
select c.company_name, count(o.order_id) as total_orders
from customers c
         join orders o on c.customer_id = o.customer_id
where o.order_date > '1996-01-01'
group by c.company_name
having count(o.order_id) > 10;*/

create index idx_orders_order_date on orders (order_date);
create index idx_orders_customer_id on orders (customer_id);
create index idx_customers_customer_id on customers (customer_id);
------------------
SELECT * 
FROM Order_Details 
WHERE product_id = (SELECT product_id FROM Products WHERE product_name = 'Chai');

-- mejora la sintaxis y el performance dela consulta sql anterior 

SELECT od.* 
FROM Order_Details od
JOIN Products p ON od.product_id = p.product_id
WHERE p.product_name = 'Chai'; 

-----------------------
SELECT C.country, CAT.category_name, SUM(od.unit_price * quantity) as TotalSales
FROM Customers C
INNER JOIN Orders O ON C.customer_id = O.customer_id
INNER JOIN Order_details OD ON O.order_id = OD.order_id
INNER JOIN Products P ON OD.product_id = P.product_id
INNER JOIN Categories CAT ON P.category_id = CAT.category_id
ORDER BY C.Country, TotalSales DESC;

-- encuentra y corrige el error en la anterior consulta sql 

SELECT C.country, CAT.category_name, SUM(od.unit_price * quantity) as TotalSales
FROM Customers C
INNER JOIN Orders O ON C.customer_id = O.customer_id
INNER JOIN Order_details OD ON O.order_id = OD.order_id
INNER JOIN Products P ON OD.product_id = P.product_id
INNER JOIN Categories CAT ON P.category_id = CAT.category_id
GROUP BY C.country, CAT.category_name
ORDER BY C.Country, TotalSales DESC;




