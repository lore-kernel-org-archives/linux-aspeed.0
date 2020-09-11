From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Sep 2020 03:33:56 +0000
Subject: [PATCH 2/3] mmc: sdhci-of-aspeed: Expose data sample phase delay
 tuning
In-Reply-To: <57d48d7a-7cea-4be7-92bd-8f3b93f84a06@www.fastmail.com>
References: <20200910105440.3087723-1-andrew@aj.id.au>
 <20200910105440.3087723-3-andrew@aj.id.au>
 <CACPK8Xf-jys=F0Uqg-hYH-eDThmd5yOSNeC7+vLhra3GdOK1Zw@mail.gmail.com>
 <57d48d7a-7cea-4be7-92bd-8f3b93f84a06@www.fastmail.com>
Message-ID: <CACPK8XemZ2YG+nFBwy7sDoo8==YvnVYxt+1mx8QfBCxotG7K6g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2020 at 02:49, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 11 Sep 2020, at 11:32, Joel Stanley wrote:
> > On Thu, 10 Sep 2020 at 10:55, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > Allow sample phase adjustment to deal with layout or tolerance issues.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  drivers/mmc/host/sdhci-of-aspeed.c | 137 +++++++++++++++++++++++++++--
> > >  1 file changed, 132 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > > index 4f008ba3280e..641accbfcde4 100644
> > > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > > +++ b/drivers/mmc/host/sdhci-of-aspeed.c

> > > +static void
> > > +aspeed_sdc_configure_phase(struct aspeed_sdc *sdc,
> > > +                          const struct aspeed_sdhci_phase_desc *phase,
> > > +                          uint8_t value, bool enable)
> > > +{
> > > +       u32 reg;
> > > +
> > > +       spin_lock(&sdc->lock);
> >
> > What is the lock protecting against?
> >
> > We call this in the ->probe, so there should be no concurrent access going on.
>
> Because the register is in the "global" part of the SD/MMC controller address
> space (it's not part of the SDHCI), and there are multiple slots that may have
> a driver probed concurrently.

That points to having the property be part of the "global" device tree
node. This would simplify the code; you wouldn't need the locking
either.

>
> >
> >
> > > +       reg = readl(sdc->regs + ASPEED_SDC_PHASE);
> > > +       reg &= ~phase->enable_mask;
> > > +       if (enable) {
> > > +               reg &= ~phase->value_mask;
> > > +               reg |= value << __ffs(phase->value_mask);
> > > +               reg |= phase->enable_value << __ffs(phase->enable_mask);
> > > +       }
> > > +       writel(reg, sdc->regs + ASPEED_SDC_PHASE);
> > > +       spin_unlock(&sdc->lock);
> > > +}
> > > +
> > >  static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > >  {
> > >         struct sdhci_pltfm_host *pltfm_host;
> > > @@ -155,8 +195,58 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> > >         return (delta / 0x100) - 1;
> > >  }
> > >
> > > +static int aspeed_sdhci_configure_of(struct platform_device *pdev,
> > > +                                    struct aspeed_sdhci *sdhci)
> > > +{
> > > +       u32 iphase, ophase;
> > > +       struct device_node *np;
> > > +       struct device *dev;
> > > +       int ret;
> > > +
> > > +       if (!sdhci->phase)
> > > +               return 0;
> > > +
> > > +       dev = &pdev->dev;
> > > +       np = dev->of_node;
> > > +
> > > +       ret = of_property_read_u32(np, "aspeed,input-phase", &iphase);
> > > +       if (ret < 0) {
> > > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in, 0,
> > > +                                          false);
> >
> > Will this clear any value that eg. u-boot writes?
>
> No, see the 'enable' test in aspeed_sdc_configure_phase()

OK, so this branch will never cause any change in the register? Best
to drop it then.

>
> >
> > The register should be left alone if the kernel doesn't have a
> > configuration of it's own, otherwise we may end up breaking an
> > otherwise working system.
>
> Right, I can rework that.
