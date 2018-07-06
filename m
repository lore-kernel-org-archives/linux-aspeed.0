From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 06 Jul 2018 10:53:33 -0700
Subject: [PATCH] clk: aspeed: Treat a gate in reset as disabled
In-Reply-To: <c31c3652829e8e7064f750d219237c4eb32773e4.camel@linux.vnet.ibm.com>
References: <c31c3652829e8e7064f750d219237c4eb32773e4.camel@linux.vnet.ibm.com>
Message-ID: <153089961364.143105.3583653247951877648@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Benjamin Herrenschmidt (2018-07-03 00:24:47)
> On some systems, we come out of the bootloader with some
> gates set with the clock "enabled" but the reset also
> asserted.
> 
> Since 8a53fc511c5e "clk: aspeed: Prevent reset if clock is enabled"
> we check that enabled bit in aspeed_clk_enabled(), and do
> nothing if already set.
> 
> This breaks when the above scenario occurs, as the clock
> is enabled, but the reset still needs to be lifted.
> 
> This patch fixes it by also checking the reset bit (if any)
> and treating a gate in "reset" as being disabled.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 8a53fc511c5e "clk: aspeed: Prevent reset if clock is enabled"
> CC: Eddie James <eajames@linux.vnet.ibm.com>
> ---

Applied to clk-fixes

