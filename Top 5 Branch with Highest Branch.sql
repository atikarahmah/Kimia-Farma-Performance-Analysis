-- Top 5 Branch with Highest Branch Rating and Lowest Transaction Rating
-- Membuat atau mengganti tabel 'top_5_branch_ratings'
CREATE OR REPLACE TABLE kimia_farma.top_5_branch_ratings AS
SELECT
    -- Pilih nama cabang dan rating cabang dari tabel 'kf_kantor_cabang'
    c.branch_name,
    c.rating AS branch_rating,
    -- Hitung rata-rata rating transaksi untuk setiap cabang
    AVG(t.rating) AS avg_transaction_rating
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
    -- Kelompokkan data berdasarkan nama cabang dan rating cabang
    c.branch_name, c.rating
ORDER BY
    -- Urutkan hasil berdasarkan rating cabang secara descending, kemudian rata-rata rating transaksi secara ascending
    c.rating DESC, avg_transaction_rating ASC
LIMIT 5;
