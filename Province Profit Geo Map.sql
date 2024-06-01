-- Province Profit Geo Map
-- Membuat atau mengganti tabel 'province_profit'
CREATE OR REPLACE TABLE kimia_farma.province_profit AS
SELECT
    -- Pilih kolom 'provinsi' dari tabel 'kf_kantor_cabang'
    c.provinsi,
    -- Hitung total profit bersih (nett profit) untuk setiap provinsi
    SUM(t.nett_profit) AS total_profit
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
    c.provinsi;
