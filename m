From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 06 Jul 2018 13:48:13 -0700
Subject: [PATCH] clk: aspeed: Mark bclk (PCIe) and dclk (VGA) as critical
In-Reply-To: <20180607070959.31995-1-joel@jms.id.au>
References: <20180607070959.31995-1-joel@jms.id.au>
Message-ID: <153091009365.143105.4953968802856253539@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Joel Stanley (2018-06-07 00:09:59)
> This is used by the host to talk to the BMC's PCIe slave device. The BMC
> is not involved, but the clock needs to be enabled so the host can use
> the device.
> 
> Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
> Cc: stable at vger.kernel.org # 4.15
> Acked-by: Andrew Jeffery <andrew@aj.id.au>
> Tested-by: Lei YU <mine260309@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Applied to clk-fixes

