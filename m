From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 15 Dec 2020 10:01:31 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v5_1/6]_mmc:_core:_Add_helper_for_parsing_clock_pha?=
 =?UTF-8?Q?se_properties?=
In-Reply-To: <CAPDyKFrceNPNz9+88p+mzbYEo-ZqWOwTBWaqycxPr3MQEFtbaA@mail.gmail.com>
References: <20201208012615.2717412-1-andrew@aj.id.au>
 <20201208012615.2717412-2-andrew@aj.id.au>
 <CAPDyKFrceNPNz9+88p+mzbYEo-ZqWOwTBWaqycxPr3MQEFtbaA@mail.gmail.com>
Message-ID: <2ba456f0-d9ca-4ca6-9dd0-ae7b5f959333@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 15 Dec 2020, at 02:18, Ulf Hansson wrote:
> On Tue, 8 Dec 2020 at 02:26, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Drivers for MMC hosts that accept phase corrections can take advantage
> > of the helper by embedding a mmc_clk_phase_map_t object in their
> > private data and invoking mmc_of_parse_clk_phase() to extract phase
> > parameters. It is the responsibility of the host driver to translate and
> > apply the extracted values to hardware as required.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  drivers/mmc/core/host.c  | 44 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mmc/host.h | 17 ++++++++++++++++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 96b2ca1f1b06..b1697f00c4b5 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -163,6 +163,50 @@ static void mmc_retune_timer(struct timer_list *t)
> >         mmc_retune_needed(host);
> >  }
> >
> > +static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
> > +                                     struct mmc_clk_phase *phase)
> > +{
> > +       int degrees[2] = {0};
> > +       int rc;
> > +
> > +       rc = device_property_read_u32_array(dev, prop, degrees, 2);
> > +       phase->valid = !rc;
> > +       if (phase->valid) {
> > +               phase->in_deg = degrees[0];
> > +               phase->out_deg = degrees[1];
> > +       }
> > +}
> > +
> > +void
> > +mmc_of_parse_clk_phase(struct mmc_host *host, mmc_clk_phase_map_t map)
> 
> Would you mind to change to pass a "struct mmc_clk_phase_map *map" to this?
> 
> See more comments below.
> 
> > +{
> > +       struct device *dev = host->parent;
> > +
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-legacy",
> > +                                 &map[MMC_TIMING_LEGACY]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs",
> > +                                 &map[MMC_TIMING_MMC_HS]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-sd-hs",
> > +                                 &map[MMC_TIMING_SD_HS]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr12",
> > +                                 &map[MMC_TIMING_UHS_SDR12]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr25",
> > +                                 &map[MMC_TIMING_UHS_SDR25]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr50",
> > +                                 &map[MMC_TIMING_UHS_SDR50]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-uhs-sdr104",
> > +                                 &map[MMC_TIMING_UHS_SDR104]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-uhs-ddr50",
> > +                                 &map[MMC_TIMING_UHS_DDR50]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-mmc-ddr52",
> > +                                 &map[MMC_TIMING_MMC_DDR52]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs200",
> > +                                 &map[MMC_TIMING_MMC_HS200]);
> > +       mmc_of_parse_timing_phase(dev, "clk-phase-mmc-hs400",
> > +                                 &map[MMC_TIMING_MMC_HS400]);
> > +}
> > +EXPORT_SYMBOL(mmc_of_parse_clk_phase);
> > +
> >  /**
> >   *     mmc_of_parse() - parse host's device-tree node
> >   *     @host: host whose node should be parsed.
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 01bba36545c5..bc4731c9738f 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -79,6 +79,22 @@ struct mmc_ios {
> >         bool enhanced_strobe;                   /* hs400es selection */
> >  };
> >
> > +struct mmc_clk_phase {
> > +       bool valid;
> > +       u16 in_deg;
> > +       u16 out_deg;
> > +};
> > +
> > +/*
> > + * Define a type to map between bus timings and phase correction values. To
> > + * avoid bloat in struct mmc_host we leave it to the host driver to define the
> > + * phase map object in its private data if it supports phase correction.
> > + * However, mmc_of_parse_clk_phase() is provided by the mmc core and needs the
> > + * provided array to be correctly sized, so typedef an appropriately sized
> > + * array to minimise the chance that the wrong size object is passed.
> > + */
> > +typedef struct mmc_clk_phase mmc_clk_phase_map_t[MMC_TIMING_MMC_HS400 + 1];
> > +
> 
> Nitpick: I would appreciate if we could avoid using "typedefs", as I
> think they in many cases makes the code harder to read. How about
> doing this instead?
> 
> #define MMC_NUM_CLK_PHASES (MMC_TIMING_MMC_HS400 + 1)
> 
> struct mmc_clk_phase_map {
>         struct mmc_clk_phase phase[MMC_NUM_CLK_PHASES];
> };
> 
> [...]

Right; I experimented with that approach and felt it was kinda clunky (hence 
the typedef), but I'll respin the series doing as such.

Thanks,

Andrew
