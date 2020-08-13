-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 13 Agu 2020 pada 07.25
-- Versi server: 10.4.13-MariaDB
-- Versi PHP: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e-votingwebsite`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_acara`
--

CREATE TABLE `data_acara` (
  `ID_Acara_Pemilu` char(10) NOT NULL,
  `Nama_Acara` varchar(30) NOT NULL,
  `Tanggal_Mulai` date NOT NULL,
  `Waktu_Mulai` time NOT NULL,
  `Tangga_Berakhir` date NOT NULL,
  `Waktu_Berakhir` time NOT NULL,
  `id_Organisasi` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_acara`
--

INSERT INTO `data_acara` (`ID_Acara_Pemilu`, `Nama_Acara`, `Tanggal_Mulai`, `Waktu_Mulai`, `Tangga_Berakhir`, `Waktu_Berakhir`, `id_Organisasi`) VALUES
('PERMIF', 'Pemilihan Informatika 2019', '2020-10-01', '18:09:15', '2021-01-01', '16:26:15', 'HMIF');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_admin`
--

CREATE TABLE `data_admin` (
  `id_Admin` int(10) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(300) NOT NULL,
  `jabatan` enum('head','member','','') NOT NULL,
  `id_mahasiswa` char(10) NOT NULL,
  `id_Acara` varchar(10) NOT NULL,
  `id_Organisasi` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_admin`
--

INSERT INTO `data_admin` (`id_Admin`, `email`, `password`, `jabatan`, `id_mahasiswa`, `id_Acara`, `id_Organisasi`) VALUES
(14, 'bagaskuhaku@gmail.com', '$2b$10$vWPcyX9i7UJUFt90q321JuP3b.zhJyjDEJ4T12Oaet4hEFKF0MAzy', 'head', '1301194051', 'PERMIF', 'HMIF');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_fakultas`
--

CREATE TABLE `data_fakultas` (
  `id_Fakultas` char(3) NOT NULL,
  `nama_Fakutas` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_fakultas`
--

INSERT INTO `data_fakultas` (`id_Fakultas`, `nama_Fakutas`) VALUES
('FEB', 'FAKULTAS EKONOMI BISNIS'),
('FIF', 'FAKULTAS INFORMATIKA'),
('FIK', 'FAKULTAS INDUSTRI KREATIF'),
('FIT', 'FAKULTAS ILMU TERAPAN'),
('FKB', 'FAKULTAS KOMUNIKASI BISNIS'),
('FRI', 'FAKULTAS REKAYASA INDUSTRI'),
('FTE', 'FAKULTAS TEKNIK ELEKTRO');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_jurusan`
--

CREATE TABLE `data_jurusan` (
  `id_Jurusan` char(4) NOT NULL,
  `nama_Jurusan` varchar(30) NOT NULL,
  `id_Fakultas` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_jurusan`
--

INSERT INTO `data_jurusan` (`id_Jurusan`, `nama_Jurusan`, `id_Fakultas`) VALUES
('1104', 'S1 TEKNIK FISIKA', 'FTE'),
('1301', 'S1 INFORMATIKA', 'FIF'),
('1302', 'S1 TEKNOLOGI INFORMASI', 'FIF'),
('1303', 'S1 REKAYASA PERANGKAT LUNAK', 'FIF'),
('1601', 'S1 DESAIN KOMUNIKASI VISUAL', 'FEB');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_mahasiswa`
--

CREATE TABLE `data_mahasiswa` (
  `id_Mahasiswa` char(10) NOT NULL,
  `nama_Mahasiswa` varchar(30) NOT NULL,
  `jenis_Kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `angkatan` varchar(4) NOT NULL,
  `id_Jurusan` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_mahasiswa`
--

INSERT INTO `data_mahasiswa` (`id_Mahasiswa`, `nama_Mahasiswa`, `jenis_Kelamin`, `angkatan`, `id_Jurusan`) VALUES
('1301194003', 'Layli Rahmah Sulistyaningtyas', 'Perempuan', '2019', '1301'),
('1301194051', 'Bagas Tri Wibowo', 'Laki-laki', '2019', '1301'),
('1301194059', 'Bagus Dwi Prakarsa', 'Laki-laki', '2019', '1301'),
('1302194003', 'Putri Wulandari', 'Perempuan', '2019', '1302'),
('1601164267', 'Emir Maulana', 'Laki-laki', '2016', '1601');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_organisasi`
--

CREATE TABLE `data_organisasi` (
  `id_Organisasi` char(5) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `jenis` enum('Organisasi Kemahasiswaan','Himpunan','Unit Kegiatan Kemahasiswaan','Laboratorium') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_organisasi`
--

INSERT INTO `data_organisasi` (`id_Organisasi`, `nama`, `jenis`) VALUES
('HMIF', 'HIMA INFORMATIKA', 'Himpunan'),
('HMTF', 'HIMA TEKNIK FISKA', 'Organisasi Kemahasiswaan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_paslon`
--

CREATE TABLE `data_paslon` (
  `id_Paslon` char(10) NOT NULL,
  `id_Ketua` char(10) NOT NULL,
  `id_Wakil` char(10) NOT NULL,
  `No_Urut` varchar(2) NOT NULL,
  `Visi` varchar(100) NOT NULL,
  `Misi` varchar(100) NOT NULL,
  `ID_Acara_Pemilu` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_pemilih`
--

CREATE TABLE `data_pemilih` (
  `id_Pemilih` int(10) NOT NULL,
  `Token` varchar(300) NOT NULL,
  `email` varchar(255) NOT NULL,
  `id_Mahasiswa` char(10) NOT NULL,
  `Id_Paslon_Pilihan` char(10) DEFAULT NULL,
  `id_nama_Acara_Pemilu` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_pemilih`
--

INSERT INTO `data_pemilih` (`id_Pemilih`, `Token`, `email`, `id_Mahasiswa`, `Id_Paslon_Pilihan`, `id_nama_Acara_Pemilu`) VALUES
(4, '$2b$10$bGgYovUAX8uA4EPTgm4cIOEzQn7EOCdTiKH5fzuv6pMrayPHNDoeC', 'bagaskuhaku@gmail.com', '1301194051', NULL, 'PERMIF'),
(6, '$2b$10$Hmq93sxNmEfLya/AZITwzOmftsYQGlmKdYrBcvnPkr03Up509p/ke', 'layli@gmail.com', '1301194003', NULL, 'PERMIF');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_peserta`
--

CREATE TABLE `data_peserta` (
  `id_Peserta` char(10) NOT NULL,
  `id_Mahasiswa` char(10) NOT NULL,
  `id_Acara` char(10) NOT NULL,
  `jabatan_paslon` enum('ketua','wakil ketua') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_refreshtoken`
--

CREATE TABLE `data_refreshtoken` (
  `id` int(5) NOT NULL,
  `refreshToken` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_refreshtoken`
--

INSERT INTO `data_refreshtoken` (`id`, `refreshToken`) VALUES
(3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFAYSIsInJvbGUiOiJtZW1iZXIiLCJpYXQiOjE1OTQ5OTk5MDd9.15tPXhaEpsLT66Z9ByNIVrxdpdYm6xI2fSQiggdKFhs'),
(4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJAYiIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MDA1MzI3fQ.bf8adSnWsCZAi0JvCybdu8ze5DX5xrI5cSH8v_hAS-k'),
(5, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1OTUwODU0MjV9.fQZqp4Eb30uGx0Sl3rCrlfrs5SZl91BDQzZINr8w_sg'),
(6, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjA1NDQ4fQ.K6FhO3DqWhGP93hOkiWUWMvzymleFbv1ctNE4vchhYk'),
(7, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjA1NjExfQ.DWI6yqjbpFdXDTHO_of5iZEoEAxDXxeW0fsTkknXf1o'),
(8, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjYwNTgxfQ.wkVZrCEss98kunpX-IdMEAGb4KiIoJrHegTrXXoQABY'),
(9, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjYwOTIwfQ.fWSjlomaDIiR134ze_iP3WEjfBrIR_C6-0Uk6nP1ABo'),
(10, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjYwOTI2fQ.lYYsTXH3LJql7shAmb_cyu0Cr0NMtopOkGyQCyWRqWU'),
(11, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjYwOTMxfQ.89JscNEpcaAlL8iiuascFeymDJp8OeDIWzE-BWxP4O0'),
(12, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1OTUyNjMyMTZ9.8G5tqvd29FcyGC3xsvvVyrJ0kuZHRuFkCqtBL5ZeTEo'),
(13, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1OTUyNjMyNTB9.f0utoe7uGUMIAjXamfhgicVvXLEJSXn0AcG400WgX7I'),
(14, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1OTUyNjMyNzF9.Z266m-wptJy4-Vq4EeCNsqAoKZmiqkFMxTkTziOp0YQ'),
(15, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjY0MTc2fQ.BBa0ZdhHBL3_MBNg9c2UW2ztPlXYqilbM6S4HiGgDnE'),
(16, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjY0MjE0fQ.wguBYCTj8c7N7V1qeX7zPkrsdkWEe7RXMrJ8OFvXlMk'),
(17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjY0NDEyfQ.mawPO7P10NmUu6AtL33587rsCPJNyzEGWQaRA0_P28I'),
(18, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjY2MDY3fQ.6ehtx8is9ubqUhkf7tF6Ba9JmGwAQEvRSKlnDju2YSM'),
(19, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjY2MTY0fQ.5YyqUgQ4At0d8WXJeje14KYuAY7KfiWeiL-3bjPcXC4'),
(20, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjY2MjczfQ.v7Yq1B1HfYpG82oyZW6Tn4ABoLfmbvWvVaUg2exjhBA'),
(21, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjkyODgwfQ.vPbtuk8hgRDSbWt_6tCXv3gDXFtpy3UTr8XZXSoyUo8'),
(22, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjkzMzk1fQ.iyWKzlN-tdtlcjFBBDTOUy_Vz_rkx3ARIaJYPTpN_dM'),
(23, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjkzNDI4fQ.9F6BSY71IrjFE7thRLeWvY-ZlPelz28Dcy9GbVfz7vk'),
(24, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjkzNDcyfQ.N65qOPFCI1XBUyQH23maItDV7Me6pxdPnusPaI22WsA'),
(25, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjkzNTM1fQ.SI3Lk4LZnpa9G5u2pvFGTt5pgF8ZPq4sFT9oL4giTeA'),
(26, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjkzNTc3fQ.WHSBVSiVxZzMMt3CTF9zl5ZHfjqp6MufoSj4drHKRi0'),
(27, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MjkzNTkxfQ.0FxXwhvzRjFtgfCxPXF0TT54aSBw6V1WVHbLsVxcrQc'),
(28, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MzA0Nzg0fQ.OJ897gkhkMlud-470MhDp8txj0bNZ2bIlqJdmJojmLA'),
(29, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MzA0ODI3fQ.gaQUEGx7gS35Y3PLTzxfIgEK-9DaMRDRpJrb6MWBaTI'),
(30, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MzA1MDU3fQ.K3KZiLm0baE-Bw0xcJ51PCeR58r-qKuWCGC7aFcXTsc'),
(31, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk1MzA1MjU1fQ.w9gr8IFMaNjMDWGI5U52SXbqO1BLsDg-EPIx7aLKVo8'),
(32, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk2MjUzNjczfQ.LgdqEI_A6FuPImBew5bfeLZXC9WuEQiKR620_5nCnl4'),
(33, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk2MjU0MDMwfQ.EKR1AFWWE_zY-nYDzmnvQs_vDbrM6LdVOM1SEBg7ogs'),
(34, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk3MTY1MzkzfQ.JIC-UBFlBVLlykJ8A4AX4FIL3lZWgJPHBzTISs2vMY0'),
(35, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhZ2Fza3VoYWt1QGdtYWlsLmNvbSIsInJvbGUiOiJoZWFkIiwiaWF0IjoxNTk3MTY1NDQ1fQ.b-juR4BDajEAPxk_dwymzWmV483XS6dfJfKiPyGDZOk');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_superadmin`
--

CREATE TABLE `data_superadmin` (
  `id_SuperAdmin` char(10) NOT NULL,
  `username` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(15) NOT NULL,
  `id_Mahasiswa` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `data_acara`
--
ALTER TABLE `data_acara`
  ADD PRIMARY KEY (`ID_Acara_Pemilu`),
  ADD KEY `id_Organisasi` (`id_Organisasi`);

--
-- Indeks untuk tabel `data_admin`
--
ALTER TABLE `data_admin`
  ADD PRIMARY KEY (`id_Admin`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`),
  ADD KEY `id_Organisasi` (`id_Organisasi`),
  ADD KEY `id_Acara` (`id_Acara`);

--
-- Indeks untuk tabel `data_fakultas`
--
ALTER TABLE `data_fakultas`
  ADD PRIMARY KEY (`id_Fakultas`);

--
-- Indeks untuk tabel `data_jurusan`
--
ALTER TABLE `data_jurusan`
  ADD PRIMARY KEY (`id_Jurusan`),
  ADD KEY `Fakultas` (`id_Fakultas`);

--
-- Indeks untuk tabel `data_mahasiswa`
--
ALTER TABLE `data_mahasiswa`
  ADD PRIMARY KEY (`id_Mahasiswa`),
  ADD KEY `Jurusan` (`id_Jurusan`);

--
-- Indeks untuk tabel `data_organisasi`
--
ALTER TABLE `data_organisasi`
  ADD PRIMARY KEY (`id_Organisasi`);

--
-- Indeks untuk tabel `data_paslon`
--
ALTER TABLE `data_paslon`
  ADD PRIMARY KEY (`id_Paslon`),
  ADD UNIQUE KEY `id_Wakil` (`id_Wakil`),
  ADD KEY `ID_Acara_Pemilu` (`ID_Acara_Pemilu`),
  ADD KEY `id_Mahasiswa-NIM` (`id_Ketua`);

--
-- Indeks untuk tabel `data_pemilih`
--
ALTER TABLE `data_pemilih`
  ADD PRIMARY KEY (`id_Pemilih`),
  ADD KEY `id_nama_Acara_Pemilu` (`id_nama_Acara_Pemilu`),
  ADD KEY `id_Mahasiswa` (`id_Mahasiswa`),
  ADD KEY `Id_Paslon_Pilihan` (`Id_Paslon_Pilihan`);

--
-- Indeks untuk tabel `data_peserta`
--
ALTER TABLE `data_peserta`
  ADD PRIMARY KEY (`id_Peserta`),
  ADD KEY `id_Mahasiswa` (`id_Mahasiswa`,`id_Acara`),
  ADD KEY `id_Acara` (`id_Acara`);

--
-- Indeks untuk tabel `data_refreshtoken`
--
ALTER TABLE `data_refreshtoken`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `data_superadmin`
--
ALTER TABLE `data_superadmin`
  ADD PRIMARY KEY (`id_SuperAdmin`),
  ADD KEY `id_Mahasiswa` (`id_Mahasiswa`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `data_admin`
--
ALTER TABLE `data_admin`
  MODIFY `id_Admin` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `data_pemilih`
--
ALTER TABLE `data_pemilih`
  MODIFY `id_Pemilih` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `data_refreshtoken`
--
ALTER TABLE `data_refreshtoken`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `data_acara`
--
ALTER TABLE `data_acara`
  ADD CONSTRAINT `data_acara_ibfk_1` FOREIGN KEY (`id_Organisasi`) REFERENCES `data_organisasi` (`id_Organisasi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data_admin`
--
ALTER TABLE `data_admin`
  ADD CONSTRAINT `data_admin_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_admin_ibfk_3` FOREIGN KEY (`id_Organisasi`) REFERENCES `data_organisasi` (`id_Organisasi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_admin_ibfk_4` FOREIGN KEY (`id_Acara`) REFERENCES `data_acara` (`ID_Acara_Pemilu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data_jurusan`
--
ALTER TABLE `data_jurusan`
  ADD CONSTRAINT `data_jurusan_ibfk_1` FOREIGN KEY (`id_Fakultas`) REFERENCES `data_fakultas` (`id_Fakultas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data_mahasiswa`
--
ALTER TABLE `data_mahasiswa`
  ADD CONSTRAINT `data_mahasiswa_ibfk_1` FOREIGN KEY (`id_Jurusan`) REFERENCES `data_jurusan` (`id_Jurusan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data_paslon`
--
ALTER TABLE `data_paslon`
  ADD CONSTRAINT `data_paslon_ibfk_3` FOREIGN KEY (`ID_Acara_Pemilu`) REFERENCES `data_acara` (`ID_Acara_Pemilu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_paslon_ibfk_4` FOREIGN KEY (`id_Ketua`) REFERENCES `data_peserta` (`id_Peserta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_paslon_ibfk_5` FOREIGN KEY (`id_Wakil`) REFERENCES `data_peserta` (`id_Peserta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data_pemilih`
--
ALTER TABLE `data_pemilih`
  ADD CONSTRAINT `data_pemilih_ibfk_1` FOREIGN KEY (`id_Mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_pemilih_ibfk_3` FOREIGN KEY (`id_nama_Acara_Pemilu`) REFERENCES `data_acara` (`ID_Acara_Pemilu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_pemilih_ibfk_5` FOREIGN KEY (`Id_Paslon_Pilihan`) REFERENCES `data_peserta` (`id_Peserta`) ON DELETE CASCADE ON UPDATE SET NULL;

--
-- Ketidakleluasaan untuk tabel `data_peserta`
--
ALTER TABLE `data_peserta`
  ADD CONSTRAINT `data_peserta_ibfk_1` FOREIGN KEY (`id_Mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_peserta_ibfk_2` FOREIGN KEY (`id_Acara`) REFERENCES `data_acara` (`ID_Acara_Pemilu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data_superadmin`
--
ALTER TABLE `data_superadmin`
  ADD CONSTRAINT `data_superadmin_ibfk_1` FOREIGN KEY (`id_Mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
