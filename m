From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Mon, 7 Nov 2022 09:31:00 +0000
Subject: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <E3A2DC80-3D8D-451F-9EA1-A3262F4A3C43@aspeedtech.com>
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-3-billy_tsai@aspeedtech.com>
 <OS0PR01MB5922014A7D74A884D2E7BDC286399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <C7224BE1-D81E-4FE0-8B7C-5A3CA69898D2@aspeedtech.com>
 <OS0PR01MB5922EC7AB73207DF30F42A0A863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <E3A2DC80-3D8D-451F-9EA1-A3262F4A3C43@aspeedtech.com>
Message-ID: <OS0PR01MB59228483527685F943A3F5D4863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy Tsai,

> -----Original Message-----
> From: Billy Tsai <billy_tsai@aspeedtech.com>
> Sent: 07 November 2022 09:26
> To: Biju Das <biju.das.jz@bp.renesas.com>; jdelvare at suse.com; linux at roeck-
> us.net; robh+dt at kernel.org; joel at jms.id.au; andrew at aj.id.au;
> lee.jones at linaro.org; thierry.reding at gmail.com; u.kleine-
> koenig at pengutronix.de; p.zabel at pengutronix.de; linux-hwmon at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org; linux-
> pwm at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>; garnermic at meta.com
> Cc: kernel test robot <lkp@intel.com>; Geert Uytterhoeven
> <geert+renesas@glider.be>
> Subject: Re: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
> 
> On 2022/11/7, 4:55 PM, "Biju Das" <biju.das.jz@bp.renesas.com> wrote:
> 
>     > > -----Original Message-----
>     > > From: Billy Tsai <billy_tsai@aspeedtech.com>
>     > > Sent: 07 November 2022 08:48
>     > > To: Biju Das <biju.das.jz@bp.renesas.com>; jdelvare at suse.com;
> linux at roeck-
>     > > us.net; robh+dt at kernel.org; joel at jms.id.au; andrew at aj.id.au;
>     > > lee.jones at linaro.org; thierry.reding at gmail.com; u.kleine-
>     > > koenig at pengutronix.de; p.zabel at pengutronix.de; linux-
> hwmon at vger.kernel.org;
>     > > devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-
>     > > aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org; linux-
>     > > pwm at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>;
> garnermic at meta.com
>     > > Cc: kernel test robot <lkp@intel.com>
>     > > Subject: Re: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
>     > >
>     > > On 2022/11/2, 11:56 PM, "Biju Das" <biju.das.jz@bp.renesas.com>
> wrote:
>     > >
>     > >     > > +	parent_dev = of_find_device_by_node(np);
>     > >     > > +	priv->clk = devm_clk_get_enabled(&parent_dev->dev, NULL);
>     > >     > > +	if (IS_ERR(priv->clk))
>     > >     > > +		return dev_err_probe(dev, PTR_ERR(priv->clk),
>     > >     > > +				     "Couldn't get clock\n");
>     > >
>     > >     > What is the use case?
>     > >
>     > >     > Is pwm configured by boot loader initially ?
>     > >
>     > >     > Or
>     > >
>     > >     > pwm configured by Linux, not by the bootloader initially?
>     > >
>     > >     > Or
>     > >
>     > >     > Driver needs to handle both cases?
>     > >
>     > >     > Just asking, because you are turning on the clock unnecessarily
> here,
>     > >     > If you need to address all the use cases. If it is just first
> one, then
>     > >     > It is ok.
>     > >
>     > > Hi Biju,
>     > >
>     > > The driver want to handle all of the use cases. Can you tell me why
> turning
>     > > on the clock is unnecessarily here?
> 
>     > For the use case, "pwm configured by Linux, not by the bootloader
> initially",
> 
>     > You are unnecessarily turning on the clocks. You could
> 
>     > enable it during pwm_enable
>     > and disable it during pwm_disable.
> 
>     > For configuring registers, while pwm is in disable state,
>     > you could just turn on the clock and do the register configurations and
> turn it off.
> 
>     > By this way you are saving power.
> 
> Hi Biju,
> 
> This clock is the source clock for the pwm controller (include the accessing
> for the register).

OK, But the driver has only one clock (priv->clk = devm_clk_get_enabled(&parent_dev->dev, NULL)).
You are always turning it on during probe.


> For the output of the PWM (pwm_enable/pwm_disable), the controller have
> another register to control it.

That is enable/disable register for controlling the output of PWM.

Cheers,
Biju
