From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Sat, 11 Jun 2022 12:58:24 +0300
Subject: [PATCH 0/4] DTS changes for the AMD EthanolX CRB BMC
Message-ID: <20220611095828.1090-1-aladyshev22@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several patches for the DTS of the BMC on the AMD EthanolX CRB.

Konstantin Aladyshev (4):
  ARM: dts: aspeed: ethanolx: Add correct label to flash device
  ARM: dts: aspeed: ethanolx: Configure RTS/CTS for UART1
  ARM: dts: aspeed: ethanolx: Use correct driver for the FRU EEPROM
  ARM: dts: aspeed: ethanolx: Enable VUART

 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.25.1

