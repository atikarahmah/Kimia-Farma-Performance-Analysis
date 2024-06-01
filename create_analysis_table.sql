-- Membuat atau mengganti tabel analysis_table dalam dataset kimia_farma
CREATE OR REPLACE TABLE kimia_farma.analysis_table AS

-- Memilih kolom-kolom yang diperlukan untuk tabel analisa dari beberapa tabel sumber
SELECT
    t.transaction_id,            -- ID transaksi dari tabel transaksi
    t.date,                      -- Tanggal transaksi
    c.branch_id,                 -- ID cabang dari tabel cabang
    c.branch_name,               -- Nama cabang dari tabel cabang
    c.kota,                      -- Kota lokasi cabang
    c.provinsi,                  -- Provinsi lokasi cabang
    c.rating AS rating_cabang,   -- Rating cabang dari tabel cabang
    t.customer_name,             -- Nama pelanggan dari tabel transaksi
    p.product_id,                -- ID produk dari tabel produk
    p.product_name,              -- Nama produk dari tabel produk
    t.price AS actual_price,     -- Harga produk dari tabel transaksi
    t.discount_percentage,       -- Persentase diskon dari tabel transaksi

    -- Menentukan persentase gross laba berdasarkan harga produk
    CASE
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
        ELSE 0.30
    END AS persentase_gross_laba,

    -- Menghitung nett sales setelah diskon
    (t.price - (t.price * t.discount_percentage / 100)) AS nett_sales,

    -- Menghitung nett profit berdasarkan nett sales dan persentase gross laba
    ((t.price - (t.price * t.discount_percentage / 100)) * CASE
        WHEN t.price <= 50000 THEN 0.10
        WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
        WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
        WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
        ELSE 0.30
    END) AS nett_profit,

    t.rating AS rating_transaksi  -- Rating transaksi dari tabel transaksi
FROM
    kimia_farma.kf_final_transaction t  -- Tabel transaksi sebagai sumber utama

-- Bergabung dengan tabel kf_kantor_cabang berdasarkan ID cabang
JOIN
    kimia_farma.kf_kantor_cabang c
ON
    t.branch_id = c.branch_id

-- Bergabung dengan tabel kf_product berdasarkan ID produk
JOIN
    kimia_farma.kf_product p
ON
    t.product_id = p.product_id;
