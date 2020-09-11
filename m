From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 11 Sep 2020 13:23:01 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_2/3]_mmc:_sdhci-of-aspeed:_Expose_data_sample_phase?=
 =?UTF-8?Q?_delay_tuning?=
In-Reply-To: <CACPK8XemZ2YG+nFBwy7sDoo8==YvnVYxt+1mx8QfBCxotG7K6g@mail.gmail.com>
References: <20200910105440.3087723-1-andrew@aj.id.au>
 <20200910105440.3087723-3-andrew@aj.id.au>
 <CACPK8Xf-jys=F0Uqg-hYH-eDThmd5yOSNeC7+vLhra3GdOK1Zw@mail.gmail.com>
 <57d48d7a-7cea-4be7-92bd-8f3b93f84a06@www.fastmail.com>
 <CACPK8XemZ2YG+nFBwy7sDoo8==YvnVYxt+1mx8QfBCxotG7K6g@mail.gmail.com>
Message-ID: <38661d63-67ca-4dc9-942d-90a3b8cd8351@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 11 Sep 2020, at 13:03, Joel Stanley wrote:
> On Fri, 11 Sep 2020 at 02:49, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Fri, 11 Sep 2020, at 11:32, Joel Stanley wrote:
> > > On Thu, 10 Sep 2020 at 10:55, Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > > Allow sample phase adjustment to deal with layout or tolerance issues.
> > > >
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > > ---
> > > >  drivers/mmc/host/sdhci-of-aspeed.c | 137 +++++++++++++++++++++++++++--
> > > >  1 file changed, 132 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > > > index 4f008ba3280e..641accbfcde4 100644
> > > > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > > > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> 
> > > > +static void
> > > > +aspeed_sdc_configure_phase(struct aspeed_sdc *sdc,
> > > > +                          const struct aspeed_sdhci_phase_desc *phase,
> > > > +                          uint8_t value, bool enable)
> > > > +{
> > > > +       u32 reg;
> > > > +
> > > > +       spin_lock(&sdc->lock);
> > >
> > > What is the lock protecting against?
> > >
> > > We call this in the ->probe, so there should be no concurrent access going on.
> >
> > Because the register is in the "global" part of the SD/MMC controller address
> > space (it's not part of the SDHCI), and there are multiple slots that may have
> > a driver probed concurrently.
> 
> That points to having the property be part of the "global" device tree
> node.

Not really. The settings are slot-specific. The only reason it's in the global
register space is that the settings cannot be part of the SDHCI. That Aspeed
chose to pack them in the same register, and _interleaved_ at that, is
unfortunate.

As the settings are slot-specific they should be associated with each slot's
node. We should concentrate on representing the intent of the controls and
not tie the devicetree representation to the register layout that Aspeed came
up with.

>  This would simplify the code; you wouldn't need the locking
> either.

IMO this is a loss for readability, so I'm not convinced it should be changed.
The outcome is some opaque register value that is shoved in the devicetree,
and given the baffling interleaving and choices of field sizes that's not a place
I want to be.

> 
> >
> > >
> > >
> > > > +       reg = readl(sdc->regs + ASPEED_SDC_PHASE);
> > > > +       reg &= ~phase->enable_mask;
> > > > +       if (enable) {
> > > > +               reg &= ~phase->value_mask;
> > > > +               reg |= value << __ffs(phase->value_mask);
> > > > +               reg |= phase->enable_value << __ffs(phase->enable_mask);
> > > > +       }
> > > > +       writel(reg, sdc->regs + ASPEED_SDC_PHASE);
> > > > +       spin_unlock(&sdc->lock);
> > > > +}
> > > > +
> > > >  static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > > >  {
> > > >         struct sdhci_pltfm_host *pltfm_host;
> > > > @@ -155,8 +195,58 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> > > >         return (delta / 0x100) - 1;
> > > >  }
> > > >
> > > > +static int aspeed_sdhci_configure_of(struct platform_device *pdev,
> > > > +                                    struct aspeed_sdhci *sdhci)
> > > > +{
> > > > +       u32 iphase, ophase;
> > > > +       struct device_node *np;
> > > > +       struct device *dev;
> > > > +       int ret;
> > > > +
> > > > +       if (!sdhci->phase)
> > > > +               return 0;
> > > > +
> > > > +       dev = &pdev->dev;
> > > > +       np = dev->of_node;
> > > > +
> > > > +       ret = of_property_read_u32(np, "aspeed,input-phase", &iphase);
> > > > +       if (ret < 0) {
> > > > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in, 0,
> > > > +                                          false);
> > >
> > > Will this clear any value that eg. u-boot writes?
> >
> > No, see the 'enable' test in aspeed_sdc_configure_phase()
> 
> OK, so this branch will never cause any change in the register? Best
> to drop it then.

So there are two parts to the phase configuration, the phase adjustment
value, and a switch to turn phase adjustment on or off. Both fields exist
for both in and out phase adjustments for both slots.

So this branch will cause the phase control to be disabled, but it won't
change the phase value that was originally programmed. If we maintain
the original semantics it shouldn't be dropped.

However, below you suggest we maintain the configuration (both
enable and value state) in the absence of the property, so the code
needs to be reworked to uphold suggestion.

> 
> >
> > >
> > > The register should be left alone if the kernel doesn't have a
> > > configuration of it's own, otherwise we may end up breaking an
> > > otherwise working system.
> >
> > Right, I can rework that.
>
