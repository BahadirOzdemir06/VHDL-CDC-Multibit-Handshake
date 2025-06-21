# VHDL Çok Bitli Clock Domain Crossing (CDC) - Handshake Yöntemi

## Proje Özeti / Project Summary

Bu tasarım, farklı saat bölgeleri arasında çok bitli veri transferini güvenli şekilde gerçekleştirmek için el sıkışma (handshake) tabanlı bir **Clock Domain Crossing (CDC)** yapısı uygular.

This design implements a **Clock Domain Crossing (CDC)** mechanism based on handshake logic to safely transfer multi-bit data between different clock domains.

---

## Açıklama (Türkçe)

Bu VHDL modülü, iki farklı saat bölgesi (clock domain) arasında çok bitli veri (`data_in`) iletimini güvenli biçimde gerçekleştirmek için çift yönlü senkronizasyon (el sıkışma) yöntemini kullanır.

Tasarım, metastability riskini azaltmak için senkron flip-flop zinciri ve `request/acknowledge` kontrol işaretlerini içerir. `clk_in` ve `clk_out` arasında veri bütünlüğü korunarak geçiş sağlanır.

### Özellikler

- Çok bitli veri transferi (parametrik genişlik)
- Saat bölgeleri arası senkronizasyon
- Handshake (el sıkışma) temelli kontrol
- Glitch-free ve metastability azaltılmış yapı

### Portlar

| Port              | Yön     | Açıklama                                        |
|-------------------|---------|-------------------------------------------------|
| clk_in            | in      | Kaynak saat bölgesi                            |
| clk_out           | in      | Hedef saat bölgesi                             |
| rst_n             | in      | Asenkron reset (aktif düşük)                   |
| data_in           | in      | Gönderilecek veri (DATA_WIDTH bit)            |
| data_out          | out     | Alınan veri                                    |
| request_in        | in      | Gönderme isteği                                |
| acknowledge_out   | out     | Hedef taraftan gelen onay (clk_out domain)     |
| acknowledge_in    | out     | Senkronize onay (clk_in domainine geri aktarım)|

### Nasıl Kullanılır

1. `cdc_multibit_handshake.vhd` dosyasını projenize ekleyin.
2. Giriş ve çıkış saat sinyallerini bağlayın (`clk_in`, `clk_out`).
3. `request_in` sinyali ile veri transferini tetikleyin.
4. `acknowledge_in` sinyali üzerinden işlemin tamamlandığını izleyin.
5. `DATA_WIDTH` parametresi ile veri genişliğini özelleştirin.

---

## Description (English)

This VHDL module transfers multi-bit data (`data_in`) safely between two different clock domains (`clk_in` and `clk_out`) using a handshake-based protocol.

The design reduces the risk of metastability by utilizing double-flip-flop synchronizers and handshake control signals (`request`, `acknowledge`). This ensures reliable and glitch-free CDC for FPGA or ASIC designs.

### Features

- Multi-bit data transfer (parameterizable width)
- Clock domain synchronization
- Handshake-based control logic
- Metastability mitigation using double flip-flops

### Ports

| Port              | Direction | Description                                      |
|-------------------|-----------|--------------------------------------------------|
| clk_in            | in        | Source clock domain                              |
| clk_out           | in        | Destination clock domain                         |
| rst_n             | in        | Asynchronous reset (active low)                  |
| data_in           | in        | Data to be transferred (DATA_WIDTH bits)         |
| data_out          | out       | Received data                                    |
| request_in        | in        | Transfer request signal                          |
| acknowledge_out   | out       | Acknowledge signal from destination (clk_out)    |
| acknowledge_in    | out       | Synchronized acknowledge (to clk_in domain)      |

### How to Use

1. Add `cdc_multibit_handshake.vhd` to your project.
2. Connect `clk_in` and `clk_out` to your respective clock domains.
3. Trigger data transfer using `request_in`.
4. Wait for `acknowledge_in` to confirm data reception.
5. Adjust `DATA_WIDTH` if needed for your application.



