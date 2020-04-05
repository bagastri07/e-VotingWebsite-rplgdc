-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2020 at 11:12 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
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
-- Table structure for table `data_acara`
--

CREATE TABLE `data_acara` (
  `ID_Acara_Pemilu` char(10) NOT NULL,
  `Nama_Acara` varchar(30) NOT NULL,
  `Tanggal_Mulai` date NOT NULL,
  `Waktu_Mulai` time NOT NULL,
  `Tangga_Berakhir` date NOT NULL,
  `Waktu_Berakhir` time NOT NULL,
  `Tahun` year(4) NOT NULL,
  `id_Organisasi` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `data_acara`
--

INSERT INTO `data_acara` (`ID_Acara_Pemilu`, `Nama_Acara`, `Tanggal_Mulai`, `Waktu_Mulai`, `Tangga_Berakhir`, `Waktu_Berakhir`, `Tahun`, `id_Organisasi`) VALUES
('HMIF19', 'HMIF CHOICE 2019', '2020-06-10', '06:53:51', '2020-06-10', '23:53:51', 2019, 'HMIF');

-- --------------------------------------------------------

--
-- Table structure for table `data_admin`
--

CREATE TABLE `data_admin` (
  `id_Admin` char(10) NOT NULL,
  `username` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(15) NOT NULL,
  `id_mahasiswa` char(10) NOT NULL,
  `id_Acara` char(10) NOT NULL,
  `id_Organisasi` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `data_fakultas`
--

CREATE TABLE `data_fakultas` (
  `id_Fakultas` char(3) NOT NULL,
  `nama_Fakutas` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `data_fakultas`
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
-- Table structure for table `data_jurusan`
--

CREATE TABLE `data_jurusan` (
  `id_Jurusan` char(4) NOT NULL,
  `nama_Jurusan` varchar(30) NOT NULL,
  `id_Fakultas` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `data_jurusan`
--

INSERT INTO `data_jurusan` (`id_Jurusan`, `nama_Jurusan`, `id_Fakultas`) VALUES
('1104', 'S1 TEKNIK FISIKA', 'FTE'),
('1301', 'S1 INFORMATIKA', 'FIF'),
('1302', 'S1 TEKNOLOGI INFORMASI', 'FIF'),
('1303', 'S1 REKAYASA PERANGKAT LUNAK', 'FIF'),
('1601', 'S1 DESAIN KOMUNIKASI VISUAL', 'FEB');

-- --------------------------------------------------------

--
-- Table structure for table `data_mahasiswa`
--

CREATE TABLE `data_mahasiswa` (
  `id_Mahasiswa` char(10) NOT NULL,
  `nama_Mahasiswa` varchar(30) NOT NULL,
  `jenis_Kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `angkatan` varchar(4) NOT NULL,
  `id_Jurusan` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `data_mahasiswa`
--

INSERT INTO `data_mahasiswa` (`id_Mahasiswa`, `nama_Mahasiswa`, `jenis_Kelamin`, `angkatan`, `id_Jurusan`) VALUES
('1301194003', 'Layli Rahmah Sulistyaningtyas', 'Perempuan', '2019', '1301'),
('1301194051', 'Bagas Tri Wibowo', 'Laki-laki', '2019', '1301'),
('1301194059', 'Bagus Dwi Prakarsa', 'Laki-laki', '2019', '1301'),
('1302194003', 'Putri Wulandari', 'Perempuan', '2019', '1302'),
('1601164267', 'Emir Maulana', 'Laki-laki', '2016', '1601');

-- --------------------------------------------------------

--
-- Table structure for table `data_organisasi`
--

CREATE TABLE `data_organisasi` (
  `id_Organisasi` char(5) NOT NULL,
  `nama` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `data_organisasi`
--

INSERT INTO `data_organisasi` (`id_Organisasi`, `nama`) VALUES
('HMIF', 'HIMA INFORMATIKA'),
('HMTF', 'HIMA TEKNIK FISKA');

-- --------------------------------------------------------

--
-- Table structure for table `data_panitia`
--

CREATE TABLE `data_panitia` (
  `id_Panitia` char(10) NOT NULL,
  `id_Mahasiswa` char(10) NOT NULL,
  `username` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(15) NOT NULL,
  `id_Acara` char(10) NOT NULL,
  `id_Organisasi` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `data_paslon`
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
-- Table structure for table `data_pemilih`
--

CREATE TABLE `data_pemilih` (
  `id_Pemilih` int(4) NOT NULL,
  `id_Token` char(5) NOT NULL,
  `id_Mahasiswa` char(10) NOT NULL,
  `Id_Paslon_Pilihan` char(10) DEFAULT NULL,
  `id_nama_Acara_Pemilu` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `data_pemilih`
--

INSERT INTO `data_pemilih` (`id_Pemilih`, `id_Token`, `id_Mahasiswa`, `Id_Paslon_Pilihan`, `id_nama_Acara_Pemilu`) VALUES
(2, 'A5432', '1301194003', NULL, 'HMIF19'),
(3, 'Agje2', '1301194051', NULL, 'HMIF19');

-- --------------------------------------------------------

--
-- Table structure for table `data_peserta`
--

CREATE TABLE `data_peserta` (
  `id_Peserta` char(10) NOT NULL,
  `id_Mahasiswa` char(10) NOT NULL,
  `id_Acara` char(10) NOT NULL,
  `jabatan_paslon` enum('ketua','wakil ketua') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `data_superadmin`
--

CREATE TABLE `data_superadmin` (
  `id_SuperAdmin` char(10) NOT NULL,
  `username` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(15) NOT NULL,
  `id_Mahasiswa` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `data_token`
--

CREATE TABLE `data_token` (
  `id_Token` char(5) NOT NULL,
  `Token` varchar(5) NOT NULL,
  `Status` enum('Valid','Expired') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `data_token`
--

INSERT INTO `data_token` (`id_Token`, `Token`, `Status`) VALUES
('A5432', 'xyZ3P', 'Valid'),
('Agje2', 'pOLr3', 'Valid');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_acara`
--
ALTER TABLE `data_acara`
  ADD PRIMARY KEY (`ID_Acara_Pemilu`),
  ADD KEY `id_Organisasi` (`id_Organisasi`);

--
-- Indexes for table `data_admin`
--
ALTER TABLE `data_admin`
  ADD PRIMARY KEY (`id_Admin`),
  ADD UNIQUE KEY `id_Acara` (`id_Acara`),
  ADD KEY `id_mahasiswa` (`id_mahasiswa`),
  ADD KEY `id_Organisasi` (`id_Organisasi`);

--
-- Indexes for table `data_fakultas`
--
ALTER TABLE `data_fakultas`
  ADD PRIMARY KEY (`id_Fakultas`);

--
-- Indexes for table `data_jurusan`
--
ALTER TABLE `data_jurusan`
  ADD PRIMARY KEY (`id_Jurusan`),
  ADD KEY `Fakultas` (`id_Fakultas`);

--
-- Indexes for table `data_mahasiswa`
--
ALTER TABLE `data_mahasiswa`
  ADD PRIMARY KEY (`id_Mahasiswa`),
  ADD KEY `Jurusan` (`id_Jurusan`);

--
-- Indexes for table `data_organisasi`
--
ALTER TABLE `data_organisasi`
  ADD PRIMARY KEY (`id_Organisasi`);

--
-- Indexes for table `data_panitia`
--
ALTER TABLE `data_panitia`
  ADD PRIMARY KEY (`id_Panitia`),
  ADD UNIQUE KEY `id_Acara` (`id_Acara`),
  ADD KEY `id_Mahasiswa` (`id_Mahasiswa`),
  ADD KEY `id_Organisasi` (`id_Organisasi`);

--
-- Indexes for table `data_paslon`
--
ALTER TABLE `data_paslon`
  ADD PRIMARY KEY (`id_Paslon`),
  ADD UNIQUE KEY `id_Wakil` (`id_Wakil`),
  ADD KEY `ID_Acara_Pemilu` (`ID_Acara_Pemilu`),
  ADD KEY `id_Mahasiswa-NIM` (`id_Ketua`);

--
-- Indexes for table `data_pemilih`
--
ALTER TABLE `data_pemilih`
  ADD PRIMARY KEY (`id_Pemilih`),
  ADD KEY `id_nama_Acara_Pemilu` (`id_nama_Acara_Pemilu`),
  ADD KEY `id_Mahasiswa` (`id_Mahasiswa`),
  ADD KEY `id_Token` (`id_Token`),
  ADD KEY `Id_Paslon_Pilihan` (`Id_Paslon_Pilihan`);

--
-- Indexes for table `data_peserta`
--
ALTER TABLE `data_peserta`
  ADD PRIMARY KEY (`id_Peserta`),
  ADD KEY `id_Mahasiswa` (`id_Mahasiswa`,`id_Acara`),
  ADD KEY `id_Acara` (`id_Acara`);

--
-- Indexes for table `data_superadmin`
--
ALTER TABLE `data_superadmin`
  ADD PRIMARY KEY (`id_SuperAdmin`),
  ADD KEY `id_Mahasiswa` (`id_Mahasiswa`);

--
-- Indexes for table `data_token`
--
ALTER TABLE `data_token`
  ADD PRIMARY KEY (`id_Token`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_pemilih`
--
ALTER TABLE `data_pemilih`
  MODIFY `id_Pemilih` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `data_acara`
--
ALTER TABLE `data_acara`
  ADD CONSTRAINT `data_acara_ibfk_1` FOREIGN KEY (`id_Organisasi`) REFERENCES `data_organisasi` (`id_Organisasi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `data_admin`
--
ALTER TABLE `data_admin`
  ADD CONSTRAINT `data_admin_ibfk_1` FOREIGN KEY (`id_mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_admin_ibfk_2` FOREIGN KEY (`id_Acara`) REFERENCES `data_acara` (`ID_Acara_Pemilu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_admin_ibfk_3` FOREIGN KEY (`id_Organisasi`) REFERENCES `data_organisasi` (`id_Organisasi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `data_jurusan`
--
ALTER TABLE `data_jurusan`
  ADD CONSTRAINT `data_jurusan_ibfk_1` FOREIGN KEY (`id_Fakultas`) REFERENCES `data_fakultas` (`id_Fakultas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `data_mahasiswa`
--
ALTER TABLE `data_mahasiswa`
  ADD CONSTRAINT `data_mahasiswa_ibfk_1` FOREIGN KEY (`id_Jurusan`) REFERENCES `data_jurusan` (`id_Jurusan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `data_panitia`
--
ALTER TABLE `data_panitia`
  ADD CONSTRAINT `data_panitia_ibfk_1` FOREIGN KEY (`id_Mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_panitia_ibfk_2` FOREIGN KEY (`id_Acara`) REFERENCES `data_acara` (`ID_Acara_Pemilu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_panitia_ibfk_3` FOREIGN KEY (`id_Organisasi`) REFERENCES `data_organisasi` (`id_Organisasi`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `data_paslon`
--
ALTER TABLE `data_paslon`
  ADD CONSTRAINT `data_paslon_ibfk_3` FOREIGN KEY (`ID_Acara_Pemilu`) REFERENCES `data_acara` (`ID_Acara_Pemilu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_paslon_ibfk_4` FOREIGN KEY (`id_Ketua`) REFERENCES `data_peserta` (`id_Peserta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_paslon_ibfk_5` FOREIGN KEY (`id_Wakil`) REFERENCES `data_peserta` (`id_Peserta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `data_pemilih`
--
ALTER TABLE `data_pemilih`
  ADD CONSTRAINT `data_pemilih_ibfk_1` FOREIGN KEY (`id_Mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_pemilih_ibfk_3` FOREIGN KEY (`id_nama_Acara_Pemilu`) REFERENCES `data_acara` (`ID_Acara_Pemilu`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_pemilih_ibfk_4` FOREIGN KEY (`id_Token`) REFERENCES `data_token` (`id_Token`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_pemilih_ibfk_5` FOREIGN KEY (`Id_Paslon_Pilihan`) REFERENCES `data_peserta` (`id_Peserta`) ON DELETE CASCADE ON UPDATE SET NULL;

--
-- Constraints for table `data_peserta`
--
ALTER TABLE `data_peserta`
  ADD CONSTRAINT `data_peserta_ibfk_1` FOREIGN KEY (`id_Mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `data_peserta_ibfk_2` FOREIGN KEY (`id_Acara`) REFERENCES `data_acara` (`ID_Acara_Pemilu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `data_superadmin`
--
ALTER TABLE `data_superadmin`
  ADD CONSTRAINT `data_superadmin_ibfk_1` FOREIGN KEY (`id_Mahasiswa`) REFERENCES `data_mahasiswa` (`id_Mahasiswa`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
