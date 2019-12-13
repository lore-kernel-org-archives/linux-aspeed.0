From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Fri, 13 Dec 2019 06:47:58 +0100
Subject: [PATCH 00/58] serial/sysrq: Cleanup ifdeffery
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
Message-ID: <524d9848-28a5-7e65-699b-600c49606487@c-s.fr>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Le 13/12/2019 ? 01:05, Dmitry Safonov a ?crit?:
> The original purpose of the patches set was to add a way to enable
> sysrq on a uart where currently it can be constantly either on or off
> (CONFIG_MAGIC_SYSRQ_SERIAL), see the last patch:
>    "serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE"
> 
> But to do that, I had to add uart_try_toggle_sysrq() and I didn't want
> to bloat serial_core.h even more. So, I did cleanup by removing
> SUPPORT_SYSRQ resulting in a nice diff-stat and lesser ifdeffery.
> 
> Most patches are one-liners, I decided to keep them separated per-driver
> to let reviewers easier follow the purpose.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Vasiliy Khoruzhick <vasilykh@arista.com>
> Cc: linux-serial at vger.kernel.org
> 
> Dmitry Safonov (58):
>    sysrq: Remove sysrq_handler_registered
>    serial: Move sysrq members above
>    serial_core: Un-ifdef sysrq SUPPORT_SYSRQ
>    tty/serial: Migrate aspeed_vuart to use has_sysrq
>    tty/serial: Migrate 8250_fsl to use has_sysrq
>    tty/serial: Migrate bcm63xx_uart to use has_sysrq
>    tty/serial: Migrate 8250_omap to use has_sysrq
>    tty/serial: Migrate 8250_port to use has_sysrq
>    tty/serial: Migrate amba-pl01* to use has_sysrq
>    tty/serial: Migrate apbuart to use has_sysrq
>    tty/serial: Migrate arc_uart to use has_sysrq
>    tty/serial: Migrate atmel_serial to use has_sysrq
>    tty/serial: Migrate clps711x to use has_sysrq
>    tty/serial: Migrate cpm_uart to use has_sysrq
>    tty/serial: Migrate dz to use has_sysrq
>    tty/serial: Migrate efm32-uart to use has_sysrq
>    tty/serial: Migrate fsl_linflexuart to use has_sysrq
>    tty/serial: Migrate fsl_lpuart to use has_sysrq
>    tty/serial: Migrate imx to use has_sysrq
>    tty/serial: Migrate ip22zilog to use has_sysrq
>    tty/serial: Migrate meson_uart to use has_sysrq
>    tty/serial: Migrate milbeaut_usio to use has_sysrq
>    tty/serial: Migrate mpc52xx_uart to use has_sysrq
>    tty/serial: Don't zero port->sysrq
>    tty/serial: Migrate msm_serial to use has_sysrq
>    tty/serial: Migrate mux to use has_sysrq
>    tty/serial: Migrate mxs-auart to use has_sysrq
>    tty/serial: Migrate omap-serial to use has_sysrq
>    tty/serial: Migrate pch_uart to use has_sysrq
>    tty/serial: Don't check port->sysrq
>    tty/serial: Migrate pmac_zilog to use has_sysrq
>    tty/serial: Migrate pnx8xxx_uart to use has_sysrq
>    serial/f81534: Don't check port->sysrq
>    tty/serial: Migrate pxa to use has_sysrq
>    tty/serial: Migrate qcom_geni_serial to use has_sysrq
>    tty/serial: Migrate sa1100 to use has_sysrq
>    tty/serial: Migrate samsung_tty to use has_sysrq
>    tty/serial: Migrate sb1250-duart to use has_sysrq
>    tty/serial: Migrate sccnxp to use has_sysrq
>    tty/serial: Migrate serial_txx9 to use has_sysrq
>    tty/serial: Migrate sh-sci to use has_sysrq
>    tty/serial: Migrate sprd_serial to use has_sysrq
>    tty/serial: Migrate st-asc to use has_sysrq
>    tty/serial: Migrate stm32-usart to use has_sysrq
>    tty/serial: Migrate sunhv to use has_sysrq
>    tty/serial: Migrate sunsab to use has_sysrq
>    tty/serial: Migrate sunsu to use has_sysrq
>    tty/serial: Migrate sunzilog to use has_sysrq
>    serial/ucc_uart: Remove ifdef SUPPORT_SYSRQ
>    tty/serial: Migrate vr41xx_siu to use has_sysrq
>    tty/serial: Migrate vt8500_serial to use has_sysrq
>    tty/serial: Migrate xilinx_uartps to use has_sysrq
>    tty/serial: Migrate zs to use has_sysrq
>    serial_core: Remove SUPPORT_SYSRQ ifdeffery
>    usb/serial: Don't handle break when CONFIG_MAGIC_SYSRQ is disabled
>    serial_core: Move sysrq functions from header file
>    sysctl/sysrq: Remove __sysrq_enabled copy
>    serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE

powerpc patchwork didn't get the full series, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=148198

Can't find them on linux-serial patchwork either 
(https://patches.linaro.org/project/linux-serial/list/)

It is impossible to review/test powerpc bits without the first patches 
of the series, where can the entire series be found ?

Christophe

> 
>   arch/powerpc/kernel/legacy_serial.c         |   4 +-
>   drivers/tty/serial/8250/8250_aspeed_vuart.c |   5 +-
>   drivers/tty/serial/8250/8250_fsl.c          |   4 -
>   drivers/tty/serial/8250/8250_of.c           |   4 +-
>   drivers/tty/serial/8250/8250_omap.c         |   5 +-
>   drivers/tty/serial/8250/8250_port.c         |   5 +-
>   drivers/tty/serial/amba-pl010.c             |   5 +-
>   drivers/tty/serial/amba-pl011.c             |   6 +-
>   drivers/tty/serial/apbuart.c                |   5 +-
>   drivers/tty/serial/arc_uart.c               |   5 +-
>   drivers/tty/serial/atmel_serial.c           |   9 +-
>   drivers/tty/serial/bcm63xx_uart.c           |   5 +-
>   drivers/tty/serial/clps711x.c               |   5 +-
>   drivers/tty/serial/cpm_uart/cpm_uart_core.c |   9 +-
>   drivers/tty/serial/dz.c                     |   5 +-
>   drivers/tty/serial/efm32-uart.c             |   5 +-
>   drivers/tty/serial/fsl_linflexuart.c        |   8 +-
>   drivers/tty/serial/fsl_lpuart.c             |   9 +-
>   drivers/tty/serial/imx.c                    |   7 +-
>   drivers/tty/serial/ip22zilog.c              |   7 +-
>   drivers/tty/serial/meson_uart.c             |   5 +-
>   drivers/tty/serial/milbeaut_usio.c          |   5 +-
>   drivers/tty/serial/mpc52xx_uart.c           |  11 +-
>   drivers/tty/serial/msm_serial.c             |   5 +-
>   drivers/tty/serial/mux.c                    |   5 +-
>   drivers/tty/serial/mxs-auart.c              |   5 +-
>   drivers/tty/serial/omap-serial.c            |   5 +-
>   drivers/tty/serial/pch_uart.c               |  12 +-
>   drivers/tty/serial/pmac_zilog.c             |   5 +-
>   drivers/tty/serial/pnx8xxx_uart.c           |   7 +-
>   drivers/tty/serial/pxa.c                    |   5 +-
>   drivers/tty/serial/qcom_geni_serial.c       |   5 +-
>   drivers/tty/serial/sa1100.c                 |   7 +-
>   drivers/tty/serial/samsung_tty.c            |   5 +-
>   drivers/tty/serial/sb1250-duart.c           |   5 +-
>   drivers/tty/serial/sccnxp.c                 |   5 +-
>   drivers/tty/serial/serial_core.c            | 123 ++++++++++++++++++++
>   drivers/tty/serial/serial_txx9.c            |   5 +-
>   drivers/tty/serial/sh-sci.c                 |  10 +-
>   drivers/tty/serial/sprd_serial.c            |   5 +-
>   drivers/tty/serial/st-asc.c                 |   5 +-
>   drivers/tty/serial/stm32-usart.c            |   5 +-
>   drivers/tty/serial/sunhv.c                  |   5 +-
>   drivers/tty/serial/sunsab.c                 |   5 +-
>   drivers/tty/serial/sunsu.c                  |   5 +-
>   drivers/tty/serial/sunzilog.c               |   6 +-
>   drivers/tty/serial/ucc_uart.c               |   2 -
>   drivers/tty/serial/vr41xx_siu.c             |   5 +-
>   drivers/tty/serial/vt8500_serial.c          |   5 +-
>   drivers/tty/serial/xilinx_uartps.c          |   5 +-
>   drivers/tty/serial/zs.c                     |   5 +-
>   drivers/tty/sysrq.c                         |  16 +--
>   drivers/usb/serial/f81534.c                 |   6 +-
>   drivers/usb/serial/generic.c                |  10 +-
>   include/linux/serial_core.h                 |  92 ++-------------
>   include/linux/sysrq.h                       |   1 +
>   kernel/sysctl.c                             |  41 ++++---
>   lib/Kconfig.debug                           |   8 ++
>   58 files changed, 238 insertions(+), 346 deletions(-)
> 
