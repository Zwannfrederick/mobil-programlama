const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '1q2q3q4q5Q+-',
    database: 'ogrencidb'
});

db.connect(err => {
    if (err) {
        console.error('MySQL connection error:', err);
        throw err;
    }
    console.log('MySQL Connected...');
});

// CRUD İşlemleri

// Öğrenci Ekleme (BolumAd ile)
app.post('/ogrenci', (req, res) => {
    const { Ad, Soyad, BolumAd } = req.body;
    if (!Ad || !Soyad || !BolumAd) {
        return res.status(400).send({ status: 'error', message: 'Eksik parametreler!' });
    }

    const sql = 'SELECT BolumID FROM bolumler WHERE BolumAd = ?';
    db.query(sql, [BolumAd], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send({ status: 'error', message: 'Sunucu hatası.' });
        }

        if (result.length > 0) {
            const BolumId = result[0].BolumID;
            const insertSql = 'INSERT INTO ogrenci (Ad, Soyad, BolumId) VALUES (?, ?, ?)';
            db.query(insertSql, [Ad, Soyad, BolumId], (err, result) => {
                if (err) {
                    console.error(err);
                    return res.status(500).send({ status: 'error', message: 'Öğrenci eklenemedi.' });
                }
                res.send({ status: 'success', id: result.insertId });
            });
        } else {
            res.status(400).send({ status: 'error', message: 'Bölüm bulunamadı.' });
        }
    });
});

// Öğrenci Listesi (BolumAd ile)
app.get('/ogrenci', (req, res) => {
    const sql = `
        SELECT o.ogrenciID, o.Ad, o.Soyad, b.BolumAd
        FROM ogrenci o
        JOIN bolumler b ON o.BolumId = b.BolumID`;
    db.query(sql, (err, results) => {
        if (err) {
            console.error(err);
            return res.status(500).send({ status: 'error', message: 'Sunucu hatası.' });
        }
        res.send(results);
    });
});

// Öğrenci Güncelleme (BolumAd ile)
app.put('/ogrenci/:id', (req, res) => {
    const { id } = req.params;
    const { Ad, Soyad, BolumAd } = req.body;

    if (!Ad || !Soyad || !BolumAd) {
        return res.status(400).send({ status: 'error', message: 'Eksik parametreler!' });
    }

    const sql = 'SELECT BolumID FROM bolumler WHERE BolumAd = ?';
    db.query(sql, [BolumAd], (err, result) => {
        if (err) {
            console.error(err);
            return res.status(500).send({ status: 'error', message: 'Sunucu hatası.' });
        }

        if (result.length > 0) {
            const BolumId = result[0].BolumID;
            const updateSql = 'UPDATE ogrenci SET Ad = ?, Soyad = ?, BolumId = ? WHERE ogrenciID = ?';
            db.query(updateSql, [Ad, Soyad, BolumId, id], (err) => {
                if (err) {
                    console.error(err);
                    return res.status(500).send({ status: 'error', message: 'Güncelleme başarısız.' });
                }
                res.send({ status: 'success', message: 'Öğrenci güncellendi.' });
            });
        } else {
            res.status(400).send({ status: 'error', message: 'Bölüm bulunamadı.' });
        }
    });
});

// Öğrenci Silme
app.delete('/ogrenci/:id', (req, res) => {
    const { id } = req.params;

    const sql = 'DELETE FROM ogrenci WHERE ogrenciID = ?';
    db.query(sql, [id], (err) => {
        if (err) {
            console.error(err);
            return res.status(500).send({ status: 'error', message: 'Silme işlemi başarısız.' });
        }
        res.send({ status: 'success', message: 'Öğrenci silindi.' });
    });
});

// Sunucu Başlatma
app.listen(3000, () => {
    console.log('Server running on port 3000');
});
