From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 26 Feb 2024 16:19:16 +0200
Subject: [PATCH v2 00/14] serial: Add a helper to parse device properties and more
Message-ID: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I have noticed that many drivers are using the subset of the common
properties and IRQ retrieval code. With the moving it to one place
we have got a common parser one for many.

Tested on Intel Apollo Lake with DesingWare 8250 UARTs (clang compiled)
and in QEMU for Aspeed configuration (gcc compiled). The rest has been
compile tested on x86_64 with clang.

In v2:
- fixed typo (Hugo)
- renamed UPIO_UNSET --> UPIO_UNKNOWN (Florian)
- fixed 8250_of not working (Andrew)
- dropped unused variable in 8250_bcm7271 (LKP)
- added tag to 8250_aspeed_vuart (Andrew)

Andy Shevchenko (14):
  serial: core: Move struct uart_port::quirks closer to possible values
  serial: core: Add UPIO_UNKNOWN constant for unknown port type
  serial: port: Introduce a common helper to read properties
  serial: 8250_aspeed_vuart: Switch to use uart_read_port_properties()
  serial: 8250_bcm2835aux: Switch to use uart_read_port_properties()
  serial: 8250_bcm7271: Switch to use uart_read_port_properties()
  serial: 8250_dw: Switch to use uart_read_port_properties()
  serial: 8250_ingenic: Switch to use uart_read_port_properties()
  serial: 8250_lpc18xx: Switch to use uart_read_port_properties()
  serial: 8250_of: Switch to use uart_read_port_properties()
  serial: 8250_omap: Switch to use uart_read_port_properties()
  serial: 8250_pxa: Switch to use uart_read_port_properties()
  serial: 8250_tegra: Switch to use uart_read_port_properties()
  serial: 8250_uniphier: Switch to use uart_read_port_properties()

 drivers/tty/serial/8250/8250_aspeed_vuart.c |  50 +++-----
 drivers/tty/serial/8250/8250_bcm2835aux.c   |  92 ++++++--------
 drivers/tty/serial/8250/8250_bcm7271.c      |  56 +++-----
 drivers/tty/serial/8250/8250_dw.c           |  67 ++++------
 drivers/tty/serial/8250/8250_ingenic.c      |  20 +--
 drivers/tty/serial/8250/8250_lpc18xx.c      |  20 ++-
 drivers/tty/serial/8250/8250_of.c           | 105 ++++-----------
 drivers/tty/serial/8250/8250_omap.c         |  29 ++---
 drivers/tty/serial/8250/8250_pxa.c          |  22 ++--
 drivers/tty/serial/8250/8250_tegra.c        |  26 ++--
 drivers/tty/serial/8250/8250_uniphier.c     |  17 +--
 drivers/tty/serial/serial_port.c            | 134 ++++++++++++++++++++
 include/linux/serial_core.h                 |  10 +-
 13 files changed, 313 insertions(+), 335 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096

