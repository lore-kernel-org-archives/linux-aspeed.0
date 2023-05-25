From: John Ogness <john.ogness@linutronix.de>
Date: Thu, 25 May 2023 11:37:51 +0206
Subject: [PATCH tty v1 0/8] synchronize UART_IER access against console write
Message-ID: <20230525093159.223817-1-john.ogness@linutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

In preparation for making the 8250 serial driver the first driver to
support the upcoming atomic consoles [0], its console write()
callback (serial8250_console_write) was evaluated. For this callback
of the 8250 driver there are two critical writes to the UART_IER
register: once to disable all interrupts before transmitting a line
of text, and again after transmit to re-enable the previously enabled
interrupts. These two writes are performed under a single
synchronized section protected by the port lock.

I then checked all other access to UART_IER in the 8250 driver to see
if they always occurred under the port lock. If not, it would be
possible that the console write() callback could overwrite or restore
incorrect values to UART_IER. This is illustrated in the commit
message of the first patch.

Indeed several call sites were discovered where UART_IER is accessed
without the port lock. This series adds the missing locking in order
to ensure UART_IER access is always synchronized against the console
write() callback.

For call sites where UART_IER access was already performed under the
port lock, this series adds code comments and (when appropriate)
lockdep notation to help catch any future issues that may creep in.

Note that some of the new usage of port lock is not strictly
necessary, because (for example) the console is disabled before it
is suspended. However, these are not hot paths and by taking the port
lock it simplifies the synchronization semantics for UART_IER to
allow general lockdep usage.

Also note that none of these patches have been tagged for stable. The
possible stable candidates do include Fixes tags. But since the fixes
are not based on real-world reports, it probably is not necessary to
backport them.

John Ogness

[0] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness at linutronix.de

John Ogness (8):
  serial: 8250: lock port in startup() callbacks
  serial: core: lock port for stop_rx() in uart_suspend_port()
  serial: 8250: lock port for stop_rx() in omap8250_irq()
  serial: core: lock port for start_rx() in uart_resume_port()
  serial: 8250: lock port for rx_dma() callback
  serial: 8250: lock port for omap8250_restore_regs()
  serial: 8250: lock port for UART_IER access in omap8250_irq()
  serial: 8250: synchronize and annotate UART_IER access

 drivers/tty/serial/8250/8250.h              |  6 ++
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  3 +
 drivers/tty/serial/8250/8250_bcm7271.c      |  4 ++
 drivers/tty/serial/8250/8250_exar.c         |  4 ++
 drivers/tty/serial/8250/8250_mtk.c          |  9 +++
 drivers/tty/serial/8250/8250_omap.c         | 41 +++++++++++-
 drivers/tty/serial/8250/8250_port.c         | 71 ++++++++++++++++++++-
 drivers/tty/serial/serial_core.c            | 10 ++-
 8 files changed, 141 insertions(+), 7 deletions(-)


base-commit: d5b3d02d0b107345f2a6ecb5b06f98356f5c97ab
-- 
2.30.2

