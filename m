From: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
Date: Mon, 20 Mar 2023 19:15:47 +0000
Subject: [PATCH V6 09/15] spi: Add stacked and parallel memories support
 in SPI core
In-Reply-To: <CAOiHx==+gX-S43=Fd1jRu=t=Cy8=6dePbGDDmGRUFhq8dVCwGg@mail.gmail.com>
References: <20230310173217.3429788-1-amit.kumar-mahapatra@amd.com>
 <20230310173217.3429788-10-amit.kumar-mahapatra@amd.com>
 <CAOiHx==+gX-S43=Fd1jRu=t=Cy8=6dePbGDDmGRUFhq8dVCwGg@mail.gmail.com>
Message-ID: <BN7PR12MB2802FFB8112849DEB9C22FBFDC809@BN7PR12MB2802.namprd12.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

> -----Original Message-----
> From: Jonas Gorski <jonas.gorski@gmail.com>
> Sent: Sunday, March 12, 2023 9:30 PM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Cc: broonie at kernel.org; miquel.raynal at bootlin.com; richard at nod.at;
> vigneshr at ti.com; jic23 at kernel.org; tudor.ambarus at microchip.com;
> pratyush at kernel.org; Mehta, Sanju <Sanju.Mehta@amd.com>; chin-
> ting_kuo at aspeedtech.com; clg at kaod.org; kdasu.kdev at gmail.com;
> f.fainelli at gmail.com; rjui at broadcom.com; sbranden at broadcom.com;
> eajames at linux.ibm.com; olteanv at gmail.com; han.xu at nxp.com;
> john.garry at huawei.com; shawnguo at kernel.org; s.hauer at pengutronix.de;
> narmstrong at baylibre.com; khilman at baylibre.com;
> matthias.bgg at gmail.com; haibo.chen at nxp.com; linus.walleij at linaro.org;
> daniel at zonque.org; haojian.zhuang at gmail.com; robert.jarzmik at free.fr;
> agross at kernel.org; bjorn.andersson at linaro.org; heiko at sntech.de;
> krzysztof.kozlowski at linaro.org; andi at etezian.org;
> mcoquelin.stm32 at gmail.com; alexandre.torgue at foss.st.com;
> wens at csie.org; jernej.skrabec at gmail.com; samuel at sholland.org;
> masahisa.kojima at linaro.org; jaswinder.singh at linaro.org;
> rostedt at goodmis.org; mingo at redhat.com; l.stelmach at samsung.com;
> davem at davemloft.net; edumazet at google.com; kuba at kernel.org;
> pabeni at redhat.com; alex.aring at gmail.com; stefan at datenfreihafen.org;
> kvalo at kernel.org; james.schulman at cirrus.com; david.rhodes at cirrus.com;
> tanureal at opensource.cirrus.com; rf at opensource.cirrus.com;
> perex at perex.cz; tiwai at suse.com; npiggin at gmail.com;
> christophe.leroy at csgroup.eu; mpe at ellerman.id.au; oss at buserror.net;
> windhl at 126.com; yangyingliang at huawei.com;
> william.zhang at broadcom.com; kursad.oney at broadcom.com;
> anand.gore at broadcom.com; rafal at milecki.pl; git (AMD-Xilinx)
> <git@amd.com>; linux-spi at vger.kernel.org; linux-kernel at vger.kernel.org;
> joel at jms.id.au; andrew at aj.id.au; radu_nicolae.pirea at upb.ro;
> nicolas.ferre at microchip.com; alexandre.belloni at bootlin.com;
> claudiu.beznea at microchip.com; bcm-kernel-feedback-list at broadcom.com;
> fancer.lancer at gmail.com; kernel at pengutronix.de; festevam at gmail.com;
> linux-imx at nxp.com; jbrunet at baylibre.com;
> martin.blumenstingl at googlemail.com; avifishman70 at gmail.com;
> tmaimon77 at gmail.com; tali.perry1 at gmail.com; venture at google.com;
> yuenn at google.com; benjaminfair at google.com; yogeshgaur.83 at gmail.com;
> konrad.dybcio at somainline.org; alim.akhtar at samsung.com;
> ldewangan at nvidia.com; thierry.reding at gmail.com; jonathanh at nvidia.com;
> Simek, Michal <michal.simek@amd.com>; linux-aspeed at lists.ozlabs.org;
> openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org; linux-rpi-
> kernel at lists.infradead.org; linux-amlogic at lists.infradead.org; linux-
> mediatek at lists.infradead.org; linux-arm-msm at vger.kernel.org; linux-
> rockchip at lists.infradead.org; linux-samsung-soc at vger.kernel.org; linux-
> stm32 at st-md-mailman.stormreply.com; linux-sunxi at lists.linux.dev; linux-
> tegra at vger.kernel.org; netdev at vger.kernel.org; linux-
> wpan at vger.kernel.org; libertas-dev at lists.infradead.org; linux-
> wireless at vger.kernel.org; linux-mtd at lists.infradead.org; lars at metafoo.de;
> Michael.Hennerich at analog.com; linux-iio at vger.kernel.org;
> michael at walle.cc; palmer at dabbelt.com; linux-riscv at lists.infradead.org;
> alsa-devel at alsa-project.org; patches at opensource.cirrus.com; linuxppc-
> dev at lists.ozlabs.org; amitrkcian2002 at gmail.com
> Subject: Re: [PATCH V6 09/15] spi: Add stacked and parallel memories
> support in SPI core
> 
> Hi,
> 
> On Fri, 10 Mar 2023 at 18:37, Amit Kumar Mahapatra <amit.kumar-
> mahapatra at amd.com> wrote:
> >
> > For supporting multiple CS the SPI device need to be aware of all the
> > CS values. So, the "chip_select" member in the spi_device structure is
> > now an array that holds all the CS values.
> >
> > spi_device structure now has a "cs_index_mask" member. This acts as an
> > index to the chip_select array. If nth bit of spi->cs_index_mask is
> > set then the driver would assert spi->chip_select[n].
> >
> > In parallel mode all the chip selects are asserted/de-asserted
> > simultaneously and each byte of data is stored in both devices, the
> > even bits in one, the odd bits in the other. The split is
> > automatically handled by the GQSPI controller. The GQSPI controller
> > supports a maximum of two flashes connected in parallel mode. A
> > "multi-cs-cap" flag is added in the spi controntroller data, through
> > ctlr->multi-cs-cap the spi core will make sure that the controller is
> > capable of handling multiple chip selects at once.
> >
> > For supporting multiple CS via GPIO the cs_gpiod member of the
> > spi_device structure is now an array that holds the gpio descriptor
> > for each chipselect.
> >
> > Multi CS support using GPIO is not tested due to unavailability of
> > necessary hardware setup.
> 
> Can you pinmux your SPI controller's (cs) pins as GPIO? If so, you should be
> able use that for testing.
> 

Xilinx Controller drivers that support multi cs are registered under 
spi-mem framework. So even if I modify the pinmux the chip selection 
will not go through the SPI core. 
So, we cannot test the CS GPIO changes in SPI core on our platforms.

> >
> > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-
> mahapatra at amd.com>
> > ---
> >  drivers/spi/spi.c       | 225 +++++++++++++++++++++++++++-------------
> >  include/linux/spi/spi.h |  34 ++++--
> >  2 files changed, 182 insertions(+), 77 deletions(-)
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> > c725b4bab7af..742bd688381c 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -612,10 +612,17 @@ static int spi_dev_check(struct device *dev,
> > void *data)  {
> >         struct spi_device *spi = to_spi_device(dev);
> >         struct spi_device *new_spi = data;
> > -
> > -       if (spi->controller == new_spi->controller &&
> > -           spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi, 0))
> > -               return -EBUSY;
> > +       int idx, nw_idx;
> > +
> > +       if (spi->controller == new_spi->controller) {
> > +               for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +                       for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
> > +                               if (spi_get_chipselect(spi, idx) ==
> > +                                   spi_get_chipselect(new_spi, nw_idx))
> > +                                       return -EBUSY;
> > +                       }
> > +               }
> 
> AFAICT unused chip selects are initialized to 0, so all single chip select devices
> would have it as their second one. This will then cause this check to reject
> every single chip select device after the first one. So you first need to make
> sure to only compare valid chip selects.
> 
> So the loop condition should be something along idx <
> spi_get_num_chipselect(), not idx < SPI_CS_CNT_MAX.
> 

Agreed, will update the loop condition as per num_cs.

> > +       }
> >         return 0;
> >  }
> >
> > @@ -629,7 +636,7 @@ static int __spi_add_device(struct spi_device
> > *spi)  {
> >         struct spi_controller *ctlr = spi->controller;
> >         struct device *dev = ctlr->dev.parent;
> > -       int status;
> > +       int status, idx;
> >
> >         /*
> >          * We need to make sure there's no other device with this @@
> > -638,8 +645,7 @@ static int __spi_add_device(struct spi_device *spi)
> >          */
> >         status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
> >         if (status) {
> > -               dev_err(dev, "chipselect %d already in use\n",
> > -                               spi_get_chipselect(spi, 0));
> > +               dev_err(dev, "chipselect %d already in use\n",
> > + spi_get_chipselect(spi, 0));
> 
> The message might be misleading for multi cs devices where the first one is
> free, but the second one is already in use.
> 
> So maybe move this error message into spi_dev_check(), where you have
> that information available. You then even have the chance to state what is
> using the CS then, but that might be something for a different patch.
> 
> 

Agreed, I will move the error message to spi_dev_check().

> >                 return status;
> >         }
> >
> > @@ -649,8 +655,10 @@ static int __spi_add_device(struct spi_device *spi)
> >                 return -ENODEV;
> >         }
> >
> > -       if (ctlr->cs_gpiods)
> > -               spi_set_csgpiod(spi, 0, ctlr->cs_gpiods[spi_get_chipselect(spi, 0)]);
> > +       if (ctlr->cs_gpiods) {
> > +               for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
> > +                       spi_set_csgpiod(spi, idx, ctlr-
> >cs_gpiods[spi_get_chipselect(spi, idx)]);
> > +       }
> >
> >         /*
> >          * Drivers may modify this initial i/o setup, but will @@
> > -690,13 +698,15 @@ int spi_add_device(struct spi_device *spi)  {
> >         struct spi_controller *ctlr = spi->controller;
> >         struct device *dev = ctlr->dev.parent;
> > -       int status;
> > +       int status, idx;
> >
> > -       /* Chipselects are numbered 0..max; validate. */
> > -       if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
> > -               dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
> > -                       ctlr->num_chipselect);
> > -               return -EINVAL;
> > +       for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +               /* Chipselects are numbered 0..max; validate. */
> > +               if (spi_get_chipselect(spi, idx) >= ctlr->num_chipselect) {
> > +                       dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi,
> idx),
> > +                               ctlr->num_chipselect);
> > +                       return -EINVAL;
> > +               }
> >         }
> >
> >         /* Set the bus ID string */
> > @@ -713,12 +723,15 @@ static int spi_add_device_locked(struct
> > spi_device *spi)  {
> >         struct spi_controller *ctlr = spi->controller;
> >         struct device *dev = ctlr->dev.parent;
> > +       int idx;
> >
> > -       /* Chipselects are numbered 0..max; validate. */
> > -       if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
> > -               dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
> > -                       ctlr->num_chipselect);
> > -               return -EINVAL;
> > +       for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +               /* Chipselects are numbered 0..max; validate. */
> > +               if (spi_get_chipselect(spi, idx) >= ctlr->num_chipselect) {
> > +                       dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi,
> idx),
> > +                               ctlr->num_chipselect);
> > +                       return -EINVAL;
> > +               }
> >         }
> >
> >         /* Set the bus ID string */
> > @@ -966,58 +979,119 @@ static void spi_res_release(struct
> > spi_controller *ctlr, struct spi_message *mes  static void
> > spi_set_cs(struct spi_device *spi, bool enable, bool force)  {
> >         bool activate = enable;
> > +       u32 cs_num = __ffs(spi->cs_index_mask);
> > +       int idx;
> >
> >         /*
> > -        * Avoid calling into the driver (or doing delays) if the chip select
> > -        * isn't actually changing from the last time this was called.
> > +        * In parallel mode all the chip selects are asserted/de-asserted
> > +        * at once
> >          */
> > -       if (!force && ((enable && spi->controller->last_cs ==
> spi_get_chipselect(spi, 0)) ||
> > -                      (!enable && spi->controller->last_cs != spi_get_chipselect(spi,
> 0))) &&
> > -           (spi->controller->last_cs_mode_high == (spi->mode &
> SPI_CS_HIGH)))
> > -               return;
> > -
> > -       trace_spi_set_cs(spi, activate);
> > -
> > -       spi->controller->last_cs = enable ? spi_get_chipselect(spi, 0) : -1;
> > -       spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
> > -
> > -       if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) &&
> !activate)
> > -               spi_delay_exec(&spi->cs_hold, NULL);
> > -
> > -       if (spi->mode & SPI_CS_HIGH)
> > -               enable = !enable;
> > +       if ((spi->cs_index_mask & SPI_PARALLEL_CS_MASK) ==
> SPI_PARALLEL_CS_MASK) {
> > +               spi->controller->last_cs_mode_high = spi->mode &
> > + SPI_CS_HIGH;
> > +
> > +               if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) &&
> !activate)
> > +                       spi_delay_exec(&spi->cs_hold, NULL);
> > +
> > +               if (spi->mode & SPI_CS_HIGH)
> > +                       enable = !enable;
> > +
> > +               if (spi_get_csgpiod(spi, 0) && spi_get_csgpiod(spi, 1)) {
> > +                       if (!(spi->mode & SPI_NO_CS)) {
> > +                               /*
> > +                                * Historically ACPI has no means of the GPIO polarity
> and
> > +                                * thus the SPISerialBus() resource defines it on the per-
> chip
> > +                                * basis. In order to avoid a chain of negations, the GPIO
> > +                                * polarity is considered being Active High. Even for the
> cases
> > +                                * when _DSD() is involved (in the updated versions of
> ACPI)
> > +                                * the GPIO CS polarity must be defined Active High to
> avoid
> > +                                * ambiguity. That's why we use enable, that takes
> SPI_CS_HIGH
> > +                                * into account.
> > +                                */
> > +                               if (has_acpi_companion(&spi->dev)) {
> > +                                       for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
> > +                                               gpiod_set_value_cansleep(spi_get_csgpiod(spi,
> idx),
> > +                                                                        !enable);
> > +                               } else {
> > +                                       for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
> > +                                               /* Polarity handled by GPIO library */
> > +                                               gpiod_set_value_cansleep(spi_get_csgpiod(spi,
> idx),
> > +                                                                        activate);
> > +                               }
> > +                       }
> > +                       /* Some SPI masters need both GPIO CS & slave_select */
> > +                       if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> > +                           spi->controller->set_cs)
> > +                               spi->controller->set_cs(spi, !enable);
> 
> > +                       else if (spi->controller->set_cs)
> > +                               spi->controller->set_cs(spi, !enable);
> 
> this else if belongs to the following brace as the else of the if
> (spi_get_csgpiod(spi, 0) && spi_get_csgpiod(spi, 1). Currently it would make

Agreed, will fix it in the next series.

> the first check redundant, as the second case would always be true if the first
> one is.
> 
> Actually shouldn't you iterate over the cs's here in case one is using
> set_cs() and the other one is gpiod? You can only get here if both are backed
> by gpiods. And you would only set the first cs, but not the second one. The -
> >set_cs() callback doesn't allow specifying which of the (multiple) cs's should
> be set though.
>
 
After fixing the else if indentation we will get here if either one of the
 CS support gpiod or both the CS support set_cs. Yes, one is using set_cs() 
and the other one is gpiod use case handling is missing. I need to iterate 
over the CS?s to find the CS GPIO, call gpiod_set_value_cansleep ( ) and 
then call set_cs( ). In the set_cs( ) driver API the driver needs to first check 
if any of the cs_index_mask enabled CS's is not a CS GPIO and then enable 
only the non-gpio CS. 
Please let me your thoughts on this approach.

> > +               }
> >
> > -       if (spi_get_csgpiod(spi, 0)) {
> > -               if (!(spi->mode & SPI_NO_CS)) {
> > -                       /*
> > -                        * Historically ACPI has no means of the GPIO polarity and
> > -                        * thus the SPISerialBus() resource defines it on the per-chip
> > -                        * basis. In order to avoid a chain of negations, the GPIO
> > -                        * polarity is considered being Active High. Even for the cases
> > -                        * when _DSD() is involved (in the updated versions of ACPI)
> > -                        * the GPIO CS polarity must be defined Active High to avoid
> > -                        * ambiguity. That's why we use enable, that takes
> SPI_CS_HIGH
> > -                        * into account.
> > -                        */
> > -                       if (has_acpi_companion(&spi->dev))
> > -                               gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0),
> !enable);
> > -                       else
> > -                               /* Polarity handled by GPIO library */
> > -                               gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0),
> activate);
> > +               for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +                       if (spi_get_csgpiod(spi, idx) || !spi->controller-
> >set_cs_timing) {
> > +                               if (activate)
> > +                                       spi_delay_exec(&spi->cs_setup, NULL);
> > +                               else
> > +                                       spi_delay_exec(&spi->cs_inactive, NULL);
> > +                       }
> 
> Won't you delay twice if both CS's are backed by gpiod (and the controller
> does not implement set_cs_timing)? You should probably break after the
> first or so.
> 

True, I will add a check to avoid extra delay.

> I wonder if it would makes sense to have a helper function to set cs state to
> all cs's indicated by cs_index_mask so you can share most of the logic
> between the single and multi cs paths.
> 
> Currently it seems both paths have a lot of code (and comment) duplication,
> with the difference being one path is touching one cs and the other two (or
> all).
> 

Agreed, will update the logic.

> >                 }
> > -               /* Some SPI masters need both GPIO CS & slave_select */
> > -               if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> > -                   spi->controller->set_cs)
> > +       } else {
> > +               /*
> > +                * Avoid calling into the driver (or doing delays) if the chip select
> > +                * isn't actually changing from the last time this was called.
> > +                */
> > +               if (!force && ((enable && spi->controller->last_cs ==
> > +                               spi_get_chipselect(spi, cs_num)) ||
> > +                               (!enable && spi->controller->last_cs !=
> > +                                spi_get_chipselect(spi, cs_num))) &&
> > +                   (spi->controller->last_cs_mode_high ==
> > +                    (spi->mode & SPI_CS_HIGH)))
> > +                       return;
> > +
> > +               trace_spi_set_cs(spi, activate);
> > +
> > +               spi->controller->last_cs = enable ? spi_get_chipselect(spi, cs_num)
> : -1;
> > +               spi->controller->last_cs_mode_high = spi->mode &
> > + SPI_CS_HIGH;
> > +
> > +               if ((spi_get_csgpiod(spi, cs_num) || !spi->controller-
> >set_cs_timing) && !activate)
> > +                       spi_delay_exec(&spi->cs_hold, NULL);
> > +
> > +               if (spi->mode & SPI_CS_HIGH)
> > +                       enable = !enable;
> > +
> > +               if (spi_get_csgpiod(spi, cs_num)) {
> > +                       if (!(spi->mode & SPI_NO_CS)) {
> > +                               /*
> > +                                * Historically ACPI has no means of the GPIO polarity
> and
> > +                                * thus the SPISerialBus() resource defines it on the per-
> chip
> > +                                * basis. In order to avoid a chain of negations, the GPIO
> > +                                * polarity is considered being Active High. Even for the
> cases
> > +                                * when _DSD() is involved (in the updated versions of
> ACPI)
> > +                                * the GPIO CS polarity must be defined Active High to
> avoid
> > +                                * ambiguity. That's why we use enable, that takes
> SPI_CS_HIGH
> > +                                * into account.
> > +                                */
> > +                               if (has_acpi_companion(&spi->dev))
> > +                                       gpiod_set_value_cansleep(spi_get_csgpiod(spi,
> cs_num),
> > +                                                                !enable);
> > +                               else
> > +                                       /* Polarity handled by GPIO library */
> > +                                       gpiod_set_value_cansleep(spi_get_csgpiod(spi,
> cs_num),
> > +                                                                activate);
> > +                       }
> > +                       /* Some SPI masters need both GPIO CS & slave_select */
> > +                       if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> > +                           spi->controller->set_cs)
> > +                               spi->controller->set_cs(spi, !enable);
> > +               } else if (spi->controller->set_cs) {
> >                         spi->controller->set_cs(spi, !enable);
> > -       } else if (spi->controller->set_cs) {
> > -               spi->controller->set_cs(spi, !enable);
> > -       }
> > +               }
> >
> > -       if (spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) {
> > -               if (activate)
> > -                       spi_delay_exec(&spi->cs_setup, NULL);
> > -               else
> > -                       spi_delay_exec(&spi->cs_inactive, NULL);
> > +               if (spi_get_csgpiod(spi, cs_num) || !spi->controller-
> >set_cs_timing) {
> > +                       if (activate)
> > +                               spi_delay_exec(&spi->cs_setup, NULL);
> > +                       else
> > +                               spi_delay_exec(&spi->cs_inactive, NULL);
> > +               }
> >         }
> >  }
> >
> > @@ -2246,8 +2320,8 @@ static void of_spi_parse_dt_cs_delay(struct
> > device_node *nc,  static int of_spi_parse_dt(struct spi_controller *ctlr,
> struct spi_device *spi,
> >                            struct device_node *nc)  {
> > -       u32 value;
> > -       int rc;
> > +       u32 value, cs[SPI_CS_CNT_MAX] = {0};
> > +       int rc, idx;
> >
> >         /* Mode (clock phase/polarity/etc.) */
> >         if (of_property_read_bool(nc, "spi-cpha")) @@ -2320,13
> > +2394,21 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct
> spi_device *spi,
> >         }
> >
> >         /* Device address */
> > -       rc = of_property_read_u32(nc, "reg", &value);
> > -       if (rc) {
> > +       rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
> > +                                                SPI_CS_CNT_MAX);
> > +       if (rc < 0 || rc > ctlr->num_chipselect) {
> >                 dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
> >                         nc, rc);
> >                 return rc;
> > +       } else if ((of_property_read_bool(nc, "parallel-memories")) &&
> > +                  (!ctlr->multi_cs_cap)) {
> > +               dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
> > +               return -EINVAL;
> >         }
> > -       spi_set_chipselect(spi, 0, value);
> > +       for (idx = 0; idx < rc; idx++)
> > +               spi_set_chipselect(spi, idx, cs[idx]);
> > +       /* By default set the spi->cs_index_mask as 1 */
> > +       spi->cs_index_mask = 0x01;
> >
> >         /* Device speed */
> >         if (!of_property_read_u32(nc, "spi-max-frequency", &value)) @@
> > -3846,6 +3928,7 @@ static int __spi_validate(struct spi_device *spi, struct
> spi_message *message)
> >         struct spi_controller *ctlr = spi->controller;
> >         struct spi_transfer *xfer;
> >         int w_size;
> > +       u32 cs_num = __ffs(spi->cs_index_mask);
> >
> >         if (list_empty(&message->transfers))
> >                 return -EINVAL;
> > @@ -3858,7 +3941,7 @@ static int __spi_validate(struct spi_device *spi,
> struct spi_message *message)
> >          * cs_change is set for each transfer.
> >          */
> >         if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits &
> SPI_CS_WORD) ||
> > -                                         spi_get_csgpiod(spi, 0))) {
> > +                                         spi_get_csgpiod(spi,
> > + cs_num))) {
> 
> Wouldn't you need to check for any of the cs_index_mask enabled CS's, and
> not just the first one? AFAICT you would currently fail to catch a
> SPI_CS_WORD transfer with both cs enabled where the first one is a
> SPI_CS_WORD capable native CS and the second one a gpiod.
> 

That?s true, I will add a loop and check for each of the cs_index_mask 
enabled CS's.

> >                 size_t maxsize;
> >                 int ret;
> >
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h index
> > bdb35a91b4bf..452682aa1a39 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -19,6 +19,11 @@
> >  #include <linux/acpi.h>
> >  #include <linux/u64_stats_sync.h>
> >
> > +/* Max no. of CS supported per spi device */ #define SPI_CS_CNT_MAX 2
> > +
> > +/* chip select mask */
> > +#define SPI_PARALLEL_CS_MASK   (BIT(0) | BIT(1))
> >  struct dma_chan;
> >  struct software_node;
> >  struct ptp_system_timestamp;
> > @@ -166,6 +171,7 @@ extern void
> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
> >   *     deasserted. If @cs_change_delay is used from @spi_transfer, then
> the
> >   *     two delays will be added up.
> >   * @pcpu_statistics: statistics for the spi_device
> > + * @cs_index_mask: Bit mask of the active chipselect(s) in the
> > + chipselect array
> >   *
> >   * A @spi_device is used to interchange data between an SPI slave
> >   * (usually a discrete chip) and CPU memory.
> > @@ -181,7 +187,7 @@ struct spi_device {
> >         struct spi_controller   *controller;
> >         struct spi_controller   *master;        /* Compatibility layer */
> >         u32                     max_speed_hz;
> > -       u8                      chip_select;
> > +       u8                      chip_select[SPI_CS_CNT_MAX];
> >         u8                      bits_per_word;
> >         bool                    rt;
> >  #define SPI_NO_TX      BIT(31)         /* No transmit wire */
> > @@ -202,7 +208,7 @@ struct spi_device {
> >         void                    *controller_data;
> >         char                    modalias[SPI_NAME_SIZE];
> >         const char              *driver_override;
> > -       struct gpio_desc        *cs_gpiod;      /* Chip select gpio desc */
> > +       struct gpio_desc        *cs_gpiod[SPI_CS_CNT_MAX];      /* Chip select
> gpio desc */
> >         struct spi_delay        word_delay; /* Inter-word delay */
> >         /* CS delays */
> >         struct spi_delay        cs_setup;
> > @@ -212,6 +218,13 @@ struct spi_device {
> >         /* The statistics */
> >         struct spi_statistics __percpu  *pcpu_statistics;
> >
> > +       /* Bit mask of the chipselect(s) that the driver need to use from
> > +        * the chipselect array.When the controller is capable to handle
> > +        * multiple chip selects & memories are connected in parallel
> > +        * then more than one bit need to be set in cs_index_mask.
> > +        */
> > +       u32                     cs_index_mask : 2;
> 
> SPI_CS_CNT_MAX?
> 

Agreed, will replace 2 with SPI_CS_CNT_MAX.

> > +
> >         /*
> >          * likely need more hooks for more protocol options affecting how
> >          * the controller talks to each chip, like:
> > @@ -268,22 +281,22 @@ static inline void *spi_get_drvdata(struct
> > spi_device *spi)
> >
> >  static inline u8 spi_get_chipselect(struct spi_device *spi, u8 idx)
> > {
> > -       return spi->chip_select;
> > +       return spi->chip_select[idx];
> >  }
> >
> >  static inline void spi_set_chipselect(struct spi_device *spi, u8 idx,
> > u8 chipselect)  {
> > -       spi->chip_select = chipselect;
> > +       spi->chip_select[idx] = chipselect;
> >  }
> >
> >  static inline struct gpio_desc *spi_get_csgpiod(struct spi_device
> > *spi, u8 idx)  {
> > -       return spi->cs_gpiod;
> > +       return spi->cs_gpiod[idx];
> >  }
> >
> >  static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx,
> > struct gpio_desc *csgpiod)  {
> > -       spi->cs_gpiod = csgpiod;
> > +       spi->cs_gpiod[idx] = csgpiod;
> >  }
> >
> >  /**
> > @@ -388,6 +401,8 @@ extern struct spi_device
> *spi_new_ancillary_device(struct spi_device *spi, u8 ch
> >   * @bus_lock_spinlock: spinlock for SPI bus locking
> >   * @bus_lock_mutex: mutex for exclusion of multiple callers
> >   * @bus_lock_flag: indicates that the SPI bus is locked for exclusive
> > use
> > + * @multi_cs_cap: indicates that the SPI Controller can assert/de-assert
> > + *     more than one chip select at once.
> >   * @setup: updates the device mode and clocking records used by a
> >   *     device's SPI controller; protocol code may call this.  This
> >   *     must fail if an unrecognized or unsupported mode is requested.
> > @@ -585,6 +600,13 @@ struct spi_controller {
> >         /* Flag indicating that the SPI bus is locked for exclusive use */
> >         bool                    bus_lock_flag;
> >
> > +       /*
> > +        * Flag indicating that the spi-controller has multi chip select
> > +        * capability and can assert/de-assert more than one chip select
> > +        * at once.
> > +        */
> > +       bool                    multi_cs_cap;
> 
> I admit I haven't followed the first iterations, but Is there a reason this isn't a
> SPI_XXX flag in spi.h? There seem to be quite a few free bits left.
> 

Yes, it can be a SPI_XX flag as well. I will add a flag & remove this 
structure member.

> I would think multi_cs can be emulated (somewhat) via gpiod for the second
> CS as long as the controller supports set_cs() (and SPI_NO_CS?).
> 

It is not just about handling the CS's, but rather this flag indicates 
that the controller can communicate (reading & writing data) with 
both the devices simultaneously.

Regards,
Amit

> > +
> >         /* Setup mode and clock, etc (spi driver may call many times).
> >          *
> >          * IMPORTANT:  this may be called when transfers to another
> > --
> > 2.25.1
> >
> 
> Regards
> Jonas
