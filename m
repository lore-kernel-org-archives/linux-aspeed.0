From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Feb 2023 15:52:03 +0200 (EET)
Subject: [PATCH 3/4] serial: 8250: Add Aspeed UART driver
In-Reply-To: <20230210072643.2772-4-chiawei_wang@aspeedtech.com>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com> <20230210072643.2772-4-chiawei_wang@aspeedtech.com>
Message-ID: <2d389fc9-0d5-42a1-b6d7-695c70dcf0fe@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 10 Feb 2023, Chia-Wei Wang wrote:

> Add the driver for Aspeed UART/VUART devices, which are 16550A
> compatible. It is an wrapper to cover the generic 16550A operation
> while exetending DMA feature for the devices.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/tty/serial/8250/8250_aspeed.c | 502 ++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig       |   8 +
>  drivers/tty/serial/8250/Makefile      |   1 +

Hi,

Before I look any further into this, could you please explain why this is 
made to be entirely separate from what we have in 
  drivers/tty/serial/8250/8250_aspeed_vuart.c
?

I quickly went through some functions and they've significant parts in 
common with no variations at all in many functions and you're defines 
are 1:1 too (except for the DMA buf sizes). It would seem much better to 
add the missing functionality into 8250_aspeed_vuart.c rather than 
creating something from scratch with large overlap with existing code.

If you intend to keep it as a separate one, you should have a rather good 
justification for it.


-- 
 i.

