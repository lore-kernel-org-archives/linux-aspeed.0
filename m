From: Marco Felsch <m.felsch@pengutronix.de>
Date: Tue, 17 Dec 2019 13:31:16 +0100
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <AM5PR1001MB099460B2D291644F088707BA80500@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20191210094144.mxximpuouchy3fqu@pengutronix.de>
 <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
 <20191212161019.GF4310@sirena.org.uk>
 <20191212162152.5uu3feacduetysq7@pengutronix.de>
 <20191212165124.GJ4310@sirena.org.uk>
 <20191216085525.csr2aglm5md4vtsw@pengutronix.de>
 <AM5PR1001MB09941005A47B603805D3C53280510@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191217090034.GD31182@pengutronix.de>
 <AM5PR1001MB099460B2D291644F088707BA80500@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <20191217123116.GB29666@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19-12-17 09:53, Adam Thomson wrote:
> On 17 December 2019 09:01, Marco Felsch wrote:
> 
> > > > The enabel control signal is always available, please check [1] table
> > > > 63. There is a mux in front of the enable pin so:
> > > >
> > > >              +-------------
> > > >  Seq. |\     |   Regulator
> > > >  GPI1 | \    |
> > > >  GPI2 | | -- > Enable
> > > >  GPI3 | /    |
> > > >       |/     .
> > > >              .
> > > >              .
> > > >
> > > > Adam please correct me if this is wrong.
> > >
> > > Yes the register can always be configured regardless of the associated pin
> > > configuration, but if say GPIO1 was configured as a GPO but a regulator was
> > > configured to use GPIO1 as its GPI control mechanism, the output signal from
> > > GPIO1 would be ignored, the sequencer control would not have any effect and
> > > you're simply left with manual I2C control. Really we shouldn't be getting into
> > > that situation though. If a GPIO is to be used as a regulator control signal
> > > then it should be marked as such and I don't think we should be able to use that
> > > pin for anything other than regulator control.
> > 
> > I see, so we have to guarantee that the requested gpio is configured as
> > input. This can be done by:
> 
> This is one of the reasons I thought this was better suited to being done in the
> pinctrl/pinmux side. If you configure the GPIO as for regulator control then
> the code can automatically configure the GPIO for input. That doesn't then need
> to be in the regulator driver.

I still don't prefer that way.. pls check my arguments I already made
and I don't wanna repeat it again.

> But yes we wouldn't really want to configure a regulator to be controlled via a
> GPI when it's configured as a GPO as it makes no sense.

Okay, so the check is all we need to hardening the driver against wrong
usage :)

Regards,
  Marco

> 
> > 
> >   if (gpi->flags & FLAG_IS_OUT)
> >   	return -EINVAL;
> > 
> > Regards,
> >   Marco
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
