From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Fri, 10 Nov 2023 16:29:28 +0100
Subject: [PATCH 00/52] serial: Convert to platform remove callback returning void
Message-ID: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

this series starts with two fixes. The first one fixes a resource leak
and use after free. The second only improves error reporting. I added a
Fixes: marker to these. I let you decide if you want to drop them (or
the second only) or add a Cc: stable (to both or only the first one).

After that all drivers below drivers/tty/serial are converted to struct
platform_driver::remove_new. See commit 5c5a7680e67b ("platform: Provide
a remove callback that returns no value") for an extended explanation
and the eventual goal. The TL;DR; is to prevent bugs like the two fixed
here.

After these two fixes all conversations are trivial, because all
.remove() callbacks returned zero unconditionally.

The conversion patches are merge window material. The two fixes might go
in also before v6.7, but given the fixed problems are already old
(v6.1-rc6 + v3.10-rc1) there is probably no urge.

Best regards
Uwe

Uwe Kleine-K?nig (52):
  serial: 8250: omap: Don't skip resource freeing if
    pm_runtime_resume_and_get() failed
  serial: sccnxp: Improve error message if regulator_disable() fails
  serial: 8250: Convert to platform remove callback returning void
  serial: altera_jtaguart: Convert to platform remove callback returning
    void
  serial: altera: Convert to platform remove callback returning void
  serial: amba-pl011: Convert to platform remove callback returning void
  serial: ar933x: Convert to platform remove callback returning void
  serial: atmel: Convert to platform remove callback returning void
  serial: bcm63xx: Convert to platform remove callback returning void
  serial: clps711x: Convert to platform remove callback returning void
  serial: cpm: Convert to platform remove callback returning void
  serial: digicolor: Convert to platform remove callback returning void
  serial: esp32_acm: Convert to platform remove callback returning void
  serial: esp32: Convert to platform remove callback returning void
  serial: fsl_linflexuart: Convert to platform remove callback returning
    void
  serial: fsl_lpuart: Convert to platform remove callback returning void
  serial: imx: Convert to platform remove callback returning void
  serial: lantiq: Convert to platform remove callback returning void
  serial: liteuart: Convert to platform remove callback returning void
  serial: lpc32xx_hs: Convert to platform remove callback returning void
  serial: ma35d1: Convert to platform remove callback returning void
  serial: mcf: Convert to platform remove callback returning void
  serial: meson: Convert to platform remove callback returning void
  serial: milbeaut_usio: Convert to platform remove callback returning
    void
  serial: mpc52xx: Convert to platform remove callback returning void
  serial: msm: Convert to platform remove callback returning void
  serial: mxs-auart: Convert to platform remove callback returning void
  serial: omap: Convert to platform remove callback returning void
  serial: owl: Convert to platform remove callback returning void
  serial: pic32: Convert to platform remove callback returning void
  serial: qcom_geni: Convert to platform remove callback returning void
  serial: rda: Convert to platform remove callback returning void
  serial: sa1100: Convert to platform remove callback returning void
  serial: samsung: Convert to platform remove callback returning void
  serial: sccnxp: Convert to platform remove callback returning void
  serial: tegra: Convert to platform remove callback returning void
  serial: txx9: Convert to platform remove callback returning void
  serial: sh-sci: Convert to platform remove callback returning void
  serial: sifive: Convert to platform remove callback returning void
  serial: sprd: Convert to platform remove callback returning void
  serial: st-asc: Convert to platform remove callback returning void
  serial: stm32: Convert to platform remove callback returning void
  serial: sunhv: Convert to platform remove callback returning void
  serial: sunplus: Convert to platform remove callback returning void
  serial: sunsab: Convert to platform remove callback returning void
  serial: sunsu: Convert to platform remove callback returning void
  serial: sunzilog: Convert to platform remove callback returning void
  serial: tegra-tcu: Convert to platform remove callback returning void
  serial: timbuart: Convert to platform remove callback returning void
  serial: uartlite: Convert to platform remove callback returning void
  serial: ucc: Convert to platform remove callback returning void
  serial: xilinx_uartps: Convert to platform remove callback returning
    void

 drivers/tty/serial/8250/8250_aspeed_vuart.c |  6 ++----
 drivers/tty/serial/8250/8250_bcm2835aux.c   |  6 ++----
 drivers/tty/serial/8250/8250_bcm7271.c      |  5 ++---
 drivers/tty/serial/8250/8250_core.c         |  5 ++---
 drivers/tty/serial/8250/8250_dw.c           |  6 ++----
 drivers/tty/serial/8250/8250_em.c           |  5 ++---
 drivers/tty/serial/8250/8250_fsl.c          |  5 ++---
 drivers/tty/serial/8250/8250_ingenic.c      |  5 ++---
 drivers/tty/serial/8250/8250_ioc3.c         |  5 ++---
 drivers/tty/serial/8250/8250_lpc18xx.c      |  6 ++----
 drivers/tty/serial/8250/8250_mtk.c          |  6 ++----
 drivers/tty/serial/8250/8250_of.c           |  5 ++---
 drivers/tty/serial/8250/8250_omap.c         |  7 +++----
 drivers/tty/serial/8250/8250_pxa.c          |  6 ++----
 drivers/tty/serial/8250/8250_tegra.c        |  6 ++----
 drivers/tty/serial/8250/8250_uniphier.c     |  6 ++----
 drivers/tty/serial/altera_jtaguart.c        |  6 ++----
 drivers/tty/serial/altera_uart.c            |  6 ++----
 drivers/tty/serial/amba-pl011.c             |  5 ++---
 drivers/tty/serial/ar933x_uart.c            |  6 ++----
 drivers/tty/serial/atmel_serial.c           |  6 ++----
 drivers/tty/serial/bcm63xx_uart.c           |  5 ++---
 drivers/tty/serial/clps711x.c               |  6 ++----
 drivers/tty/serial/cpm_uart.c               |  6 ++----
 drivers/tty/serial/digicolor-usart.c        |  6 ++----
 drivers/tty/serial/esp32_acm.c              |  5 ++---
 drivers/tty/serial/esp32_uart.c             |  6 ++----
 drivers/tty/serial/fsl_linflexuart.c        |  6 ++----
 drivers/tty/serial/fsl_lpuart.c             |  5 ++---
 drivers/tty/serial/imx.c                    |  6 ++----
 drivers/tty/serial/lantiq.c                 |  6 ++----
 drivers/tty/serial/liteuart.c               |  6 ++----
 drivers/tty/serial/lpc32xx_hs.c             |  6 ++----
 drivers/tty/serial/ma35d1_serial.c          |  5 ++---
 drivers/tty/serial/mcf.c                    |  6 ++----
 drivers/tty/serial/meson_uart.c             |  8 +++-----
 drivers/tty/serial/milbeaut_usio.c          |  6 ++----
 drivers/tty/serial/mpc52xx_uart.c           |  7 ++-----
 drivers/tty/serial/msm_serial.c             |  6 ++----
 drivers/tty/serial/mxs-auart.c              |  6 ++----
 drivers/tty/serial/omap-serial.c            |  6 ++----
 drivers/tty/serial/owl-uart.c               |  6 ++----
 drivers/tty/serial/pic32_uart.c             |  7 ++-----
 drivers/tty/serial/qcom_geni_serial.c       |  6 ++----
 drivers/tty/serial/rda-uart.c               |  6 ++----
 drivers/tty/serial/sa1100.c                 |  6 ++----
 drivers/tty/serial/samsung_tty.c            |  6 ++----
 drivers/tty/serial/sccnxp.c                 | 13 +++++++------
 drivers/tty/serial/serial-tegra.c           |  5 ++---
 drivers/tty/serial/serial_txx9.c            |  5 ++---
 drivers/tty/serial/sh-sci.c                 |  6 ++----
 drivers/tty/serial/sifive.c                 |  6 ++----
 drivers/tty/serial/sprd_serial.c            |  6 ++----
 drivers/tty/serial/st-asc.c                 |  6 ++----
 drivers/tty/serial/stm32-usart.c            |  6 ++----
 drivers/tty/serial/sunhv.c                  |  6 ++----
 drivers/tty/serial/sunplus-uart.c           |  6 ++----
 drivers/tty/serial/sunsab.c                 |  6 ++----
 drivers/tty/serial/sunsu.c                  |  6 ++----
 drivers/tty/serial/sunzilog.c               |  6 ++----
 drivers/tty/serial/tegra-tcu.c              |  6 ++----
 drivers/tty/serial/timbuart.c               |  6 ++----
 drivers/tty/serial/uartlite.c               |  5 ++---
 drivers/tty/serial/ucc_uart.c               |  6 ++----
 drivers/tty/serial/xilinx_uartps.c          |  5 ++---
 65 files changed, 137 insertions(+), 249 deletions(-)


base-commit: 8728c14129df7a6e29188a2e737b4774fb200953
-- 
2.42.0

