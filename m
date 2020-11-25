From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 26 Nov 2020 09:22:58 +1030
Subject: [PATCH v3 1/3] mmc: sdhci-of-aspeed: Expose phase delay tuning
In-Reply-To: <CAPDyKFrC9vp5gtpFC5L1K17uN059GsJ2zF4f7-_=sFEQ5BBRpw@mail.gmail.com>
References: <20201123063004.337345-1-andrew@aj.id.au>
 <20201123063004.337345-2-andrew@aj.id.au>
 <CAPDyKFrC9vp5gtpFC5L1K17uN059GsJ2zF4f7-_=sFEQ5BBRpw@mail.gmail.com>
Message-ID: <e3c4f1a8-4fa0-4e2a-be7c-763f733f0cdb@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 25 Nov 2020, at 00:42, Ulf Hansson wrote:
> On Mon, 23 Nov 2020 at 07:30, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The Aspeed SD/eMMC controllers feature up to two SDHCIs alongside a
> > a set of "global" configuration registers. The global configuration
> > registers house controller-specific settings that aren't exposed by the
> > SDHCI, one example being a register for phase tuning.
> >
> > The phase tuning feature is new in the AST2600 design. It's exposed as a
> > single register in the global register set and controls both the input
> > and output phase adjustment for each slot. As the settings are
> > slot-specific, the values to program are extracted from properties in
> > the SDHCI devicetree nodes.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> [...]
> 
> >
> > +static void
> > +aspeed_sdhci_of_parse_phase(struct device_node *np, const char *prop,
> > +                           struct aspeed_sdhci_phase_param *phase)
> > +{
> > +       int degrees[2] = {0};
> > +       int rc;
> > +
> > +       rc = of_property_read_variable_u32_array(np, prop, degrees, 2, 0);
> > +       phase->set = rc == 2;
> > +       if (phase->set) {
> > +               phase->in_deg = degrees[0];
> > +               phase->out_deg = degrees[1];
> > +       }
> > +}
> > +
> > +static int aspeed_sdhci_of_parse(struct platform_device *pdev,
> > +                                struct aspeed_sdhci *sdhci)
> > +{
> > +       struct device_node *np;
> > +       struct device *dev;
> > +
> > +       if (!sdhci->phase_desc)
> > +               return 0;
> > +
> > +       dev = &pdev->dev;
> > +       np = dev->of_node;
> > +
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-legacy",
> > +                                   &sdhci->phase_param[MMC_TIMING_LEGACY]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-hs",
> > +                                   &sdhci->phase_param[MMC_TIMING_MMC_HS]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-sd-hs",
> > +                                   &sdhci->phase_param[MMC_TIMING_SD_HS]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr12",
> > +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR12]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr25",
> > +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR25]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr50",
> > +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR50]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-sdr104",
> > +                                   &sdhci->phase_param[MMC_TIMING_UHS_SDR104]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-uhs-ddr50",
> > +                                   &sdhci->phase_param[MMC_TIMING_UHS_DDR50]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-ddr52",
> > +                                   &sdhci->phase_param[MMC_TIMING_MMC_DDR52]);
> > +       aspeed_sdhci_of_parse_phase(np, "clk-phase-mmc-hs200",
> > +                                   &sdhci->phase_param[MMC_TIMING_MMC_HS200]);
> > +
> > +       return 0;
> > +}
> 
> If it's not too much to ask, would you mind adding a helper function
> to the mmc core, as to let us avoid open coding? Then we should be
> able to move the sdhci-of-arasan driver to use this as well.

Yes, I can look at it and send a v4.

> 
> Perhaps the definition of the helper could look something like this:
> int mmc_of_parse_clk_phase(struct mmc_host *host, struct mmc_clk_phase
> *phases) (or something along those lines)
> 
> I think the struct mmc_clk_phase could be something that is stored in
> the host specific struct, rather than in the common struct mmc_host
> (to avoid sprinkle it with unnecessary data).
> 
> Moreover, we should probably use the device_property_* APIs instead of
> the DT specific of_property_*.

Yep, thanks for the pointers.

Andrew
