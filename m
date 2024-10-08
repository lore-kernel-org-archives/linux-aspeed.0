From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 8 Oct 2024 03:41:30 +0000
Subject: [PATCH v2 4/9] clk: ast2700: add clock controller
In-Reply-To: <PSAPR06MB494955CE22685AC0F21A3A98897E2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
 <20240802090544.2741206-6-kevin_chen@aspeedtech.com>
 <CAA8EJprhpv2i9Y=8FAW+fDi_TMJYLw8KO+GtbA4oPHuK+Kgq_A@mail.gmail.com>
 <PSAPR06MB494955CE22685AC0F21A3A98897E2@PSAPR06MB4949.apcprd06.prod.outlook.com>
Message-ID: <OS8PR06MB754179E193E4D9B9E579D0E8F27E2@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Dmitry,
	Thanks, your review.
	I will update in my next clk patch.
	And include you in review email.

> Subject: RE: [PATCH v2 4/9] clk: ast2700: add clock controller
> 
> > >
> > > Add support for ast2700 clock controller.
> > >
> > > Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> > > ---
> > >  drivers/clk/Makefile      |    1 +
> > >  drivers/clk/clk-ast2700.c | 1173
> > > +++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 1174 insertions(+)  create mode 100644
> > > drivers/clk/clk-ast2700.c
> > >
> > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile index
> > > f793a16cad40..0d5992ea0fa4 100644
> > > --- a/drivers/clk/Makefile
> > > +++ b/drivers/clk/Makefile
> > > @@ -38,6 +38,7 @@ obj-$(CONFIG_COMMON_CLK_FSL_SAI)      +=
> > clk-fsl-sai.o
> > >  obj-$(CONFIG_COMMON_CLK_GEMINI)                +=
> clk-gemini.o
> > >  obj-$(CONFIG_COMMON_CLK_ASPEED)                +=
> clk-aspeed.o
> > >  obj-$(CONFIG_MACH_ASPEED_G6)           += clk-ast2600.o
> > > +obj-$(CONFIG_MACH_ASPEED_G7)           += clk-ast2700.o
> > >  obj-$(CONFIG_ARCH_HIGHBANK)            += clk-highbank.o
> > >  obj-$(CONFIG_CLK_HSDK)                 += clk-hsdk-pll.o
> > >  obj-$(CONFIG_COMMON_CLK_K210)          += clk-k210.o
> > > diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c
> > > new file mode 100644 index 000000000000..eec8e0cb83d9
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-ast2700.c
> > > @@ -0,0 +1,1173 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later // Copyright ASPEED
> > > +Technology
> > > +
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/reset-controller.h>
> > > +
> > > +#include <dt-bindings/clock/aspeed,ast2700-clk.h>
> > > +#include <dt-bindings/reset/aspeed,ast2700-reset.h>
> > > +
> > > +#define SCU_CLK_24MHZ 24000000
> >
> > Are Aspeed's 24 MHz somehow different from 24 MHz on other platforms?
> > Please use <linux/units.h> and refrain from defining just random
> > values. If it has some special meaning (like XO clock or some other
> > fixed funcion), please use logical names.
> Already split clock and reset to Ryan's commit.
> https://patchwork.kernel.org/project/linux-clk/list/?series=892020
> Please check the series of " Add support for AST2700 clk driver".
> 
> >
> > > +#define SCU_CLK_25MHZ 25000000
> > > +#define SCU_CLK_192MHZ 192000000
> > > +/* SOC0 USB2 PHY CLK*/
> > > +#define SCU_CLK_12MHZ 12000000
> >
> > So, this can be #define ASPEED_SOC0_USB2_PHY_RATE (12 * HZ_PER_MHZ)
> Already split clock and reset to Ryan's commit.
> https://patchwork.kernel.org/project/linux-clk/list/?series=892020
> Please check the series of " Add support for AST2700 clk driver".
> 
> >
> > > +/* SOC0 */
> > > +#define SCU0_HWSTRAP1 0x010
> > > +#define SCU0_CLK_STOP 0x240
> > > +#define SCU0_CLK_SEL1 0x280
> > > +#define SCU0_CLK_SEL2 0x284
> > > +#define GET_USB_REFCLK_DIV(x) ((GENMASK(23, 20) & (x)) >> 20)
> > > +#define UART_DIV13_EN BIT(30) #define SCU0_HPLL_PARAM 0x300
> #define
> > > +SCU0_DPLL_PARAM 0x308 #define SCU0_MPLL_PARAM 0x310 #define
> > > +SCU0_D1CLK_PARAM 0x320 #define SCU0_D2CLK_PARAM 0x330 #define
> > > +SCU0_CRT1CLK_PARAM 0x340 #define SCU0_CRT2CLK_PARAM 0x350
> > #define
> > > +SCU0_MPHYCLK_PARAM 0x360
> > > +
> > > +/* SOC1 */
> > > +#define SCU1_CLK_STOP 0x240
> > > +#define SCU1_CLK_STOP2 0x260
> > > +#define SCU1_CLK_SEL1 0x280
> > > +#define SCU1_CLK_SEL2 0x284
> > > +#define UXCLK_MASK GENMASK(1, 0)
> > > +#define HUXCLK_MASK GENMASK(4, 3)
> > > +#define SCU1_HPLL_PARAM 0x300
> > > +#define SCU1_APLL_PARAM 0x310
> > > +#define SCU1_DPLL_PARAM 0x320
> > > +#define SCU1_UXCLK_CTRL 0x330
> > > +#define SCU1_HUXCLK_CTRL 0x334
> > > +#define SCU1_MAC12_CLK_DLY 0x390
> > > +#define SCU1_MAC12_CLK_DLY_100M 0x394 #define
> > SCU1_MAC12_CLK_DLY_10M
> > > +0x398
> > > +
> > > +/*
> > > + * MAC Clock Delay settings
> > > + */
> > > +#define MAC_CLK_RMII1_50M_RCLK_O_CTRL          BIT(30)
> > > +#define   MAC_CLK_RMII1_50M_RCLK_O_DIS         0
> > > +#define   MAC_CLK_RMII1_50M_RCLK_O_EN          1
> > > +#define MAC_CLK_RMII0_50M_RCLK_O_CTRL          BIT(29)
> > > +#define   MAC_CLK_RMII0_5M_RCLK_O_DIS          0
> > > +#define   MAC_CLK_RMII0_5M_RCLK_O_EN           1
> > > +#define MAC_CLK_RMII_TXD_FALLING_2             BIT(27)
> > > +#define MAC_CLK_RMII_TXD_FALLING_1             BIT(26)
> > > +#define MAC_CLK_RXCLK_INV_2                    BIT(25)
> > > +#define MAC_CLK_RXCLK_INV_1                    BIT(24)
> > > +#define MAC_CLK_1G_INPUT_DELAY_2               GENMASK(23,
> 18)
> > > +#define MAC_CLK_1G_INPUT_DELAY_1               GENMASK(17,
> 12)
> > > +#define MAC_CLK_1G_OUTPUT_DELAY_2              GENMASK(11,
> 6)
> > > +#define MAC_CLK_1G_OUTPUT_DELAY_1              GENMASK(5,
> 0)
> > > +
> > > +#define MAC_CLK_100M_10M_RESERVED
> GENMASK(31,
> > 26)
> > > +#define MAC_CLK_100M_10M_RXCLK_INV_2           BIT(25)
> > > +#define MAC_CLK_100M_10M_RXCLK_INV_1           BIT(24)
> > > +#define MAC_CLK_100M_10M_INPUT_DELAY_2
> GENMASK(23,
> > 18)
> > > +#define MAC_CLK_100M_10M_INPUT_DELAY_1
> GENMASK(17,
> > 12)
> > > +#define MAC_CLK_100M_10M_OUTPUT_DELAY_2
> > GENMASK(11, 6)
> > > +#define MAC_CLK_100M_10M_OUTPUT_DELAY_1
> > GENMASK(5, 0)
> > > +
> > > +#define AST2700_DEF_MAC12_DELAY_1G     0x00CF4D75
> >
> > lowcase hex, please.
> Already split clock and reset to Ryan's commit.
> https://patchwork.kernel.org/project/linux-clk/list/?series=892020
> Please check the series of " Add support for AST2700 clk driver".
> 
> >
> > > +#define AST2700_DEF_MAC12_DELAY_100M   0x00410410
> > > +#define AST2700_DEF_MAC12_DELAY_10M    0x00410410
> > > +
> > > +struct mac_delay_config {
> > > +       u32 tx_delay_1000;
> > > +       u32 rx_delay_1000;
> > > +       u32 tx_delay_100;
> > > +       u32 rx_delay_100;
> > > +       u32 tx_delay_10;
> > > +       u32 rx_delay_10;
> > > +};
> > > +
> > > +/* Globally visible clocks */
> > > +static DEFINE_SPINLOCK(ast2700_clk_lock);
> > > +
> > > +/* Division of RGMII Clock */
> > > +static const struct clk_div_table ast2700_rgmii_div_table[] = {
> > > +       { 0x0, 4 },
> > > +       { 0x1, 4 },
> > > +       { 0x2, 6 },
> > > +       { 0x3, 8 },
> > > +       { 0x4, 10 },
> > > +       { 0x5, 12 },
> > > +       { 0x6, 14 },
> > > +       { 0x7, 16 },
> > > +       { 0 }
> > > +};
> > > +
> > > +/* Division of RMII Clock */
> > > +static const struct clk_div_table ast2700_rmii_div_table[] = {
> > > +       { 0x0, 8 },
> > > +       { 0x1, 8 },
> > > +       { 0x2, 12 },
> > > +       { 0x3, 16 },
> > > +       { 0x4, 20 },
> > > +       { 0x5, 24 },
> > > +       { 0x6, 28 },
> > > +       { 0x7, 32 },
> > > +       { 0 }
> > > +};
> > > +
> > > +/* Division of HCLK/SDIO/MAC/apll_divn CLK */ static const struct
> > > +clk_div_table ast2700_clk_div_table[] = {
> > > +       { 0x0, 2 },
> > > +       { 0x1, 2 },
> > > +       { 0x2, 3 },
> > > +       { 0x3, 4 },
> > > +       { 0x4, 5 },
> > > +       { 0x5, 6 },
> > > +       { 0x6, 7 },
> > > +       { 0x7, 8 },
> > > +       { 0 }
> > > +};
> > > +
> > > +/* Division of PCLK/EMMC CLK */
> > > +static const struct clk_div_table ast2700_clk_div_table2[] = {
> > > +       { 0x0, 2 },
> > > +       { 0x1, 4 },
> > > +       { 0x2, 6 },
> > > +       { 0x3, 8 },
> > > +       { 0x4, 10 },
> > > +       { 0x5, 12 },
> > > +       { 0x6, 14 },
> > > +       { 0x7, 16 },
> > > +       { 0 }
> > > +};
> > > +
> > > +/* HPLL/DPLL: 2000Mhz(default) */
> > > +static struct clk_hw *ast2700_soc0_hw_pll(const char *name, const
> > > +char *parent_name, u32 val)
> >
> > Please migrate from using parent_names to either using parent_hw or
> > using fwname to specify the parent clock.
> Already split clock and reset to Ryan's commit.
> https://patchwork.kernel.org/project/linux-clk/list/?series=892020
> Please check the series of " Add support for AST2700 clk driver".
> 
> >
> > > +{
> > > +       unsigned int mult, div;
> > > +
> > > +       if (val & BIT(24)) {
> > > +               /* Pass through mode */
> > > +               mult = 1;
> > > +               div = 1;
> > > +       } else {
> > > +               /* F = CLKIN(25MHz) * [(M+1) / 2(N+1)] / (P+1) */
> > > +               u32 m = val & 0x1fff;
> > > +               u32 n = (val >> 13) & 0x3f;
> > > +               u32 p = (val >> 19) & 0xf;
> > > +
> > > +               mult = (m + 1) / (2 * (n + 1));
> > > +               div = (p + 1);
> > > +       }
> > > +
> > > +       return clk_hw_register_fixed_factor(NULL, name, parent_name,
> > > +0, mult, div); };
> > > +
> > > +/* MPLL 1600Mhz(default) */
> > > +static struct clk_hw *ast2700_calc_mpll(const char *name, const
> > > +char *parent_name, u32 val) {
> > > +       unsigned int mult, div;
> > > +
> > > +       if (val & BIT(24)) {
> > > +               /* Pass through mode */
> > > +               div = 1;
> > > +               mult = div;
> > > +       } else {
> > > +               /* F = CLKIN(25MHz) * [CLKF/(CLKR+1)] /(CLKOD+1) */
> > > +               u32 m = val & 0x1fff;
> > > +               u32 n = (val >> 13) & 0x3f;
> > > +               u32 p = (val >> 19) & 0xf;
> > > +
> > > +               mult = m / (n + 1);
> > > +               div = (p + 1);
> > > +       }
> > > +       return clk_hw_register_fixed_factor(NULL, name, parent_name,
> > > +0, mult, div); };
> > > +
> > > +static struct clk_hw *ast2700_calc_uclk(const char *name, u32 val) {
> > > +       unsigned int mult, div;
> > > +
> > > +       /* UARTCLK = UXCLK * R / (N * 2) */
> > > +       u32 r = val & 0xff;
> > > +       u32 n = (val >> 8) & 0x3ff;
> > > +
> > > +       mult = r;
> > > +       div = n * 2;
> > > +
> > > +       return clk_hw_register_fixed_factor(NULL, name, "uxclk", 0,
> > > +mult, div); };
> > > +
> > > +static struct clk_hw *ast2700_calc_huclk(const char *name, u32 val) {
> > > +       unsigned int mult, div;
> > > +
> > > +       /* UARTCLK = UXCLK * R / (N * 2) */
> > > +       u32 r = val & 0xff;
> > > +       u32 n = (val >> 8) & 0x3ff;
> > > +
> > > +       mult = r;
> > > +       div = n * 2;
> > > +
> > > +       return clk_hw_register_fixed_factor(NULL, name, "huxclk", 0,
> > > +mult, div); };
> > > +
> > > +static struct clk_hw *ast2700_calc_soc1_pll(const char *name, const
> > > +char *parent_name, u32 val)
> >
> > How is this different from ast2700_soc0_hw_pll() ?
> Already split clock and reset to Ryan's commit.
> https://patchwork.kernel.org/project/linux-clk/list/?series=892020
> Please check the series of " Add support for AST2700 clk driver".
> 
> >
> > > +{
> > > +       unsigned int mult, div;
> > > +
> > > +       if (val & BIT(24)) {
> > > +               /* Pass through mode */
> > > +               div = 1;
> > > +               mult = div;
> > > +       } else {
> > > +               /* F = 25Mhz * [(M + 1) / (n + 1)] / (p + 1) */
> > > +               u32 m = val & 0x1fff;
> > > +               u32 n = (val >> 13) & 0x3f;
> > > +               u32 p = (val >> 19) & 0xf;
> > > +
> > > +               mult = (m + 1) / (n + 1);
> > > +               div = (p + 1);
> > > +       }
> > > +       return clk_hw_register_fixed_factor(NULL, name, parent_name,
> > > +0, mult, div); };
> > > +
> >
> >
> > --
> > With best wishes
> > Dmitry
