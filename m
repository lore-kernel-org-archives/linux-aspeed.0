From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 11 Feb 2022 12:19:12 +0200
Subject: [PATCH v2] serial: 8250_aspeed_vuart: add PORT_ASPEED_VUART port
 type
In-Reply-To: <20220211004203.14915-1-zev@bewilderbeest.net>
References: <20220211004203.14915-1-zev@bewilderbeest.net>
Message-ID: <YgY4IODZlKTG7yzn@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 10, 2022 at 04:42:03PM -0800, Zev Weiss wrote:
> Commit 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to
> set up register mapping") fixed a bug that had, as a side-effect,
> prevented the 8250_aspeed_vuart driver from enabling the VUART's
> FIFOs.  However, fixing that (and hence enabling the FIFOs) has in
> turn revealed what appears to be a hardware bug in the ASPEED VUART in
> which the host-side THRE bit doesn't get if the BMC-side receive FIFO
> trigger level is set to anything but one byte.  This causes problems
> for polled-mode writes from the host -- for example, Linux kernel
> console writes proceed at a glacial pace (less than 100 bytes per
> second) because the write path waits for a 10ms timeout to expire
> after every character instead of being able to continue on to the next
> character upon seeing THRE asserted.  (GRUB behaves similarly.)
> 
> As a workaround, introduce a new port type for the ASPEED VUART that's
> identical to PORT_16550A as it had previously been using, but with
> UART_FCR_R_TRIG_00 instead to set the receive FIFO trigger level to
> one byte, which (experimentally) seems to avoid the problematic THRE
> behavior.

...

> +	[PORT_ASPEED_VUART] = {
> +		.name		= "ASPEED VUART",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
> +		.rxtrig_bytes	= {1, 4, 8, 14},
> +		.flags		= UART_CAP_FIFO,
> +	},

This is quite similar to AR7 type. Can that be (re-)used?

-- 
With Best Regards,
Andy Shevchenko


