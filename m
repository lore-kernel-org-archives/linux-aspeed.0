From: Joel Stanley <joel@jms.id.au>
Date: Fri, 10 Jul 2020 03:03:08 +0000
Subject: [PATCH 1/2] clk: AST2600: Add mux for EMMC clock
In-Reply-To: <20200709195706.12741-2-eajames@linux.ibm.com>
References: <20200709195706.12741-1-eajames@linux.ibm.com>
 <20200709195706.12741-2-eajames@linux.ibm.com>
Message-ID: <CACPK8Xd1RMXooVR99xZLxWdgb+Suw8KZrSX6nN1Ua0eUM=mH3w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 9 Jul 2020 at 19:57, Eddie James <eajames@linux.ibm.com> wrote:
>
> The EMMC clock can be derived from either the HPLL or the MPLL. Register
> a clock mux so that the rate is calculated correctly based upon the
> parent.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Joel Stanley <joel@jms.id.au>
Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")

Stephen, I think this should go to stable too.

Cheers,

Joel

> ---
>  drivers/clk/clk-ast2600.c | 49 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index 99afc949925f..177368cac6dd 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -131,6 +131,18 @@ static const struct clk_div_table ast2600_eclk_div_table[] = {
>         { 0 }
>  };
>
> +static const struct clk_div_table ast2600_emmc_extclk_div_table[] = {
> +       { 0x0, 2 },
> +       { 0x1, 4 },
> +       { 0x2, 6 },
> +       { 0x3, 8 },
> +       { 0x4, 10 },
> +       { 0x5, 12 },
> +       { 0x6, 14 },
> +       { 0x7, 16 },
> +       { 0 }
> +};
> +
>  static const struct clk_div_table ast2600_mac_div_table[] = {
>         { 0x0, 4 },
>         { 0x1, 4 },
> @@ -390,6 +402,11 @@ static struct clk_hw *aspeed_g6_clk_hw_register_gate(struct device *dev,
>         return hw;
>  }
>
> +static const char *const emmc_extclk_parent_names[] = {
> +       "emmc_extclk_hpll_in",
> +       "mpll",
> +};
> +
>  static const char * const vclk_parent_names[] = {
>         "dpll",
>         "d1pll",
> @@ -459,16 +476,32 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_UARTX] = hw;
>
> -       /* EMMC ext clock divider */
> -       hw = clk_hw_register_gate(dev, "emmc_extclk_gate", "hpll", 0,
> -                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 15, 0,
> -                       &aspeed_g6_clk_lock);
> +       /* EMMC ext clock */
> +       hw = clk_hw_register_fixed_factor(dev, "emmc_extclk_hpll_in", "hpll",
> +                                         0, 1, 2);
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
> -       hw = clk_hw_register_divider_table(dev, "emmc_extclk", "emmc_extclk_gate", 0,
> -                       scu_g6_base + ASPEED_G6_CLK_SELECTION1, 12, 3, 0,
> -                       ast2600_div_table,
> -                       &aspeed_g6_clk_lock);
> +
> +       hw = clk_hw_register_mux(dev, "emmc_extclk_mux",
> +                                emmc_extclk_parent_names,
> +                                ARRAY_SIZE(emmc_extclk_parent_names), 0,
> +                                scu_g6_base + ASPEED_G6_CLK_SELECTION1, 11, 1,
> +                                0, &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       hw = clk_hw_register_gate(dev, "emmc_extclk_gate", "emmc_extclk_mux",
> +                                 0, scu_g6_base + ASPEED_G6_CLK_SELECTION1,
> +                                 15, 0, &aspeed_g6_clk_lock);
> +       if (IS_ERR(hw))
> +               return PTR_ERR(hw);
> +
> +       hw = clk_hw_register_divider_table(dev, "emmc_extclk",
> +                                          "emmc_extclk_gate", 0,
> +                                          scu_g6_base +
> +                                               ASPEED_G6_CLK_SELECTION1, 12,
> +                                          3, 0, ast2600_emmc_extclk_div_table,
> +                                          &aspeed_g6_clk_lock);
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_EMMC] = hw;
> --
> 2.24.0
>
