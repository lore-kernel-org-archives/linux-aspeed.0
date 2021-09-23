From: Joel Stanley <joel@jms.id.au>
Date: Thu, 23 Sep 2021 00:02:17 +0000
Subject: [PATCH 01/10] clk: aspeed: ast2600: Porting sdhci clock source
In-Reply-To: <20210922103116.30652-2-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-2-chin-ting_kuo@aspeedtech.com>
Message-ID: <CACPK8XeeEeQb52ZHYaN49r_Vso-xUHamDyrA+bFvP4_ESQs9dA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 22 Sept 2021 at 10:31, Chin-Ting Kuo
<chin-ting_kuo@aspeedtech.com> wrote:
>
> - There are two clock sources used to generate
>   SD/SDIO clock, APLL clock and HCLK (200MHz).
>   User can select which clock source should be used
>   by configuring SCU310[8].
> - The SD/SDIO clock divider selection table SCU310[30:28]
>   is different between AST2600-A1 and AST2600-A2/A3.
>   For AST2600-A1, 200MHz SD/SDIO clock cannot be
>   gotten by the dividers in SCU310[30:28] if APLL
>   is not the multiple of 200MHz and HCLK is 200MHz.
>   For AST2600-A2/A3, a new divider, "1", is added and
>   200MHz SD/SDIO clock can be obtained by adopting HCLK
>   as clock source and setting SCU310[30:28] to 3b'111.
>
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  drivers/clk/clk-ast2600.c | 69 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index bc3be5f3eae1..a6778c18274a 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -168,6 +168,30 @@ static const struct clk_div_table ast2600_div_table[] = {
>         { 0 }
>  };
>
> +static const struct clk_div_table ast2600_sd_div_a1_table[] = {

Let's put the revision next to the ast2600 like the other tables:

ast2600_a1_sd_div_table

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
> +static const struct clk_div_table ast2600_sd_div_a2_table[] = {

For naming; can I propose we omit the revision for the A2/A3+ case? So
this one would be called:

ast2600_sd_div_table

> +       { 0x0, 2 },
> +       { 0x1, 4 },
> +       { 0x2, 6 },
> +       { 0x3, 8 },
> +       { 0x4, 10 },
> +       { 0x5, 12 },
> +       { 0x6, 14 },
> +       { 0x7, 1 },
> +       { 0 }
> +};
> +
>  /* For hpll/dpll/epll/mpll */
>  static struct clk_hw *ast2600_calc_pll(const char *name, u32 val)
>  {
> @@ -424,6 +448,11 @@ static const char *const emmc_extclk_parent_names[] = {
>         "mpll",
>  };
>
> +static const char *const sd_extclk_parent_names[] = {
> +       "hclk",
> +       "apll",
> +};
> +
>  static const char * const vclk_parent_names[] = {
>         "dpll",
>         "d1pll",
> @@ -523,18 +552,42 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 return PTR_ERR(hw);
>         aspeed_g6_clk_data->hws[ASPEED_CLK_EMMC] = hw;
>
> -       /* SD/SDIO clock divider and gate */
> -       hw = clk_hw_register_gate(dev, "sd_extclk_gate", "hpll", 0,
> -                       scu_g6_base + ASPEED_G6_CLK_SELECTION4, 31, 0,
> -                       &aspeed_g6_clk_lock);
> +       clk_hw_register_fixed_rate(NULL, "hclk", NULL, 0, 200000000);
> +
> +       regmap_read(map, 0x310, &val);

Use the #defines for the register number.

> +       hw = clk_hw_register_mux(dev, "sd_extclk_mux",
> +                                sd_extclk_parent_names,
> +                                ARRAY_SIZE(sd_extclk_parent_names), 0,
> +                                scu_g6_base + ASPEED_G6_CLK_SELECTION4, 8, 1,
> +                                0, &aspeed_g6_clk_lock);
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
> -       hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
> -                       0, scu_g6_base + ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
> -                       ast2600_div_table,
> -                       &aspeed_g6_clk_lock);
> +
> +       hw = clk_hw_register_gate(dev, "sd_extclk_gate", "sd_extclk_mux",
> +                                 0, scu_g6_base + ASPEED_G6_CLK_SELECTION4,
> +                                 31, 0, &aspeed_g6_clk_lock);
>         if (IS_ERR(hw))
>                 return PTR_ERR(hw);
> +
> +       regmap_read(map, 0x14, &val);
> +       /* AST2600-A2/A3 clock divisor is different from AST2600-A1 */
> +       if (((val & GENMASK(23, 16)) >> 16) >= 2) {

I've got a little patch that I recommend you base your series on (feel
free to include it in your series when posting v2 to make it
self-contained):

https://lore.kernel.org/all/20210922235449.213631-1-joel at jms.id.au/

With this one you can do:

const struct clk_div_table* table;

 if (soc_rev >= 2)
   table = ast2600_sd_div_table;
else
   table = ast2600_a1_sd_div_table;

Then you don't need to duplicate the registration for each case:

               hw = clk_hw_register_divider_table(dev, "sd_extclk",
"sd_extclk_gate",
                                       0, scu_g6_base +
ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
                                       table,
                                       &aspeed_g6_clk_lock);
               if (IS_ERR(hw))
                       return PTR_ERR(hw);

> +               /* AST2600-A2/A3 */
> +               hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
> +                                       0, scu_g6_base + ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
> +                                       ast2600_sd_div_a2_table,
> +                                       &aspeed_g6_clk_lock);
> +               if (IS_ERR(hw))
> +                       return PTR_ERR(hw);
> +       } else {
> +               /* AST2600-A1 */
> +               hw = clk_hw_register_divider_table(dev, "sd_extclk", "sd_extclk_gate",
> +                                       0, scu_g6_base + ASPEED_G6_CLK_SELECTION4, 28, 3, 0,
> +                                       ast2600_sd_div_a1_table,
> +                                       &aspeed_g6_clk_lock);
> +               if (IS_ERR(hw))
> +                       return PTR_ERR(hw);
> +       }
>         aspeed_g6_clk_data->hws[ASPEED_CLK_SDIO] = hw;
>
>         /* MAC1/2 RMII 50MHz RCLK */
> --
> 2.17.1
>
