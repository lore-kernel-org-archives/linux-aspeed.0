From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 11 Sep 2020 12:59:21 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v2_2/2]_gpio/aspeed-sgpio:_don't_enable_all_interru?=
 =?UTF-8?Q?pts_by_default?=
In-Reply-To: <20200911015105.48581-2-jk@codeconstruct.com.au>
References: <20200911015105.48581-1-jk@codeconstruct.com.au>
 <20200911015105.48581-2-jk@codeconstruct.com.au>
Message-ID: <a0270b2f-039c-45df-84da-48f850d512fa@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 11 Sep 2020, at 11:21, Jeremy Kerr wrote:
> Currently, the IRQ setup for the SGPIO driver enables all interrupts in
> dual-edge trigger mode. Since the default handler is handle_bad_irq, any
> state change on input GPIOs will trigger bad IRQ warnings.
> 
> This change applies sensible IRQ defaults: single-edge trigger, and all
> IRQs disabled.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Fixes: 7db47faae79b ("gpio: aspeed: Add SGPIO driver")

Acked-by: Andrew Jeffery <andrew@aj.id.au>
