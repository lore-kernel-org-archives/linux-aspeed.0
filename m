From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Date: Fri, 15 Sep 2023 12:12:58 +0300 (EEST)
Subject: [PATCH tty v1 00/74] serial: wrappers for uart port lock
In-Reply-To: <20230914183831.587273-1-john.ogness@linutronix.de>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
Message-ID: <1446dc6-5ab0-629-45c8-3b7d8c76367d@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 14 Sep 2023, John Ogness wrote:

> When a serial port is used for kernel console output, then all
> modifications to the UART registers which are done from other contexts,
> e.g. getty, termios, are interference points for the kernel console.
> 
> So far this has been ignored and the printk output is based on the
> principle of hope. The rework of the console infrastructure which aims to
> support threaded and atomic consoles, requires to mark sections which
> modify the UART registers as unsafe. This allows the atomic write function
> to make informed decisions and eventually to restore operational state. It
> also allows to prevent the regular UART code from modifying UART registers
> while printk output is in progress.

Hi John,

Would this also be useful to enable printing to console while under port's 
lock (by postponing the output until the lock is released)?

E.g., 8250_dw.c has had this commented out since the dawn on time:
        /*
         * FIXME: this deadlocks if port->lock is already held
         * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
         */

-- 
 i.


> All modifications of UART registers are guarded by the UART port lock,
> which provides an obvious synchronization point with the console
> infrastructure.
> 
> Provide and use wrapper functions for spin_[un]lock*(port->lock)
> invocations so that the console mechanics can be applied later on at a
> single place and does not require to copy the same logic all over the
> drivers.
> 
> Patch 1 adds the wrapper functions.
> 
> Patches 2-74 switch all uart port locking call sites to use the new
> wrappers. These patches were automatically generated using coccinelle.
> The 2 used coccinelle scripts are included below and executed as
> follows:
> 
> $ spatch --sp-file uartlock-1.cocci $FILE
> $ spatch --sp-file uartlock-2.cocci --recursive-includes $FILE
> 
> This series brings no functional change.
> 
> Patches 2-74 contain identical commit message bodies. Feel free to
> fold them into a single commit if that seems more reasonable.
> 
> Thomas Gleixner (74):
>   serial: core: Provide port lock wrappers
>   serial: core: Use lock wrappers
>   serial: 21285: Use port lock wrappers
>   serial: 8250_aspeed_vuart: Use port lock wrappers
>   serial: 8250_bcm7271: Use port lock wrappers
>   serial: 8250: Use port lock wrappers
>   serial: 8250_dma: Use port lock wrappers
>   serial: 8250_dw: Use port lock wrappers
>   serial: 8250_exar: Use port lock wrappers
>   serial: 8250_fsl: Use port lock wrappers
>   serial: 8250_mtk: Use port lock wrappers
>   serial: 8250_omap: Use port lock wrappers
>   serial: 8250_pci1xxxx: Use port lock wrappers
>   serial: altera_jtaguart: Use port lock wrappers
>   serial: altera_uart: Use port lock wrappers
>   serial: amba-pl010: Use port lock wrappers
>   serial: amba-pl011: Use port lock wrappers
>   serial: apb: Use port lock wrappers
>   serial: ar933x: Use port lock wrappers
>   serial: arc_uart: Use port lock wrappers
>   serial: atmel: Use port lock wrappers
>   serial: bcm63xx-uart: Use port lock wrappers
>   serial: cpm_uart: Use port lock wrappers
>   serial: digicolor: Use port lock wrappers
>   serial: dz: Use port lock wrappers
>   serial: linflexuart: Use port lock wrappers
>   serial: fsl_lpuart: Use port lock wrappers
>   serial: icom: Use port lock wrappers
>   serial: imx: Use port lock wrappers
>   serial: ip22zilog: Use port lock wrappers
>   serial: jsm: Use port lock wrappers
>   serial: liteuart: Use port lock wrappers
>   serial: lpc32xx_hs: Use port lock wrappers
>   serial: ma35d1: Use port lock wrappers
>   serial: mcf: Use port lock wrappers
>   serial: men_z135_uart: Use port lock wrappers
>   serial: meson: Use port lock wrappers
>   serial: milbeaut_usio: Use port lock wrappers
>   serial: mpc52xx: Use port lock wrappers
>   serial: mps2-uart: Use port lock wrappers
>   serial: msm: Use port lock wrappers
>   serial: mvebu-uart: Use port lock wrappers
>   serial: omap: Use port lock wrappers
>   serial: owl: Use port lock wrappers
>   serial: pch: Use port lock wrappers
>   serial: pic32: Use port lock wrappers
>   serial: pmac_zilog: Use port lock wrappers
>   serial: pxa: Use port lock wrappers
>   serial: qcom-geni: Use port lock wrappers
>   serial: rda: Use port lock wrappers
>   serial: rp2: Use port lock wrappers
>   serial: sa1100: Use port lock wrappers
>   serial: samsung_tty: Use port lock wrappers
>   serial: sb1250-duart: Use port lock wrappers
>   serial: sc16is7xx: Use port lock wrappers
>   serial: tegra: Use port lock wrappers
>   serial: core: Use port lock wrappers
>   serial: mctrl_gpio: Use port lock wrappers
>   serial: txx9: Use port lock wrappers
>   serial: sh-sci: Use port lock wrappers
>   serial: sifive: Use port lock wrappers
>   serial: sprd: Use port lock wrappers
>   serial: st-asc: Use port lock wrappers
>   serial: stm32: Use port lock wrappers
>   serial: sunhv: Use port lock wrappers
>   serial: sunplus-uart: Use port lock wrappers
>   serial: sunsab: Use port lock wrappers
>   serial: sunsu: Use port lock wrappers
>   serial: sunzilog: Use port lock wrappers
>   serial: timbuart: Use port lock wrappers
>   serial: uartlite: Use port lock wrappers
>   serial: ucc_uart: Use port lock wrappers
>   serial: vt8500: Use port lock wrappers
>   serial: xilinx_uartps: Use port lock wrappers
> 
>  drivers/tty/serial/21285.c                  |   8 +-
>  drivers/tty/serial/8250/8250_aspeed_vuart.c |   6 +-
>  drivers/tty/serial/8250/8250_bcm7271.c      |  28 +++---
>  drivers/tty/serial/8250/8250_core.c         |  12 +--
>  drivers/tty/serial/8250/8250_dma.c          |   8 +-
>  drivers/tty/serial/8250/8250_dw.c           |   8 +-
>  drivers/tty/serial/8250/8250_exar.c         |   4 +-
>  drivers/tty/serial/8250/8250_fsl.c          |   6 +-
>  drivers/tty/serial/8250/8250_mtk.c          |   8 +-
>  drivers/tty/serial/8250/8250_omap.c         |  52 +++++-----
>  drivers/tty/serial/8250/8250_pci1xxxx.c     |   8 +-
>  drivers/tty/serial/8250/8250_port.c         | 100 ++++++++++----------
>  drivers/tty/serial/altera_jtaguart.c        |  28 +++---
>  drivers/tty/serial/altera_uart.c            |  20 ++--
>  drivers/tty/serial/amba-pl010.c             |  20 ++--
>  drivers/tty/serial/amba-pl011.c             |  72 +++++++-------
>  drivers/tty/serial/apbuart.c                |   8 +-
>  drivers/tty/serial/ar933x_uart.c            |  26 ++---
>  drivers/tty/serial/arc_uart.c               |  16 ++--
>  drivers/tty/serial/atmel_serial.c           |  24 ++---
>  drivers/tty/serial/bcm63xx_uart.c           |  22 ++---
>  drivers/tty/serial/cpm_uart.c               |   8 +-
>  drivers/tty/serial/digicolor-usart.c        |  18 ++--
>  drivers/tty/serial/dz.c                     |  32 +++----
>  drivers/tty/serial/fsl_linflexuart.c        |  26 ++---
>  drivers/tty/serial/fsl_lpuart.c             |  88 ++++++++---------
>  drivers/tty/serial/icom.c                   |  26 ++---
>  drivers/tty/serial/imx.c                    |  84 ++++++++--------
>  drivers/tty/serial/ip22zilog.c              |  36 +++----
>  drivers/tty/serial/jsm/jsm_neo.c            |   4 +-
>  drivers/tty/serial/jsm/jsm_tty.c            |  16 ++--
>  drivers/tty/serial/liteuart.c               |  20 ++--
>  drivers/tty/serial/lpc32xx_hs.c             |  26 ++---
>  drivers/tty/serial/ma35d1_serial.c          |  22 ++---
>  drivers/tty/serial/mcf.c                    |  20 ++--
>  drivers/tty/serial/men_z135_uart.c          |   8 +-
>  drivers/tty/serial/meson_uart.c             |  30 +++---
>  drivers/tty/serial/milbeaut_usio.c          |  16 ++--
>  drivers/tty/serial/mpc52xx_uart.c           |  12 +--
>  drivers/tty/serial/mps2-uart.c              |  16 ++--
>  drivers/tty/serial/msm_serial.c             |  38 ++++----
>  drivers/tty/serial/mvebu-uart.c             |  18 ++--
>  drivers/tty/serial/omap-serial.c            |  38 ++++----
>  drivers/tty/serial/owl-uart.c               |  26 ++---
>  drivers/tty/serial/pch_uart.c               |  10 +-
>  drivers/tty/serial/pic32_uart.c             |  20 ++--
>  drivers/tty/serial/pmac_zilog.c             |  52 +++++-----
>  drivers/tty/serial/pxa.c                    |  30 +++---
>  drivers/tty/serial/qcom_geni_serial.c       |   8 +-
>  drivers/tty/serial/rda-uart.c               |  34 +++----
>  drivers/tty/serial/rp2.c                    |  20 ++--
>  drivers/tty/serial/sa1100.c                 |  20 ++--
>  drivers/tty/serial/samsung_tty.c            |  50 +++++-----
>  drivers/tty/serial/sb1250-duart.c           |  12 +--
>  drivers/tty/serial/sc16is7xx.c              |  40 ++++----
>  drivers/tty/serial/serial-tegra.c           |  32 +++----
>  drivers/tty/serial/serial_core.c            |  88 ++++++++---------
>  drivers/tty/serial/serial_mctrl_gpio.c      |   4 +-
>  drivers/tty/serial/serial_port.c            |   4 +-
>  drivers/tty/serial/serial_txx9.c            |  26 ++---
>  drivers/tty/serial/sh-sci.c                 |  68 ++++++-------
>  drivers/tty/serial/sifive.c                 |  16 ++--
>  drivers/tty/serial/sprd_serial.c            |  30 +++---
>  drivers/tty/serial/st-asc.c                 |  18 ++--
>  drivers/tty/serial/stm32-usart.c            |  38 ++++----
>  drivers/tty/serial/sunhv.c                  |  28 +++---
>  drivers/tty/serial/sunplus-uart.c           |  26 ++---
>  drivers/tty/serial/sunsab.c                 |  34 +++----
>  drivers/tty/serial/sunsu.c                  |  46 ++++-----
>  drivers/tty/serial/sunzilog.c               |  42 ++++----
>  drivers/tty/serial/timbuart.c               |   8 +-
>  drivers/tty/serial/uartlite.c               |  18 ++--
>  drivers/tty/serial/ucc_uart.c               |   4 +-
>  drivers/tty/serial/vt8500_serial.c          |   8 +-
>  drivers/tty/serial/xilinx_uartps.c          |  56 +++++------
>  include/linux/serial_core.h                 |  91 ++++++++++++++++--
>  76 files changed, 1086 insertions(+), 1007 deletions(-)
> 
> 
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> 
