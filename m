From: Stephen Boyd <sboyd@kernel.org>
Date: Thu, 30 Jan 2020 09:42:07 -0800
Subject: [PATCH 1/2] clk: aspeed: add critical clock setting logic
In-Reply-To: <20200115212639.4998-2-jae.hyun.yoo@linux.intel.com>
References: <20200115212639.4998-1-jae.hyun.yoo@linux.intel.com>
 <20200115212639.4998-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <20200130174208.B1D5620661@mail.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Jae Hyun Yoo (2020-01-15 13:26:38)
> This commit adds critical clock setting logic that applies
> CLK_IS_CRITICAL flag if it detects 'clock-critical' property in
> device tree.

Yes that is what the patch does. The commit text is supposed to explain
_why_ the patch is important. Please read "The canonical patch format"
from Documentation/process/submitting-patches.rst to understand what is
expected.

> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/clk/clk-aspeed.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 411ff5fb2c07..d22eeb574ede 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -541,8 +541,11 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>  
>         for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
>                 const struct aspeed_gate_data *gd = &aspeed_gates[i];
> +               unsigned long flags = gd->flags;
>                 u32 gate_flags;
>  
> +               of_clk_detect_critical(pdev->dev.of_node, i, &flags);
> +

Do you need clks to be critical, but only sometimes? What clks need to
be critical? Why aren't there drivers for those clks that turn them on
as necessary?

There was a lengthy discussion years ago on the list about this function
and how it's not supposed to be used in newer code. Maybe we need to
revisit that discussion and conclude that sometimes we actually do need
clks to be turned on and kept on because we'll never have a driver for
them in the kernel. Similar to how pinctrl has pin hogs.

