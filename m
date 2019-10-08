From: Joel Stanley <joel@jms.id.au>
Date: Tue, 8 Oct 2019 12:39:49 +0000
Subject: [PATCH 2/2] clk: ast2600: Add RMII RCLK gates for all four MACs
In-Reply-To: <20191008113553.13662-3-andrew@aj.id.au>
References: <20191008113553.13662-1-andrew@aj.id.au>
 <20191008113553.13662-3-andrew@aj.id.au>
Message-ID: <CACPK8XfSrKym55eQ91Lhf3wXtzCD5AH7P8t19jow2K-5JRb0ZA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2019 at 11:35, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> RCLK is a fixed 50MHz clock derived from HPLL/HCLK that is described by a
> single gate for each MAC.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

We could have mac12rclk and mac34rclk described in the device tree, as
was mentioned in previous reviews of the aspeed driver, but I think we
can defer that
rework until we rework the rest of the driver. Importantly, that won't
change the MAC bindings or the code that the drivers need to use.

Reviewed-by: Joel Stanley <joel@jms.id.au>


> ---
>  drivers/clk/clk-ast2600.c | 47 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index 1c1bb39bb04e..3d6fc781fee0 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -15,7 +15,7 @@
>
>  #include "clk-aspeed.h"
>
> -#define ASPEED_G6_NUM_CLKS             67
> +#define ASPEED_G6_NUM_CLKS             71
>
>  #define ASPEED_G6_SILICON_REV          0x004
>
> @@ -40,6 +40,9 @@
>
>  #define ASPEED_G6_STRAP1               0x500
>
> +#define ASPEED_MAC12_CLK_DLY           0x340
> +#define ASPEED_MAC34_CLK_DLY           0x350
> +
>  /* Globally visible clocks */
>  static DEFINE_SPINLOCK(aspeed_g6_clk_lock);
>
> @@ -485,6 +488,11 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_SDIO] = hw;
>
> +       /* MAC1/2 RMII 50MHz RCLK */
> +       hw = clk_hw_register_fixed_rate(dev, "mac12rclk", "hpll", 0, 50000000);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
>         /* MAC1/2 AHB bus clock divider */
>         hw = clk_hw_register_divider_table(dev, "mac12", "hpll", 0,
>                         scu_g6_base + ASPEED_G6_CLK_SELECTION1, 16, 3, 0,
> @@ -494,6 +502,27 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_MAC12] = hw;
>
> +       /* RMII1 50MHz (RCLK) output enable */
> +       hw = clk_hw_register_gate(dev, "mac1rclk-gate", "mac12rclk", 0,
> +                       scu_g6_base + ASPEED_MAC12_CLK_DLY, 29, 0,
> +                       &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC1RCLK] = hw;
> +
> +       /* RMII2 50MHz (RCLK) output enable */
> +       hw = clk_hw_register_gate(dev, "mac2rclk-gate", "mac12rclk", 0,
> +                       scu_g6_base + ASPEED_MAC12_CLK_DLY, 30, 0,
> +                       &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC2RCLK] = hw;
> +
> +       /* MAC1/2 RMII 50MHz RCLK */
> +       hw = clk_hw_register_fixed_rate(dev, "mac34rclk", "hclk", 0, 50000000);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
>         /* MAC3/4 AHB bus clock divider */
>         hw = clk_hw_register_divider_table(dev, "mac34", "hpll", 0,
>                         scu_g6_base + 0x310, 24, 3, 0,
> @@ -503,6 +532,22 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_MAC34] = hw;
>
> +       /* RMII3 50MHz (RCLK) output enable */
> +       hw = clk_hw_register_gate(dev, "mac3rclk-gate", "mac34rclk", 0,
> +                       scu_g6_base + ASPEED_MAC34_CLK_DLY, 29, 0,
> +                       &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC3RCLK] = hw;
> +
> +       /* RMII4 50MHz (RCLK) output enable */
> +       hw = clk_hw_register_gate(dev, "mac4rclk-gate", "mac34rclk", 0,
> +                       scu_g6_base + ASPEED_MAC34_CLK_DLY, 30, 0,
> +                       &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +       aspeed_g6_clk_data->hws[ASPEED_CLK_GATE_MAC4RCLK] = hw;
> +
>         /* LPC Host (LHCLK) clock divider */
>         hw = clk_hw_register_divider_table(dev, "lhclk", "hpll", 0,
>                         scu_g6_base + ASPEED_G6_CLK_SELECTION1, 20, 3, 0,
> --
> 2.20.1
>
