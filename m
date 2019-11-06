From: andriy.shevchenko@linux.intel.com <andriy.shevchenko@linux.intel.com>
Date: Wed, 6 Nov 2019 16:24:41 +0200
Subject: [PATCH v2 0/2] Add definition for GPIO direction
In-Reply-To: <ddcd02cc6c709837a28cae2cbfa672c506927659.camel@fi.rohmeurope.com>
References: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
 <20191106120846.5bunrqj3uz4khih5@earth.universe>
 <ddcd02cc6c709837a28cae2cbfa672c506927659.camel@fi.rohmeurope.com>
Message-ID: <20191106142441.GC32742@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 06, 2019 at 12:25:18PM +0000, Vaittinen, Matti wrote:
> 
> On Wed, 2019-11-06 at 13:08 +0100, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Wed, Nov 06, 2019 at 10:51:06AM +0200, Matti Vaittinen wrote:
> > > The patch series adds definitions for GPIO line directions.
> > > 
> > > For occasional GPIO contributor like me it is always a pain to
> > > remember
> > > whether 1 or 0 was used for GPIO direction INPUT/OUTPUT.
> > 
> > Maybe also update the GPIO drivers in pinctrl?
> > 
> > $ git grep -l gpio_get_direction drivers/pinctrl
> > drivers/pinctrl/bcm/pinctrl-bcm2835.c
> > drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
> > drivers/pinctrl/intel/pinctrl-baytrail.c
> > drivers/pinctrl/intel/pinctrl-cherryview.c
> > drivers/pinctrl/intel/pinctrl-intel.c
> > drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > drivers/pinctrl/mediatek/pinctrl-paris.c
> > drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> > drivers/pinctrl/pinctrl-amd.c
> > drivers/pinctrl/pinctrl-at91.c
> > drivers/pinctrl/pinctrl-axp209.c
> > drivers/pinctrl/pinctrl-ingenic.c
> > drivers/pinctrl/pinctrl-ocelot.c
> > drivers/pinctrl/pinctrl-oxnas.c
> > drivers/pinctrl/pinctrl-pic32.c
> > drivers/pinctrl/pinctrl-pistachio.c
> > drivers/pinctrl/pinctrl-rk805.c
> > drivers/pinctrl/pinctrl-rockchip.c
> > drivers/pinctrl/pinctrl-rza1.c
> > drivers/pinctrl/pinctrl-st.c
> > drivers/pinctrl/pinctrl-stmfx.c
> > drivers/pinctrl/pinctrl-sx150x.c
> > drivers/pinctrl/qcom/pinctrl-msm.c
> > drivers/pinctrl/stm32/pinctrl-stm32.c
> > drivers/pinctrl/vt8500/pinctrl-wmt.c
> 
> Ouch. I didn't check from pinctrl but I see those should be converted
> as well. I'm a bit short on time right now so if anyone else is
> interested I won't mind :)
> 
> Luckily the value for IN and OUT is not changed - only the defines were
> added - so all of the drivers do not need to be done at once.

Agree.

> If no one
> else will take the pinctrl part then I can probably do pinctrl patches
> for v5.6 cycle.

For pin control Intel, since we send PR to Linus and it won't be different to
him, we would like to see patch per driver.

-- 
With Best Regards,
Andy Shevchenko


