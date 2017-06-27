From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 27 Jun 2017 11:42:12 +0930
Subject: [PATCH 2/4] ARM: aspeed: g5: Add USB functions to pinctrl bindings
In-Reply-To: <20170627021214.23323-1-andrew@aj.id.au>
References: <20170627021214.23323-1-andrew@aj.id.au>
Message-ID: <20170627021214.23323-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Aspeed AST2500 SoC contains a number of USB controllers:

* USB 1.1 Host Controller
* USB 2.0 Host Controller (x2)
* Combined USB 2.0 Virtual Hub and USB 1.1 HID Controller

The controllers are exposed via two USB ports with functionality muxed
as required. The following table illustrates the relationships between
the ports and the controllers via the mux function names:

Port  | USB Version  | USB Mode     | Mux Function
------|--------------|--------------|-------------
A     | 2.0          | Virtual Hub  | USB2AD
A     | 2.0          | Host         | USB2AH
B     | 1.1          | HID          | USB11BHID
B     | 2.0          | Device       | USB2BD
B     | 2.0          | Host         | USB2BH

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
index 09142dab47db..3b7266c7c438 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
@@ -87,7 +87,8 @@ SALT11 SALT12 SALT13 SALT14 SALT2 SALT3 SALT4 SALT5 SALT6 SALT7 SALT8 SALT9
 SCL1 SCL2 SD1 SD2 SDA1 SDA2 SGPS1 SGPS2 SIOONCTRL SIOPBI SIOPBO SIOPWREQ
 SIOPWRGD SIOS3 SIOS5 SIOSCI SPI1 SPI1CS1 SPI1DEBUG SPI1PASSTHRU SPI2CK SPI2CS0
 SPI2CS1 SPI2MISO SPI2MOSI TIMER3 TIMER4 TIMER5 TIMER6 TIMER7 TIMER8 TXD1 TXD2
-TXD3 TXD4 UART6 USBCKI VGABIOSROM VGAHS VGAVS VPI24 VPO WDTRST1 WDTRST2
+TXD3 TXD4 UART6 USB11BHID USB2AD USB2AH USB2BD USB2BH USBCKI VGABIOSROM VGAHS
+VGAVS VPI24 VPO WDTRST1 WDTRST2
 
 Examples
 ========
-- 
2.11.0

