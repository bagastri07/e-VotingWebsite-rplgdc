-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 18 Agu 2020 pada 20.10
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
  `id_acara` int(10) NOT NULL,
  `Nama_Acara` varchar(100) NOT NULL,
  `image` varchar(255) NOT NULL,
  `Tanggal_Mulai` date NOT NULL,
  `Waktu_Mulai` time NOT NULL,
  `Tanggal_Berakhir` date NOT NULL,
  `Waktu_Berakhir` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_acara`
--

INSERT INTO `data_acara` (`id_acara`, `Nama_Acara`, `image`, `Tanggal_Mulai`, `Waktu_Mulai`, `Tanggal_Berakhir`, `Waktu_Berakhir`) VALUES
(2, 'PEMILIHAN INFORMATIKA 2020', 'picture-1597754848328.png', '2020-08-15', '09:19:15', '2020-08-12', '21:19:15'),
(3, 'PEMILIHAN KETUA RPL-GDC 2020', '', '2020-08-06', '16:22:11', '2020-08-27', '01:26:11'),
(5, 'PEMILIHAN PEMUDA SHOLEH', 'logo-event-1597762400573.jpg', '2020-08-06', '16:22:00', '2020-08-10', '16:22:00'),
(6, 'PEMILIHAN PEMUDA SHOLEH', 'logo-event-1597762438664.jpg', '2020-08-06', '16:22:00', '2020-08-10', '16:22:00');

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
  `id_acara` int(10) NOT NULL,
  `id_Organisasi` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `id_Organisasi` int(5) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `jenis` enum('Organisasi Kemahasiswaan','Himpunan','Unit Kegiatan Kemahasiswaan','Laboratorium') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_organisasi`
--

INSERT INTO `data_organisasi` (`id_Organisasi`, `nama`, `jenis`) VALUES
(1, 'HIMA INFORMATIKA', 'Himpunan'),
(2, 'HIMA TEKNIK FISKA', 'Organisasi Kemahasiswaan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_paslon`
--

CREATE TABLE `data_paslon` (
  `id_Paslon` int(10) NOT NULL,
  `id_ketua` char(10) NOT NULL,
  `id_wakil` char(10) NOT NULL,
  `No_Urut` varchar(2) NOT NULL,
  `Visi` varchar(100) NOT NULL,
  `Misi` varchar(100) NOT NULL,
  `id_acara` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_paslon`
--

INSERT INTO `data_paslon` (`id_Paslon`, `id_ketua`, `id_wakil`, `No_Urut`, `Visi`, `Misi`, `id_acara`) VALUES
(1, '1301194059', '1301194051', '1', 'awdawd', 'awdawdad', 6),
(2, '1301194003', '1601164267', '2', 'awdawd', 'adawdawd', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_pemilih`
--

CREATE TABLE `data_pemilih` (
  `id_Pemilih` int(10) NOT NULL,
  `Token` varchar(300) NOT NULL,
  `status_token` enum('used','unused','','') NOT NULL DEFAULT 'unused',
  `email` varchar(255) NOT NULL,
  `id_Mahasiswa` char(10) NOT NULL,
  `Id_Paslon_Pilihan` int(10) DEFAULT NULL,
  `id_acara` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `data_pemilih`
--

INSERT INTO `data_pemilih` (`id_Pemilih`, `Token`, `status_token`, `email`, `id_Mahasiswa`, `Id_Paslon_Pilihan`, `id_acara`) VALUES
(10, '$2b$10$L1js4W44RPVTJzkgSGZWmOzm4fFB2r2TQo5xm/n02WLzns5ozPd0u', 'unused', 'b@bagas.com', '1301194051', NULL, 2),
(11, '$2b$10$CPiQ2G.9UG3eFxClK25W4eGfdR2s5SvdukErzrW0FXuphS9vxN9iO', 'unused', 'layli@rahmah.com', '1301194003', NULL, 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `data_peserta`
--

CREATE TABLE `data_peserta` (
  `id_Peserta` int(10) NOT NULL,
  `id_Mahasiswa` char(10) NOT NULL,
  `id_acara` int(10) NOT NULL,
  `jabatan_paslon` enum('ketua','wakil ketua') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `data_acara`
--
ALTER TABLE `data_acara`
  ADD PRIMARY KEY (`id_acara`);

--
-- Indeks untuk tabel `data_admin`
--
ALTER TABLE `data_admin`
  ADD PRIMARY KEY (`id_Admin`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`),
  ADD KEY `id_Organisasi` (`id_Organisasi`),
  ADD KEY `id_Acara` (`id_acara`);

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
  ADD KEY `ID_Acara_Pemilu` (`id_acara`),
  ADD KEY `id_ketua` (`id_ketua`);

--
-- Indeks untuk tabel `data_pemilih`
--
ALTER TABLE `data_pemilih`
  ADD PRIMARY KEY (`id_Pemilih`),
  ADD KEY `id_nama_Acara_Pemilu` (`id_acara`),
  ADD KEY `id_Mahasiswa` (`id_Mahasiswa`),
  ADD KEY `Id_Paslon_Pilihan` (`Id_Paslon_Pilihan`),
  ADD KEY `id_acara` (`id_acara`);

--
-- Indeks untuk tabel `data_peserta`
--
ALTER TABLE `data_peserta`
  ADD PRIMARY KEY (`id_Peserta`),
  ADD KEY `id_Mahasiswa` (`id_Mahasiswa`,`id_acara`),
  ADD KEY `id_Acara` (`id_acara`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `data_acara`
--
ALTER TABLE `data_acara`
  MODIFY `id_acara` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `data_admin`
--
ALTER TABLE `data_admin`
  MODIFY `id_Admin` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `data_organisasi`
--
ALTER TABLE `data_organisasi`
  MODIFY `id_Organisasi` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `data_paslon`
--
ALTER TABLE `data_paslon`
  MODIFY `id_Paslon` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `data_pemilih`
--
ALTER TABLE `data_pemilih`
  MODIFY `id_Pemilih` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `data_peserta`
--
ALTER TABLE `data_peserta`
  MODIFY `id_Peserta` int(10) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `data_admin`
--
ALTER TABLE `data_admin`
  ADD CONSTRAINT `data_admin_ibfk_1` FOREIGN KEY (`id_acara`) REFERENCES `data_acara` (`id_acara`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `data_paslon_ibfk_6` FOREIGN KEY (`id_acara`) REFERENCES `data_acara` (`id_acara`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data_pemilih`
--
ALTER TABLE `data_pemilih`
  ADD CONSTRAINT `data_pemilih_ibfk_1` FOREIGN KEY (`id_Mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_pemilih_ibfk_6` FOREIGN KEY (`id_acara`) REFERENCES `data_acara` (`id_acara`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_pemilih_ibfk_7` FOREIGN KEY (`Id_Paslon_Pilihan`) REFERENCES `data_paslon` (`id_Paslon`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `data_peserta`
--
ALTER TABLE `data_peserta`
  ADD CONSTRAINT `data_peserta_ibfk_1` FOREIGN KEY (`id_Mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_peserta_ibfk_2` FOREIGN KEY (`id_acara`) REFERENCES `data_acara` (`id_acara`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
