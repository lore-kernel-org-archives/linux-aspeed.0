From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 20 May 2021 11:43:32 +0930
Subject: [PATCH v3 0/2] serial: 8250: Mitigate Tx stall risk for Aspeed VUARTs
Message-ID: <20210520021334.497341-1-andrew@aj.id.au>
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

v3 addresses comments from Jiri on v2. v2 can be found here:

https://lore.kernel.org/lkml/20210519000704.3661773-1-andrew at aj.id.au/

The documentation patch that fell out of the discussion of patch 2 of v2 can be
found here:

https://lore.kernel.org/lkml/20210520015704.489737-1-andrew at aj.id.au/T/#u

Please review!

Andrew

Andrew Jeffery (2):
  serial: 8250: Add UART_BUG_TXRACE workaround for Aspeed VUART
  serial: 8250: Use BIT(x) for UART_{CAP,BUG}_*

 drivers/tty/serial/8250/8250.h              | 32 +++++++++++----------
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 +
 drivers/tty/serial/8250/8250_port.c         | 12 ++++++++
 3 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.30.2

