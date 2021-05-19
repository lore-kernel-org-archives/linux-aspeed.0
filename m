From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 19 May 2021 09:37:02 +0930
Subject: [PATCH v2 0/2] serial: 8250: Mitigate Tx stall risk for Aspeed VUARTs
Message-ID: <20210519000704.3661773-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

Briefly, the series works around a hardware race condition in the Tx path for
Aspeed virtual UARTs. A write burst to THR on the APB interface may provoke a
transfer stall where LSR[DR] on the LPC interface remains clear despite the
presence of data in the Rx FIFO.

For the work-around patch, v2 addresses the request for a comment about the use
of serial_in():

https://lore.kernel.org/lkml/d7918dcf-b938-498c-a012-3d93a748431b at www.fastmail.com/T/#md75702fbc3704bd4b375f1251a1415bcddea26a3

The second patch addresses the request for use of BIT() instead of an explicit
shift by converting all of the UART_{CAP,BUG}_* macros.

Please review!

Andrew

Andrew Jeffery (2):
  serial: 8250: Add UART_BUG_TXRACE workaround for Aspeed VUART
  serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*

 drivers/tty/serial/8250/8250.h              | 32 +++++++++++----------
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 +
 drivers/tty/serial/8250/8250_port.c         | 10 +++++++
 3 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.30.2

