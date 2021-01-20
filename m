From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 20 Jan 2021 05:23:14 +0000
Subject: [PATCH v3 4/4] hwmon: Support Aspeed AST2600 PWM/Fan tachometer
In-Reply-To: <2bf67d3a-cd5f-4f9c-b043-709b18a759d5@www.fastmail.com>
References: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
 <20210118065059.2478078-5-troy_lee@aspeedtech.com>
 <2bf67d3a-cd5f-4f9c-b043-709b18a759d5@www.fastmail.com>
Message-ID: <HK0PR06MB338019E403823F0BF9962FE3F2A20@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Wednesday, January 20, 2021 1:16 PM
> To: Troy Lee <troy_lee@aspeedtech.com>; openbmc at lists.ozlabs.org; Joel
> Stanley <joel@jms.id.au>; Philipp Zabel <p.zabel@pengutronix.de>; open list
> <linux-kernel@vger.kernel.org>; moderated list:ARM/ASPEED MACHINE
> SUPPORT <linux-arm-kernel@lists.infradead.org>; moderated
> list:ARM/ASPEED MACHINE SUPPORT <linux-aspeed@lists.ozlabs.org>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>; ChiaWei Wang
> <chiawei_wang@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; kbuild
> test robot <lkp@intel.com>
> Subject: Re: [PATCH v3 4/4] hwmon: Support Aspeed AST2600 PWM/Fan
> tachometer
> 
> Hi Troy,
> 
> On Mon, 18 Jan 2021, at 17:20, Troy Lee wrote:
> > Add Aspeed AST2600 PWM/Fan tacho driver. AST2600 has 16 PWM channel
> > and
> > 16 FAN tacho channel.
> >
> > Changes since v2:
> >  - declare local function as static function
> >
> > Changes since v1:
> >  - fixed review comments
> >  - fixed double-looped calculation of div_h and div_l
> >  - moving configuration to device tree
> >  - register hwmon driver with devm_hwmon_device_register_with_info()
> >
> > Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  drivers/hwmon/Kconfig                |  10 +
> >  drivers/hwmon/Makefile               |   1 +
> >  drivers/hwmon/aspeed2600-pwm-tacho.c | 756
> > +++++++++++++++++++++++++++
> >  3 files changed, 767 insertions(+)
> >  create mode 100644 drivers/hwmon/aspeed2600-pwm-tacho.c
> 
> ...
> 
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile index
> > 09a86c5e1d29..1a415d493ffc 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -52,6 +52,7 @@ obj-$(CONFIG_SENSORS_ARM_SCPI)	+=
> scpi-hwmon.o
> >  obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
> >  obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
> >  obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
> > +obj-$(CONFIG_SENSORS_ASPEED2600_PWM_TACHO)	+=
> aspeed2600-pwm-tacho.o
> 
> Why does this have to be a separate implementation from the existing ASPEED
> PWM/Tacho driver? Is there really nothing in common?
> 
Hello Andrew,
	The register set is fully re-arrange. And it is new design at AST2600, can't be compatible with older PWM.  
