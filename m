From: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
Date: Tue, 7 Mar 2023 11:09:41 +0000
Subject: [PATCH V5 09/15] spi: Add stacked and parallel memories support
 in SPI core
In-Reply-To: <CAOiHx=nmsAh3ADL3s0eZKpEZJqCB_POi=8YjfxrHYLEbjRfwHg@mail.gmail.com>
References: <20230306172109.595464-1-amit.kumar-mahapatra@amd.com>
 <20230306172109.595464-10-amit.kumar-mahapatra@amd.com>
 <CAOiHx=nmsAh3ADL3s0eZKpEZJqCB_POi=8YjfxrHYLEbjRfwHg@mail.gmail.com>
Message-ID: <BN7PR12MB2802A2E7A193B8BC0073812BDCB79@BN7PR12MB2802.namprd12.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

> -----Original Message-----
> From: Jonas Gorski <jonas.gorski@gmail.com>
> Sent: Tuesday, March 7, 2023 1:31 AM
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
> Subject: Re: [PATCH V5 09/15] spi: Add stacked and parallel memories
> support in SPI core
> 
> Hi,
> 
> On Mon, 6 Mar 2023 at 18:26, Amit Kumar Mahapatra <amit.kumar-
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
> >
> > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-
> mahapatra at amd.com>
> > ---
> >  drivers/spi/spi.c       | 213 +++++++++++++++++++++++++++-------------
> >  include/linux/spi/spi.h |  34 +++++--
> >  2 files changed, 173 insertions(+), 74 deletions(-)
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> > 5866bf5813a4..8ec7f58fa111 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -613,7 +613,8 @@ static int spi_dev_check(struct device *dev, void
> *data)
> >         struct spi_device *new_spi = data;
> >
> >         if (spi->controller == new_spi->controller &&
> > -           spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi, 0))
> > +           spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi, 0) &&
> > +           spi_get_chipselect(spi, 1) == spi_get_chipselect(new_spi,
> > + 1))
> >                 return -EBUSY;
> 
> This will only reject new devices if both chip selects are identical, but not if
> they only share one, e.g. CS 1 + 2 vs 1 + 3, or 1 + 2 vs only 2, or if the order is
> different (1 + 2 vs 2 + 1 - haven't read the code too close to know if this is
> allowed/possible).

Agreed,  will add in the next series.

Regards,
Amit
> 
> Regards,
> Jonas
