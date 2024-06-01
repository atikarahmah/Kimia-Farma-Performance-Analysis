-- Top 10 Nett Sales Province
-- Membuat atau mengganti tabel 'top_10_nett_sales_province'
CREATE OR REPLACE TABLE kimia_farma.top_10_nett_sales_province AS
SELECT
    -- Pilih kolom 'provinsi' dari tabel 'kf_kantor_cabang'
    c.provinsi,
    -- Hitung total penjualan bersih (nett sales) untuk setiap provinsi
    SUM(t.nett_sales) AS total_nett_sales
FROM
    -- Mengambil data dari tabel 'analysis_table' sebagai 't'
    kimia_farma.analysis_table t
JOIN
    -- Bergabung dengan tabel 'kf_kantor_cabang' sebagai 'c' berdasarkan 'branch_id'
    kimia_farma.kf_kantor_cabang c
ON
    -- Kondisi join berdasarkan 'branch_id'
    t.branch_id = c.branch_id
GROUP BY
    -- Kelompokkan data berdasarkan provinsi
    c.provinsi
ORDER BY
    -- Urutkan hasil berdasarkan total penjualan bersih secara descending
    total_nett_sales DESC
LIMIT 10;
