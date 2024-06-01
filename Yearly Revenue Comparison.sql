-- Yearly Revenue Comparison
-- Membuat atau mengganti tabel 'yearly_revenue_comparison'
CREATE OR REPLACE TABLE kimia_farma.yearly_revenue_comparison AS
SELECT
    -- Ekstrak tahun dari tanggal transaksi
    EXTRACT(YEAR FROM date) AS year,
    -- Hitung total penjualan bersih (nett sales) untuk setiap tahun
    SUM(nett_sales) AS total_nett_sales
FROM
    -- Mengambil data dari tabel 'analysis_table'
    kimia_farma.analysis_table
GROUP BY
    -- Kelompokkan data berdasarkan tahun
    year
ORDER BY
    -- Urutkan hasil berdasarkan tahun secara ascending
    year;
