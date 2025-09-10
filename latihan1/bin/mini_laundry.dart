import 'dart:io';

class Laundry {
  int cuciSetrika;
  int cuci;
  int setrika;

  Laundry(this.cuciSetrika, this.cuci, this.setrika);

  int hitungTotal() {
    return (cuciSetrika * 6000) + (cuci * 4000) + (setrika * 3000);
  }

  double hitungDiskon(int total) {
    if (total >= 100000) {
      return 0.10;
    } else if (total >= 50000) {
      return 0.05;
    }
    return 0;
  }

  double totalBayar() {
    int total = hitungTotal();
    double diskon = hitungDiskon(total);
    return total - (total * diskon);
  }

  void tampilkanRincian() {
    int total = hitungTotal();
    double diskon = hitungDiskon(total);

    print("\n===== Rincian Laundry =====");
    print("Total sebelum diskon: Rp$total");
    print("Diskon: ${diskon * 100}%");
    print("Total yang harus dibayar: Rp${totalBayar().toInt()}");
  }
}

void main() {
  stdout.write("Masukkan jumlah kg Paket Cuci + Setrika: ");
  int paketCuciSetrika = int.parse(stdin.readLineSync()!);

  stdout.write("Masukkan jumlah kg Paket Cuci: ");
  int paketCuci = int.parse(stdin.readLineSync()!);

  stdout.write("Masukkan jumlah kg Paket Setrika: ");
  int paketSetrika = int.parse(stdin.readLineSync()!);

  // Buat object Laundry
  Laundry laundry = Laundry(paketCuciSetrika, paketCuci, paketSetrika);
  laundry.tampilkanRincian();
}
