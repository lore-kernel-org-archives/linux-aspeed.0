From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Jul 2024 13:13:22 +0200
Subject: [PATCH v1 03/10] clk: ast2700: add clock controller
In-Reply-To: <20240726110355.2181563-4-kevin_chen@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-4-kevin_chen@aspeedtech.com>
Message-ID: <fb3489cf-b288-426e-ace0-abf1d6b0fe0c@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/07/2024 13:03, Kevin Chen wrote:
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>

So you did not write commit msgs to none of the commits?

> ---
>  drivers/clk/Makefile      |    1 +
>  drivers/clk/clk-ast2700.c | 1166 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 1167 insertions(+)
>  create mode 100644 drivers/clk/clk-ast2700.c
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index f793a16cad40..0d5992ea0fa4 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
>  obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
>  obj-$(CONFIG_COMMON_CLK_ASPEED)		+= clk-aspeed.o
>  obj-$(CONFIG_MACH_ASPEED_G6)		+= clk-ast2600.o
> +obj-$(CONFIG_MACH_ASPEED_G7)		+= clk-ast2700.o

...

> +
> +static const char *const pspclk_sel[] = {
> +	"soc0-mpll",
> +	"soc0-hpll",
> +};
> +
> +static const char *const soc0_uartclk_sel[] = {
> +	"soc0-clk24Mhz",
> +	"soc0-clk192Mhz",
> +};
> +
> +static const char *const emmcclk_sel[] = {
> +	"soc0-mpll_div4",
> +	"soc0-hpll_div4",
> +};
> +
> +static int ast2700_soc0_clk_init(struct device_node *soc0_node)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	void __iomem *clk_base;
> +	struct ast2700_reset *reset;
> +	struct clk_hw **clks;
> +	int div;
> +	u32 val;
> +	int ret;
> +
> +	clk_data = kzalloc(struct_size(clk_data, hws, SOC0_NUM_CLKS), GFP_KERNEL);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	clk_data->num = SOC0_NUM_CLKS;
> +	clks = clk_data->hws;
> +
> +	clk_base = of_iomap(soc0_node, 0);
> +	if (WARN_ON(IS_ERR(clk_base)))

Drop WARN_ON

> +		return PTR_ERR(clk_base);
> +
> +	reset = kzalloc(sizeof(*reset), GFP_KERNEL);
> +	if (!reset)
> +		return -ENOMEM;
> +
> +	reset->base = clk_base;
> +
> +	reset->rcdev.owner = THIS_MODULE;
> +	reset->rcdev.nr_resets = SOC0_RESET_NUMS;
> +	reset->rcdev.ops = &ast2700_reset_ops;
> +	reset->rcdev.of_node = soc0_node;
> +
> +	ret = reset_controller_register(&reset->rcdev);
> +	if (ret) {
> +		pr_err("soc0 failed to register reset controller\n");
> +		return ret;
> +	}
> +
> +	//refclk

Weird comment. Please read Coding Style.


> +	clks[SCU0_CLKIN] =
> +		clk_hw_register_fixed_rate(NULL, "soc0-clkin", NULL, 0, SCU_CLK_25MHZ);
> +
> +	clks[SCU0_CLK_24M] =
> +		clk_hw_register_fixed_rate(NULL, "soc0-clk24Mhz", NULL, 0, SCU_CLK_24MHZ);
> +
> +	clks[SCU0_CLK_192M] =
> +		clk_hw_register_fixed_rate(NULL, "soc0-clk192Mhz", NULL, 0, SCU_CLK_192MHZ);
> +
> +	//hpll
> +	val = readl(clk_base + SCU0_HWSTRAP1);
> +	if ((val & GENMASK(3, 2)) != 0) {
> +		switch ((val & GENMASK(3, 2)) >> 2) {
> +		case 1:
> +			clks[SCU0_CLK_HPLL] =
> +				clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1900000000);
> +			break;
> +		case 2:
> +			clks[SCU0_CLK_HPLL] =
> +				clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1800000000);
> +			break;
> +		case 3:
> +			clks[SCU0_CLK_HPLL] =
> +				clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1700000000);
> +			break;
> +		}
> +	} else {
> +		val = readl(clk_base + SCU0_HPLL_PARAM);
> +		clks[SCU0_CLK_HPLL] = ast2700_soc0_hw_pll("soc0-hpll", "soc0-clkin", val);
> +	}
> +	clks[SCU0_CLK_HPLL_DIV2] = clk_hw_register_fixed_factor(NULL, "soc0-hpll_div2", "soc0-hpll", 0, 1, 2);
> +	clks[SCU0_CLK_HPLL_DIV4] = clk_hw_register_fixed_factor(NULL, "soc0-hpll_div4", "soc0-hpll", 0, 1, 4);
> +
> +	//dpll



Best regards,
Krzysztof

