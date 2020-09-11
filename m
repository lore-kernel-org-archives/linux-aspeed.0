From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 11 Sep 2020 12:19:12 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_2/3]_mmc:_sdhci-of-aspeed:_Expose_data_sample_phase?=
 =?UTF-8?Q?_delay_tuning?=
In-Reply-To: <CACPK8Xf-jys=F0Uqg-hYH-eDThmd5yOSNeC7+vLhra3GdOK1Zw@mail.gmail.com>
References: <20200910105440.3087723-1-andrew@aj.id.au>
 <20200910105440.3087723-3-andrew@aj.id.au>
 <CACPK8Xf-jys=F0Uqg-hYH-eDThmd5yOSNeC7+vLhra3GdOK1Zw@mail.gmail.com>
Message-ID: <57d48d7a-7cea-4be7-92bd-8f3b93f84a06@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 11 Sep 2020, at 11:32, Joel Stanley wrote:
> On Thu, 10 Sep 2020 at 10:55, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Allow sample phase adjustment to deal with layout or tolerance issues.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/mmc/host/sdhci-of-aspeed.c | 137 +++++++++++++++++++++++++++--
> >  1 file changed, 132 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > index 4f008ba3280e..641accbfcde4 100644
> > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > @@ -16,9 +16,18 @@
> >
> >  #include "sdhci-pltfm.h"
> >
> > -#define ASPEED_SDC_INFO                0x00
> > -#define   ASPEED_SDC_S1MMC8    BIT(25)
> > -#define   ASPEED_SDC_S0MMC8    BIT(24)
> > +#define ASPEED_SDC_INFO                        0x00
> > +#define   ASPEED_SDC_S1_MMC8           BIT(25)
> > +#define   ASPEED_SDC_S0_MMC8           BIT(24)
> > +#define ASPEED_SDC_PHASE               0xf4
> > +#define   ASPEED_SDC_S1_PHASE_IN       GENMASK(25, 21)
> > +#define   ASPEED_SDC_S0_PHASE_IN       GENMASK(20, 16)
> > +#define   ASPEED_SDC_S1_PHASE_OUT      GENMASK(15, 11)
> > +#define   ASPEED_SDC_S1_PHASE_IN_EN    BIT(10)
> > +#define   ASPEED_SDC_S1_PHASE_OUT_EN   GENMASK(9, 8)
> > +#define   ASPEED_SDC_S0_PHASE_OUT      GENMASK(7, 3)
> > +#define   ASPEED_SDC_S0_PHASE_IN_EN    BIT(2)
> > +#define   ASPEED_SDC_S0_PHASE_OUT_EN   GENMASK(1, 0)
> >
> >  struct aspeed_sdc {
> >         struct clk *clk;
> > @@ -28,9 +37,21 @@ struct aspeed_sdc {
> >         void __iomem *regs;
> >  };
> >
> > +struct aspeed_sdhci_phase_desc {
> > +       u32 value_mask;
> > +       u32 enable_mask;
> > +       u8 enable_value;
> > +};
> > +
> > +struct aspeed_sdhci_phase {
> > +       struct aspeed_sdhci_phase_desc in;
> > +       struct aspeed_sdhci_phase_desc out;
> > +};
> > +
> >  struct aspeed_sdhci {
> >         struct aspeed_sdc *parent;
> >         u32 width_mask;
> > +       const struct aspeed_sdhci_phase *phase;
> >  };
> >
> >  static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
> > @@ -50,6 +71,25 @@ static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
> >         spin_unlock(&sdc->lock);
> >  }
> >
> > +static void
> > +aspeed_sdc_configure_phase(struct aspeed_sdc *sdc,
> > +                          const struct aspeed_sdhci_phase_desc *phase,
> > +                          uint8_t value, bool enable)
> > +{
> > +       u32 reg;
> > +
> > +       spin_lock(&sdc->lock);
> 
> What is the lock protecting against?
> 
> We call this in the ->probe, so there should be no concurrent access going on.

Because the register is in the "global" part of the SD/MMC controller address 
space (it's not part of the SDHCI), and there are multiple slots that may have 
a driver probed concurrently.

> 
> 
> > +       reg = readl(sdc->regs + ASPEED_SDC_PHASE);
> > +       reg &= ~phase->enable_mask;
> > +       if (enable) {
> > +               reg &= ~phase->value_mask;
> > +               reg |= value << __ffs(phase->value_mask);
> > +               reg |= phase->enable_value << __ffs(phase->enable_mask);
> > +       }
> > +       writel(reg, sdc->regs + ASPEED_SDC_PHASE);
> > +       spin_unlock(&sdc->lock);
> > +}
> > +
> >  static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >  {
> >         struct sdhci_pltfm_host *pltfm_host;
> > @@ -155,8 +195,58 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> >         return (delta / 0x100) - 1;
> >  }
> >
> > +static int aspeed_sdhci_configure_of(struct platform_device *pdev,
> > +                                    struct aspeed_sdhci *sdhci)
> > +{
> > +       u32 iphase, ophase;
> > +       struct device_node *np;
> > +       struct device *dev;
> > +       int ret;
> > +
> > +       if (!sdhci->phase)
> > +               return 0;
> > +
> > +       dev = &pdev->dev;
> > +       np = dev->of_node;
> > +
> > +       ret = of_property_read_u32(np, "aspeed,input-phase", &iphase);
> > +       if (ret < 0) {
> > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in, 0,
> > +                                          false);
> 
> Will this clear any value that eg. u-boot writes?

No, see the 'enable' test in aspeed_sdc_configure_phase()

> 
> The register should be left alone if the kernel doesn't have a
> configuration of it's own, otherwise we may end up breaking an
> otherwise working system.

Right, I can rework that.

> 
> > +               dev_dbg(dev, "Input phase configuration disabled");
> > +       } else if (iphase >= (1 << 5)) {
> > +               dev_err(dev,
> > +                       "Input phase value exceeds field range (5 bits): %u",
> > +                       iphase);
> > +               return -ERANGE;
> > +       } else {
> > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in,
> > +                                          iphase, true);
> > +               dev_info(dev, "Input phase relationship: %u", iphase);
> 
> Make theis _dbg, on a normal boot we don't need this chatter in the logs.
> 
> The same comments apply for the output.

Yes, I actually meant to do this before I sent the patches but clearly forgot :)

> 
> > +       }
> > +
> > +       ret = of_property_read_u32(np, "aspeed,output-phase", &ophase);
> > +       if (ret < 0) {
> > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->out, 0,
> > +                                          false);
> > +               dev_dbg(dev, "Output phase configuration disabled");
> > +       } else if (ophase >= (1 << 5)) {
> > +               dev_err(dev,
> > +                       "Output phase value exceeds field range (5 bits): %u",
> > +                       iphase);
> > +               return -ERANGE;
> 
> This will cause the driver to fail to probe. I think skipping setting
> of the phase is a better option.

Well, maybe? If the phase is specified but invalid then chances are you'll hit 
system instability by continuing to probe the driver. I think it's better to 
fail in an obvious way, it's not as if it's incidentally incorrect.

> 
> 
> > +       } else {
> > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->out,
> > +                                          ophase, true);
> > +               dev_info(dev, "Output phase relationship: %u", ophase);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int aspeed_sdhci_probe(struct platform_device *pdev)
> >  {
> > +       const struct aspeed_sdhci_phase *phase;
> >         struct sdhci_pltfm_host *pltfm_host;
> >         struct aspeed_sdhci *dev;
> >         struct sdhci_host *host;
> > @@ -181,7 +271,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
> >                 return -EINVAL;
> >
> >         dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
> > -       dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
> > +       dev->width_mask = !slot ? ASPEED_SDC_S0_MMC8 : ASPEED_SDC_S1_MMC8;
> > +       phase = of_device_get_match_data(&pdev->dev);
> > +       if (phase)
> > +               dev->phase = &phase[slot];
> >
> >         sdhci_get_of_property(pdev);
> >
> > @@ -195,6 +288,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
> >                 goto err_pltfm_free;
> >         }
> >
> > +       ret = aspeed_sdhci_configure_of(pdev, dev);
> > +       if (ret)
> > +               goto err_sdhci_add;
> > +
> >         ret = mmc_of_parse(host->mmc);
> >         if (ret)
> >                 goto err_sdhci_add;
> > @@ -230,10 +327,40 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static const struct aspeed_sdhci_phase ast2600_sdhci_phase[] = {
> > +       /* SDHCI/Slot 0 */
> > +       [0] = {
> > +               .in = {
> > +                       .value_mask = ASPEED_SDC_S0_PHASE_IN,
> > +                       .enable_mask = ASPEED_SDC_S0_PHASE_IN_EN,
> > +                       .enable_value = 1,
> > +               },
> > +               .out = {
> > +                       .value_mask = ASPEED_SDC_S0_PHASE_OUT,
> > +                       .enable_mask = ASPEED_SDC_S0_PHASE_OUT_EN,
> > +                       .enable_value = 3,
> > +               },
> > +       },
> > +       /* SDHCI/Slot 1 */
> > +       [1] = {
> > +               .in = {
> > +                       .value_mask = ASPEED_SDC_S1_PHASE_IN,
> > +                       .enable_mask = ASPEED_SDC_S1_PHASE_IN_EN,
> > +                       .enable_value = 1,
> > +               },
> > +               .out = {
> > +                       .value_mask = ASPEED_SDC_S1_PHASE_OUT,
> > +                       .enable_mask = ASPEED_SDC_S1_PHASE_OUT_EN,
> 
> Is there any value in splitting the input and output phase values
> up? (instead of taking the property from the device tree and putting
> it in the hardware).

One register contains both settings for both slots. We can't just blast the 
full register value for one of the slots into it. Further, the fields for the 
slots are interleaved, so it's not like we can just associate the top or bottom 
16 bits with a particular slot.

Cheers,

Andrew
