From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 13 Apr 2021 08:48:16 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v1_2/2]_mmc:_sdhci-of-aspeed:_Support_toggling_SD_b?=
 =?UTF-8?Q?us_signal_voltage_by_GPIO?=
In-Reply-To: <20210412065032.GC23408@aspeedtech.com>
References: <20210408015218.20560-1-steven_lee@aspeedtech.com>
 <20210408015218.20560-3-steven_lee@aspeedtech.com>
 <acaa2cc2-9b12-442e-a767-3c4b41affa21@www.fastmail.com>
 <20210412065032.GC23408@aspeedtech.com>
Message-ID: <11b63819-d37c-406d-9ebf-424d226a6839@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 12 Apr 2021, at 16:20, Steven Lee wrote:
> The 04/09/2021 12:14, Andrew Jeffery wrote:
> > Hi Steven,
> > 
> > On Thu, 8 Apr 2021, at 11:22, Steven Lee wrote:
> > > AST2600-A2 EVB provides reference design to support toggling signal
> > > voltage between 3.3v and 1.8v by power-switch-gpio pin that defined in
> > > the device tree.
> > 
> > Is this something you think we need support for beyond the EVB? It 
> > sounds a lot like a knob to enable testing of different SD/MMC power 
> > configurations and not something that you'd otherwise see in a system 
> > design.
> >
> 
> It can be used for testing different SD power configuration.
> The main purpose of the patch is letting the driver has the ability to 
> change the bus voltage for switching SD bus speed between UHS-I mode and
> normal/high speed mode in AST2600-A2 EVB according to the value of
> power-switch-gpio that defined in the device tree. 

Ah okay. I'm not strong on all the power requirements for each of the 
bus modes :)

> But I am not sure whether it needs to be support in mainline kernel.
> Since it requires a particular hardware circuit design outside of ASPEED
> AST2600 SoC, and AST2600-A2 EVB does have that design.

This shouldn't be a problem with Uffe's suggestion on the binding patch.

Better to have support in mainline than maintain out-of-tree patches!

> 
> > > It also supporting enabling/disabling SD bus power by
> > > power-gpio.
> > 
> > This sounds like it could be useful but I'll defer to Ulf with regards 
> > to the binding.
> > 
> > > 
> > > In the reference design, GPIOV0 of AST2600-A2 EVB is connected to power
> > > load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is connected to
> > > a 1.8v and a 3.3v power load switch that providing signal voltage to
> > > SD1 bus.
> > > If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> > > disabled.
> > > If GPIOV1 is active high, 3.3v power load switch is enabled, SD1 signal
> > > voltage is 3.3v, otherwise, 1.8v power load switch will be enabled, SD1
> > > signal voltage becomes 1.8v.
> > > 
> > > AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> > > The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and
> > > GPIOV3 as power-switch-gpio.
> > > 
> > > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > > ---
> > >  drivers/mmc/host/sdhci-of-aspeed.c | 155 +++++++++++++++++++++++++----
> > >  1 file changed, 137 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c 
> > > b/drivers/mmc/host/sdhci-of-aspeed.c
> > > index 7d8692e90996..a74a03d37915 100644
> > > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/clk.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/device.h>
> > > +#include <linux/gpio/consumer.h>
> > >  #include <linux/io.h>
> > >  #include <linux/math64.h>
> > >  #include <linux/mmc/host.h>
> > > @@ -30,6 +31,7 @@
> > >  #define   ASPEED_SDC_S0_PHASE_IN_EN	BIT(2)
> > >  #define   ASPEED_SDC_S0_PHASE_OUT_EN	GENMASK(1, 0)
> > >  #define   ASPEED_SDC_PHASE_MAX		31
> > > +#define ASPEED_CLOCK_PHASE 0xf4
> > 
> > This isn't related to the power GPIOs, and we already have phase 
> > support as suggested by the macros immediately above the one you've 
> > added here.
> > 
> > Please remove it and make use of the existing mmc phase devicetree 
> > binding and driver support.
> > 
> 
> Will remove it.
> 
> > >  
> > >  struct aspeed_sdc {
> > >  	struct clk *clk;
> > > @@ -58,18 +60,21 @@ struct aspeed_sdhci_phase_desc {
> > >  	struct aspeed_sdhci_tap_desc out;
> > >  };
> > >  
> > > -struct aspeed_sdhci_pdata {
> > > +struct aspeed_sdhci_data {
> > 
> > Why are we renaming this? It looks like it creates a lot of noise in 
> > the patch. The data it captured was platform data, hence 'pdata' in the 
> > name. In my opinon it's fine if we also have a member called pdata.
> > 
> 
> Since I add a new member in aspeed_sdhci_pdata(In the patch, it is named
> aspeed_sdhci_data) for separating the platform data of aspeed-g5 and
> aspped-g6, the type of the member is sdhci_pltfm_data.
> Therefore, I use the pdata for my new created member and renamed the
> original pdata as data as follows.
> 
> static const struct of_device_id aspeed_sdhci_of_match[] = {
>   { .compatible = "aspeed,ast2400-sdhci", .data = &ast2400_sdhci_data, },
> };
> 
> static const struct aspeed_sdhci_data ast2400_sdhci_data = {
>   .clk_div_start = 2,
>   .pdata = &ast2400_sdhci_pdata,
> };
> 
> 
> Regardless, I will revert it to the original name and rename
> my new created variable.
> 
> > >  	unsigned int clk_div_start;
> > >  	const struct aspeed_sdhci_phase_desc *phase_desc;
> > >  	size_t nr_phase_descs;
> > > +	const struct sdhci_pltfm_data *pdata;
> > >  };
> > >  
> > >  struct aspeed_sdhci {
> > > -	const struct aspeed_sdhci_pdata *pdata;
> > > +	const struct aspeed_sdhci_data *data;
> > >  	struct aspeed_sdc *parent;
> > >  	u32 width_mask;
> > >  	struct mmc_clk_phase_map phase_map;
> > >  	const struct aspeed_sdhci_phase_desc *phase_desc;
> > > +	struct gpio_desc *pwr_pin;
> > > +	struct gpio_desc *pwr_sw_pin;
> > >  };
> > >  
> > >  static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
> > > @@ -209,7 +214,6 @@ static void aspeed_sdhci_set_clock(struct 
> > > sdhci_host *host, unsigned int clock)
> > >  	sdhci = sdhci_pltfm_priv(pltfm_host);
> > >  
> > >  	parent = clk_get_rate(pltfm_host->clk);
> > > -
> > 
> > Unrelated whitespace cleanup.
> > 
> > >  	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > >  
> > >  	if (clock == 0)
> > > @@ -234,14 +238,13 @@ static void aspeed_sdhci_set_clock(struct 
> > > sdhci_host *host, unsigned int clock)
> > >  	 * supporting the value 0 in (EMMC12C[7:6], EMMC12C[15:8]), and 
> > > capture
> > >  	 * the 0-value capability in clk_div_start.
> > >  	 */
> > > -	for (div = sdhci->pdata->clk_div_start; div < 256; div *= 2) {
> > > +	for (div = sdhci->data->clk_div_start; div < 256; div *= 2) {
> > >  		bus = parent / div;
> > >  		if (bus <= clock)
> > >  			break;
> > >  	}
> > >  
> > >  	div >>= 1;
> > > -
> > 
> > Unrelated whitespace cleanup.
> > 
> > >  	clk = div << SDHCI_DIVIDER_SHIFT;
> > >  
> > >  	aspeed_sdhci_configure_phase(host, bus);
> > > @@ -292,8 +295,78 @@ static u32 aspeed_sdhci_readl(struct sdhci_host 
> > > *host, int reg)
> > >  	return val;
> > >  }
> > >  
> > > +static void sdhci_aspeed_set_power(struct sdhci_host *host, unsigned char mode,
> > > +				   unsigned short vdd)
> > > +{
> > > +	struct sdhci_pltfm_host *pltfm_priv = sdhci_priv(host);
> > > +	struct aspeed_sdhci *dev = sdhci_pltfm_priv(pltfm_priv);
> > > +	u8 pwr = 0;
> > > +
> > > +	if (!dev->pwr_pin)
> > > +		return sdhci_set_power(host, mode, vdd);
> > > +
> > > +	if (mode != MMC_POWER_OFF) {
> > > +		switch (1 << vdd) {
> > > +		case MMC_VDD_165_195:
> > > +		/*
> > > +		 * Without a regulator, SDHCI does not support 2.0v
> > > +		 * so we only get here if the driver deliberately
> > > +		 * added the 2.0v range to ocr_avail. Map it to 1.8v
> > > +		 * for the purpose of turning on the power.
> > > +		 */
> > > +		case MMC_VDD_20_21:
> > > +				pwr = SDHCI_POWER_180;
> > > +				break;
> > > +		case MMC_VDD_29_30:
> > > +		case MMC_VDD_30_31:
> > > +				pwr = SDHCI_POWER_300;
> > > +				break;
> > > +		case MMC_VDD_32_33:
> > > +		case MMC_VDD_33_34:
> > > +				pwr = SDHCI_POWER_330;
> > > +				break;
> > > +		default:
> > > +				WARN(1, "%s: Invalid vdd %#x\n",
> > > +				     mmc_hostname(host->mmc), vdd);
> > > +				break;
> > > +		}
> > > +	}
> > > +
> > > +	if (host->pwr == pwr)
> > > +		return;
> > > +
> > > +	host->pwr = pwr;
> > > +
> > > +	if (pwr == 0) {
> > 
> > Shouldn't we be testing against an SDHCI_POWER_* macro?
> > 
> 
> It is copied from sdhci_set_power_noreg() of sdhci.c
> The difference is we need to change the bus voltage before writing
> SDHCI_POWER_CONTROL.
> Since There are only SDHCI_POWER_ON, SDHCI_POWER_180, SDHCI_POWER_300,
> and SDHCI_POWER_330 defined in sdhci.h.
> Do you mean pwr should be checked with SDHCI_POWER_ON, SDHCI_POWER_180,
> SDHCI_POWER_300, and SDHCI_POWER_330?

No, I was a bit lazy and didn't look at what macros were defined.

Cheers,

Andrew
