From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 29 Oct 2021 15:14:51 +1030
Subject: [PATCH] clk/ast2600: Fix soc revision for AHB
In-Reply-To: <20210922235449.213631-1-joel@jms.id.au>
References: <20210922235449.213631-1-joel@jms.id.au>
Message-ID: <8588b86d-7f46-4ce4-bd6e-432499bbc0eb@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 23 Sep 2021, at 09:24, Joel Stanley wrote:
> Move the soc revision parsing to the initial probe, saving the driver
> from parsing the register multiple times.
>
> Use this variable to select the correct divisor table for the AHB clock.
> Before this fix the A2 would have used the A0 table.
>
> Fixes: 2d491066ccd4 ("clk: ast2600: Fix AHB clock divider for A1")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/clk/clk-ast2600.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index bc3be5f3eae1..24dab2312bc6 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -51,6 +51,8 @@ static DEFINE_SPINLOCK(aspeed_g6_clk_lock);
>  static struct clk_hw_onecell_data *aspeed_g6_clk_data;
> 
>  static void __iomem *scu_g6_base;
> +/* AST2600 revision: A0, A1, A2, etc */
> +static u8 soc_rev;
> 
>  /*
>   * Clocks marked with CLK_IS_CRITICAL:
> @@ -191,9 +193,8 @@ static struct clk_hw *ast2600_calc_pll(const char 
> *name, u32 val)
>  static struct clk_hw *ast2600_calc_apll(const char *name, u32 val)
>  {
>  	unsigned int mult, div;
> -	u32 chip_id = readl(scu_g6_base + ASPEED_G6_SILICON_REV);
> 
> -	if (((chip_id & CHIP_REVISION_ID) >> 16) >= 2) {
> +	if (soc_rev >= 2) {
>  		if (val & BIT(24)) {
>  			/* Pass through mode */
>  			mult = div = 1;
> @@ -707,7 +708,7 @@ static const u32 ast2600_a1_axi_ahb200_tbl[] = {
>  static void __init aspeed_g6_cc(struct regmap *map)
>  {
>  	struct clk_hw *hw;
> -	u32 val, div, divbits, chip_id, axi_div, ahb_div;
> +	u32 val, div, divbits, axi_div, ahb_div;
> 
>  	clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, 25000000);
> 
> @@ -738,8 +739,7 @@ static void __init aspeed_g6_cc(struct regmap *map)
>  		axi_div = 2;
> 
>  	divbits = (val >> 11) & 0x3;
> -	regmap_read(map, ASPEED_G6_SILICON_REV, &chip_id);
> -	if (chip_id & BIT(16)) {
> +	if (soc_rev >= 1) {

This is hidden in the noise a bit, but the patch also isn't that big.

>  		if (!divbits) {
>  			ahb_div = ast2600_a1_axi_ahb200_tbl[(val >> 8) & 0x3];
>  			if (val & BIT(16))
> @@ -784,6 +784,8 @@ static void __init aspeed_g6_cc_init(struct device_node *np)
>  	if (!scu_g6_base)
>  		return;
> 
> +	soc_rev = (readl(scu_g6_base + ASPEED_G6_SILICON_REV) & 
> CHIP_REVISION_ID) >> 16;
> +
>  	aspeed_g6_clk_data = kzalloc(struct_size(aspeed_g6_clk_data, hws,
>  				      ASPEED_G6_NUM_CLKS), GFP_KERNEL);
>  	if (!aspeed_g6_clk_data)
> -- 
> 2.33.0
