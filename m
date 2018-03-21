From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 21 Mar 2018 10:52:36 +0800
Subject: [PATCH 0/5] serial: implement flow control for ASPEED VUART driver
Message-ID: <20180321025241.19785-1-jk@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series implements flow control for the ASPEED VUART driver. This
hardware is slightly unusual in that the RX data rate can quickly
overwhelm the flip buffer code, so the ldisc-driven throttle/unthrottle
mechanisms don't entirely solve the problem.

To do this, we have a couple of minor changes to the tty core, as well
as an update to the tty proc interface to display buffer overrun metrics
(entirely optional, but does allow us to see the problem).

Then, we implement the standard throttle mechanism, and augment it with
a fast-path to throttle if we overrun the flip buffers before the ldisc
has had a chance to run.

Questions and comments most welcome; I'm fairly new to the tty layer.

Cheers,


Jeremy

---

Jeremy Kerr (5):
  serial: Introduce UPSTAT_SYNC_FIFO for synchronised FIFOs
  serial: expose buf_overrun count through proc interface
  serial/8250: export serial8250_read_char
  serial/aspeed-vuart: Implement rx throttling
  serial/aspeed-vuart: Implement quick throttle mechanism

 drivers/tty/serial/8250/8250_aspeed_vuart.c | 122 ++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c         |   3 +-
 drivers/tty/serial/serial_core.c            |   6 +-
 include/linux/serial_8250.h                 |   1 +
 include/linux/serial_core.h                 |   1 +
 5 files changed, 130 insertions(+), 3 deletions(-)

-- 
2.14.1

