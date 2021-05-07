From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 07 May 2021 11:43:49 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v3_4/5]_mmc:_sdhci-of-aspeed:_Add_a_helper_for_upda?=
 =?UTF-8?Q?ting_capability_register.?=
In-Reply-To: <20210506100312.1638-5-steven_lee@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-5-steven_lee@aspeedtech.com>
Message-ID: <fecc9021-ab4b-4047-a664-47b1bd867cb3@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Steven,

I have some minor comments. I expect you're going to do a v4 of the 
series, so if you'd like to clean them up in the process I'd appreciate 
it.

However, from a pragmatic standpoint I think the patch is in good shape.

On Thu, 6 May 2021, at 19:33, Steven Lee wrote:
> The patch add a new function aspeed_sdc_set_slot_capability() for
> updating sdhci capability register.

The commit message should explain why the patch is necessary and not 
what it does, as what it does is contained in the diff.

It's okay to explain *how* the patch acheives its goals if the 
implementation is subtle or complex.

Maybe the commit message could be something like:


```
Configure the SDHCIs as specified by the devicetree.

The hardware provides capability configuration registers for each SDHCI 
in the global configuration space for the SD controller. Writes to the 
global capability registers are mirrored to the capability registers in 
the associated SDHCI. Configuration of the capabilities must be written 
through the mirror registers prior to initialisation of the SDHCI.
```

> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 57 ++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c 
> b/drivers/mmc/host/sdhci-of-aspeed.c
> index d001c51074a0..4979f98ffb52 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -31,6 +31,11 @@
>  #define   ASPEED_SDC_S0_PHASE_OUT_EN	GENMASK(1, 0)
>  #define   ASPEED_SDC_PHASE_MAX		31
>  
> +/* SDIO{10,20} */
> +#define ASPEED_SDC_CAP1_1_8V           (0 * 32 + 26)
> +/* SDIO{14,24} */
> +#define ASPEED_SDC_CAP2_SDR104         (1 * 32 + 1)
> +
>  struct aspeed_sdc {
>  	struct clk *clk;
>  	struct resource *res;
> @@ -70,8 +75,42 @@ struct aspeed_sdhci {
>  	u32 width_mask;
>  	struct mmc_clk_phase_map phase_map;
>  	const struct aspeed_sdhci_phase_desc *phase_desc;
> +
>  };
>  
> +/*
> + * The function sets the mirror register for updating
> + * capbilities of the current slot.
> + *
> + *   slot | capability  | caps_reg | mirror_reg
> + *   -----|-------------|----------|------------
> + *     0  | CAP1_1_8V   | SDIO140  |   SDIO10
> + *     0  | CAP2_SDR104 | SDIO144  |   SDIO14
> + *     1  | CAP1_1_8V   | SDIO240  |   SDIO20
> + *     1  | CAP2_SDR104 | SDIO244  |   SDIO24

It would be nice to align the columns to improve readability.

> + */
> +static void aspeed_sdc_set_slot_capability(struct sdhci_host *host,
> +					   struct aspeed_sdc *sdc,
> +					   int capability,
> +					   bool enable,
> +					   u8 slot)

I prefer we don't take up so much vertical space here. I think this 
could be just a couple of lines with multiple variables per line. We 
can go to 100 chars per line.

> +{
> +	u8 cap_reg;
> +	u32 mirror_reg_offset, cap_val;

The rest of the driver follows "reverse christmas tree" (longest to 
shortest declaration) style, so I prefer we try to maintain consistency 
where we can. Essentially, declare them in this order:

u32 mirror_reg_offset;
u32 cap_val;
u8 cap_reg;

> +
> +	if (slot > 1)
> +		return;
> +
> +	cap_reg = capability / 32;
> +	cap_val = sdhci_readl(host, 0x40 + (cap_reg * 4));
> +	if (enable)
> +		cap_val |= BIT(capability % 32);
> +	else
> +		cap_val &= ~BIT(capability % 32);
> +	mirror_reg_offset = ((slot + 1) * 0x10) + (cap_reg * 4);
> +	writel(cap_val, sdc->regs + mirror_reg_offset);
> +}
> +
>  static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
>  					   struct aspeed_sdhci *sdhci,
>  					   bool bus8)
> @@ -329,6 +368,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>  {
>  	const struct aspeed_sdhci_pdata *aspeed_pdata;
>  	struct sdhci_pltfm_host *pltfm_host;
> +	struct device_node *np = pdev->dev.of_node;

Again here with the reverse-christmas-tree style, so:

const struct aspeed_sdhci_pdata *aspeed_pdata;
struct device_node *np = pdev->dev.of_node;
struct sdhci_pltfm_host *pltfm_host;
...

>  	struct aspeed_sdhci *dev;
>  	struct sdhci_host *host;
>  	struct resource *res;
> @@ -372,6 +412,23 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>  
>  	sdhci_get_of_property(pdev);
>  
> +	if (of_property_read_bool(np, "mmc-hs200-1_8v") ||
> +	    of_property_read_bool(np, "sd-uhs-sdr104")) {
> +		aspeed_sdc_set_slot_capability(host,
> +					       dev->parent,
> +					       ASPEED_SDC_CAP1_1_8V,
> +					       true,
> +					       slot);

Again, this would be nicer if we compress it to as few lines as possible.

> +	}
> +
> +	if (of_property_read_bool(np, "sd-uhs-sdr104")) {
> +		aspeed_sdc_set_slot_capability(host,
> +					       dev->parent,
> +					       ASPEED_SDC_CAP2_SDR104,
> +					       true,
> +					       slot);

As above.

Cheers,

Andrew
