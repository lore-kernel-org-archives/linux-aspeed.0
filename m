From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Thu, 15 Aug 2024 05:50:30 +0000
Subject: =?big5?B?pl7C0DogW1BBVENIIHYxIDAzLzEwXSBjbGs6IGFzdDI3MDA6IGFkZCBjbG9jayBj?=
 =?big5?Q?ontroller?=
In-Reply-To: <fb3489cf-b288-426e-ace0-abf1d6b0fe0c@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-4-kevin_chen@aspeedtech.com>
 <fb3489cf-b288-426e-ace0-abf1d6b0fe0c@kernel.org>
Message-ID: <PSAPR06MB4949585D1558386AC9FC463E89802@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

I will speperate clock part in the v3 patch into Ryan's clock series.


>So you did not write commit msgs to none of the commits?
>
>> ---
>>  drivers/clk/Makefile      |    1 +
>>  drivers/clk/clk-ast2700.c | 1166 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 1167 insertions(+)
>>  create mode 100644 drivers/clk/clk-ast2700.c
>>
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index f793a16cad40..0d5992ea0fa4 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -38,6 +38,7 @@ obj-$(CONFIG_COMMON_CLK_FSL_SAI)    += clk-fsl-sai.o
>>  obj-$(CONFIG_COMMON_CLK_GEMINI)              += clk-gemini.o
>>  obj-$(CONFIG_COMMON_CLK_ASPEED)              += clk-aspeed.o
>>  obj-$(CONFIG_MACH_ASPEED_G6)         += clk-ast2600.o
>> +obj-$(CONFIG_MACH_ASPEED_G7)         += clk-ast2700.o
>
>...
>
>> +
>> +static const char *const pspclk_sel[] = {
>> +     "soc0-mpll",
>> +     "soc0-hpll",
>> +};
>> +
>> +static const char *const soc0_uartclk_sel[] = {
>> +     "soc0-clk24Mhz",
>> +     "soc0-clk192Mhz",
>> +};
>> +
>> +static const char *const emmcclk_sel[] = {
>> +     "soc0-mpll_div4",
>> +     "soc0-hpll_div4",
>> +};
>> +
>> +static int ast2700_soc0_clk_init(struct device_node *soc0_node)
>> +{
>> +     struct clk_hw_onecell_data *clk_data;
>> +     void __iomem *clk_base;
>> +     struct ast2700_reset *reset;
>> +     struct clk_hw **clks;
>> +     int div;
>> +     u32 val;
>> +     int ret;
>> +
>> +     clk_data = kzalloc(struct_size(clk_data, hws, SOC0_NUM_CLKS), GFP_KERNEL);
>> +     if (!clk_data)
>> +             return -ENOMEM;
>> +
>> +     clk_data->num = SOC0_NUM_CLKS;
>> +     clks = clk_data->hws;
>> +
>> +     clk_base = of_iomap(soc0_node, 0);
>> +     if (WARN_ON(IS_ERR(clk_base)))
>
>Drop WARN_ON
I remind Ryan for this fix. He will reply in these series.
[4/4] dt-bindings: clock: Add AST2700 clock bindings - Patchwork (kernel.org)<https://patchwork.kernel.org/project/linux-clk/patch/20240808075937.2756733-5-ryan_chen@aspeedtech.com/>


>> +             return PTR_ERR(clk_base);
>> +
>> +     reset = kzalloc(sizeof(*reset), GFP_KERNEL);
>> +     if (!reset)
>> +             return -ENOMEM;
>> +
>> +     reset->base = clk_base;
>> +
>> +     reset->rcdev.owner = THIS_MODULE;
>> +     reset->rcdev.nr_resets = SOC0_RESET_NUMS;
>> +     reset->rcdev.ops = &ast2700_reset_ops;
>> +     reset->rcdev.of_node = soc0_node;
>> +
>> +     ret = reset_controller_register(&reset->rcdev);
>> +     if (ret) {
>> +             pr_err("soc0 failed to register reset controller\n");
>> +             return ret;
>> +     }
>> +
>> +     //refclk
>
>Weird comment. Please read Coding Style.
I remind Ryan for this fix. He will reply in these series.
[4/4] dt-bindings: clock: Add AST2700 clock bindings - Patchwork (kernel.org)<https://patchwork.kernel.org/project/linux-clk/patch/20240808075937.2756733-5-ryan_chen@aspeedtech.com/>

>
>
>> +     clks[SCU0_CLKIN] =
>> +             clk_hw_register_fixed_rate(NULL, "soc0-clkin", NULL, 0, SCU_CLK_25MHZ);
>> +
>> +     clks[SCU0_CLK_24M] =
>> +             clk_hw_register_fixed_rate(NULL, "soc0-clk24Mhz", NULL, 0, SCU_CLK_24MHZ);
>> +
>> +     clks[SCU0_CLK_192M] =
>> +             clk_hw_register_fixed_rate(NULL, "soc0-clk192Mhz", NULL, 0, SCU_CLK_192MHZ);
>> +
>> +     //hpll
>> +     val = readl(clk_base + SCU0_HWSTRAP1);
>> +     if ((val & GENMASK(3, 2)) != 0) {
>> +             switch ((val & GENMASK(3, 2)) >> 2) {
>> +             case 1:
>> +                     clks[SCU0_CLK_HPLL] =
>> +                             clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1900000000);
>> +                     break;
>> +             case 2:
>> +                     clks[SCU0_CLK_HPLL] =
>> +                             clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1800000000);
>> +                     break;
>> +             case 3:
>> +                     clks[SCU0_CLK_HPLL] =
>> +                             clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1700000000);
>> +                     break;
>> +             }
>> +     } else {
>> +             val = readl(clk_base + SCU0_HPLL_PARAM);
>> +             clks[SCU0_CLK_HPLL] = ast2700_soc0_hw_pll("soc0-hpll", "soc0-clkin", val);
>> +     }
>> +     clks[SCU0_CLK_HPLL_DIV2] = clk_hw_register_fixed_factor(NULL, "soc0-hpll_div2", "soc0-hpll", 0, 1, 2);
>> +     clks[SCU0_CLK_HPLL_DIV4] = clk_hw_register_fixed_factor(NULL, "soc0-hpll_div4", "soc0-hpll", 0, 1, 4);
>> +
>> +     //dpll
>

--
Best Regards,
Kevin. Chen

________________________________
???: Krzysztof Kozlowski <krzk@kernel.org>
????: 2024?7?26? ?? 07:13
???: Kevin Chen <kevin_chen@aspeedtech.com>; robh at kernel.org <robh@kernel.org>; krzk+dt at kernel.org <krzk+dt@kernel.org>; conor+dt at kernel.org <conor+dt@kernel.org>; joel at jms.id.au <joel@jms.id.au>; andrew at codeconstruct.com.au <andrew@codeconstruct.com.au>; lee at kernel.org <lee@kernel.org>; catalin.marinas at arm.com <catalin.marinas@arm.com>; will at kernel.org <will@kernel.org>; arnd at arndb.de <arnd@arndb.de>; olof at lixom.net <olof@lixom.net>; soc at kernel.org <soc@kernel.org>; mturquette at baylibre.com <mturquette@baylibre.com>; sboyd at kernel.org <sboyd@kernel.org>; p.zabel at pengutronix.de <p.zabel@pengutronix.de>; quic_bjorande at quicinc.com <quic_bjorande@quicinc.com>; geert+renesas at glider.be <geert+renesas@glider.be>; dmitry.baryshkov at linaro.org <dmitry.baryshkov@linaro.org>; shawnguo at kernel.org <shawnguo@kernel.org>; neil.armstrong at linaro.org <neil.armstrong@linaro.org>; m.szyprowski at samsung.com <m.szyprowski@samsung.com>; nfraprado at collabora.com <nfraprado@collabora.com>; u-kumar1 at ti.com <u-kumar1@ti.com>; devicetree at vger.kernel.org <devicetree@vger.kernel.org>; linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>; linux-aspeed at lists.ozlabs.org <linux-aspeed@lists.ozlabs.org>; linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>; linux-clk at vger.kernel.org <linux-clk@vger.kernel.org>
??: Re: [PATCH v1 03/10] clk: ast2700: add clock controller

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
> @@ -38,6 +38,7 @@ obj-$(CONFIG_COMMON_CLK_FSL_SAI)    += clk-fsl-sai.o
>  obj-$(CONFIG_COMMON_CLK_GEMINI)              += clk-gemini.o
>  obj-$(CONFIG_COMMON_CLK_ASPEED)              += clk-aspeed.o
>  obj-$(CONFIG_MACH_ASPEED_G6)         += clk-ast2600.o
> +obj-$(CONFIG_MACH_ASPEED_G7)         += clk-ast2700.o

...

> +
> +static const char *const pspclk_sel[] = {
> +     "soc0-mpll",
> +     "soc0-hpll",
> +};
> +
> +static const char *const soc0_uartclk_sel[] = {
> +     "soc0-clk24Mhz",
> +     "soc0-clk192Mhz",
> +};
> +
> +static const char *const emmcclk_sel[] = {
> +     "soc0-mpll_div4",
> +     "soc0-hpll_div4",
> +};
> +
> +static int ast2700_soc0_clk_init(struct device_node *soc0_node)
> +{
> +     struct clk_hw_onecell_data *clk_data;
> +     void __iomem *clk_base;
> +     struct ast2700_reset *reset;
> +     struct clk_hw **clks;
> +     int div;
> +     u32 val;
> +     int ret;
> +
> +     clk_data = kzalloc(struct_size(clk_data, hws, SOC0_NUM_CLKS), GFP_KERNEL);
> +     if (!clk_data)
> +             return -ENOMEM;
> +
> +     clk_data->num = SOC0_NUM_CLKS;
> +     clks = clk_data->hws;
> +
> +     clk_base = of_iomap(soc0_node, 0);
> +     if (WARN_ON(IS_ERR(clk_base)))

Drop WARN_ON

> +             return PTR_ERR(clk_base);
> +
> +     reset = kzalloc(sizeof(*reset), GFP_KERNEL);
> +     if (!reset)
> +             return -ENOMEM;
> +
> +     reset->base = clk_base;
> +
> +     reset->rcdev.owner = THIS_MODULE;
> +     reset->rcdev.nr_resets = SOC0_RESET_NUMS;
> +     reset->rcdev.ops = &ast2700_reset_ops;
> +     reset->rcdev.of_node = soc0_node;
> +
> +     ret = reset_controller_register(&reset->rcdev);
> +     if (ret) {
> +             pr_err("soc0 failed to register reset controller\n");
> +             return ret;
> +     }
> +
> +     //refclk

Weird comment. Please read Coding Style.


> +     clks[SCU0_CLKIN] =
> +             clk_hw_register_fixed_rate(NULL, "soc0-clkin", NULL, 0, SCU_CLK_25MHZ);
> +
> +     clks[SCU0_CLK_24M] =
> +             clk_hw_register_fixed_rate(NULL, "soc0-clk24Mhz", NULL, 0, SCU_CLK_24MHZ);
> +
> +     clks[SCU0_CLK_192M] =
> +             clk_hw_register_fixed_rate(NULL, "soc0-clk192Mhz", NULL, 0, SCU_CLK_192MHZ);
> +
> +     //hpll
> +     val = readl(clk_base + SCU0_HWSTRAP1);
> +     if ((val & GENMASK(3, 2)) != 0) {
> +             switch ((val & GENMASK(3, 2)) >> 2) {
> +             case 1:
> +                     clks[SCU0_CLK_HPLL] =
> +                             clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1900000000);
> +                     break;
> +             case 2:
> +                     clks[SCU0_CLK_HPLL] =
> +                             clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1800000000);
> +                     break;
> +             case 3:
> +                     clks[SCU0_CLK_HPLL] =
> +                             clk_hw_register_fixed_rate(NULL, "soc0-hpll", NULL, 0, 1700000000);
> +                     break;
> +             }
> +     } else {
> +             val = readl(clk_base + SCU0_HPLL_PARAM);
> +             clks[SCU0_CLK_HPLL] = ast2700_soc0_hw_pll("soc0-hpll", "soc0-clkin", val);
> +     }
> +     clks[SCU0_CLK_HPLL_DIV2] = clk_hw_register_fixed_factor(NULL, "soc0-hpll_div2", "soc0-hpll", 0, 1, 2);
> +     clks[SCU0_CLK_HPLL_DIV4] = clk_hw_register_fixed_factor(NULL, "soc0-hpll_div4", "soc0-hpll", 0, 1, 4);
> +
> +     //dpll



Best regards,
Krzysztof

************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240815/7113cfd0/attachment-0001.htm>
