-- Top 10 Total Transactions Province
-- Membuat atau mengganti tabel 'top_10_transactions_province'
CREATE OR REPLACE TABLE kimia_farma.top_10_transactions_province AS
SELECT
    -- Pilih kolom 'provinsi' dari tabel 'kf_kantor_cabang'
    c.provinsi,
    -- Hitung jumlah total transaksi untuk setiap provinsi
    COUNT(t.transaction_id) AS total_transactions
FROM
    -- Mengambil data dari tabel 'kf_final_transaction' sebagai 't'
    kimia_farma.kf_final_transaction t
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
    -- Urutkan hasil berdasarkan total transaksi secara descending
    total_transactions DESC
LIMIT 10;
