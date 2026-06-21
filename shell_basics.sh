#!/bin/bash

# Bu betik, Linux kabuğunun temel kavramlarını gösterir:
# ortam değişkenleri, yerel değişkenler, komut yürütme ve süreç kimlikleri (PID).

echo "--- Kabuk Temelleri Demosu ---"
# Mevcut betiğin çalıştığı kabuğun PID'si
echo "Mevcut Kabuk PID: $$"
# Bu betiği başlatan üst kabuğun PID'si
echo "Üst Kabuk PID: $PPID"

# 1. Yerel (Local) ve Ortam (Environment) Değişkenleri
# Yerel bir değişken, yalnızca mevcut kabuk/betik içinde erişilebilir.
LOCAL_VAR="Merhaba, ben yerel bir değişkenim!"
echo "LOCAL_VAR (mevcut kabuk): $LOCAL_VAR"

# Bir ortam değişkeni, alt süreçlere aktarılır (export edilir).
export ENV_VAR="Merhaba, ben bir ortam değişkeniyim!"
echo "ENV_VAR (mevcut kabuk): $ENV_VAR"

# 2. Fonksiyonlar ve Değişken Kapsamı
my_function() {
    echo -e "\n--- my_function içinde ---"
    # Yerel değişken fonksiyonda erişilebilir.
    echo "LOCAL_VAR (fonksiyon içinde): $LOCAL_VAR"
    # Ortam değişkeni fonksiyonda erişilebilir.
    echo "ENV_VAR (fonksiyon içinde): $ENV_VAR"
    # Fonksiyon, betiğin çalıştığı aynı PID'ye sahiptir.
    echo "Fonksiyonun PID'si: $$"
    echo "--- my_function sonu ---"
}

my_function

# 3. Alt Süreç (Subshell) ve Değişken Mirası
echo -e "\n--- Bir alt kabuk başlatılıyor ---"
echo "Değişkenlerin alt sürece nasıl miras kaldığını izleyin."

# 'bash -c' ile bir alt kabuk oluşturulur ve içinde komut çalıştırılır.
bash -c '
    echo "Alt Kabuk PID: $$"
    echo "Alt Kabuk Üst PID: $PPID"
    # LOCAL_VAR export edilmediği için alt kabukta boş olacaktır.
    echo "LOCAL_VAR (alt kabuk içinde): '$LOCAL_VAR'"
    # ENV_VAR export edildiği için alt kabukta mevcut olacaktır.
    echo "ENV_VAR (alt kabuk içinde): $ENV_VAR"
    echo "Alt kabuk çıkıyor."
'
echo "Alt kabuk tamamlandı."

# 4. Komut Yürütme Yolu (PATH)
echo -e "\n--- Komut Yürütme Yolu (PATH) ---"
echo "PATH değişkeni, kabuğa komutları nerede arayacağını söyler."
echo "Mevcut PATH: $PATH"

echo "'ls' komutunu bulalım:"
# 'which' komutu, bir komutun tam yolunu gösterir.
which ls

echo "'python3' komutunu bulalım:"
which python3 # (Yüklüyse tam yolunu gösterir)

echo -e "\n--- Demo Tamamlandı ---"