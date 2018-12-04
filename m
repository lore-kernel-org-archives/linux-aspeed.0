From: Stephen Boyd <sboyd@kernel.org>
Date: Tue, 04 Dec 2018 12:50:46 -0800
Subject: [PATCH v2] clk: aspeed: Mark lclk (LPC) and espiclk (eSPI) as
 critical
In-Reply-To: <20181204185054.24053-1-jae.hyun.yoo@linux.intel.com>
References: <20181204185054.24053-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <154395664604.88331.16833135233042073777@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Jae Hyun Yoo (2018-12-04 10:50:53)
> These interfaces are used by host to talk to BMC, and the clock
> source is from the host, usually from PCH. So this commit marks
> the lclk as critical to make it able to be enabled. Also, it marks
> espiclk too because eSPI is sharing the same interface with LPC.
> 
> Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
> Cc: stable at vger.kernel.org
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/clk/clk-aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 596136793fc4..df9504427246 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -95,7 +95,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>         [ASPEED_CLK_GATE_DCLK] =        {  5, -1, "dclk-gate",          NULL,   CLK_IS_CRITICAL }, /* DAC */
>         [ASPEED_CLK_GATE_REFCLK] =      {  6, -1, "refclk-gate",        "clkin", CLK_IS_CRITICAL },
>         [ASPEED_CLK_GATE_USBPORT2CLK] = {  7,  3, "usb-port2-gate",     NULL,   0 }, /* USB2.0 Host port 2 */
> -       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   0 }, /* LPC */
> +       [ASPEED_CLK_GATE_LCLK] =        {  8,  5, "lclk-gate",          NULL,   CLK_IS_CRITICAL }, /* LPC clock from host. No parent dependency */

What does "No parent dependency" mean? I was hoping to see something
like the commit text, "lclk is used to talk to BMC which can happen at
anytime" or something like that.

