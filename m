From: Marco Felsch <m.felsch@pengutronix.de>
Date: Tue, 17 Dec 2019 08:35:33 +0100
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <20191216114454.GB4161@sirena.org.uk>
References: <20191129172537.31410-4-m.felsch@pengutronix.de>
 <20191204134631.GT1998@sirena.org.uk>
 <20191210094144.mxximpuouchy3fqu@pengutronix.de>
 <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
 <20191212161019.GF4310@sirena.org.uk>
 <20191212162152.5uu3feacduetysq7@pengutronix.de>
 <20191212165124.GJ4310@sirena.org.uk>
 <20191216085525.csr2aglm5md4vtsw@pengutronix.de>
 <20191216114454.GB4161@sirena.org.uk>
Message-ID: <20191217073533.GC31182@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19-12-16 11:44, Mark Brown wrote:
> On Mon, Dec 16, 2019 at 09:55:25AM +0100, Marco Felsch wrote:
> > On 19-12-12 16:51, Mark Brown wrote:
> 
> > > Something needs to say what that thing is, especially if it's runtime
> > > controllable.  In your case from the point of view of software there is
> > > actually no enable control so we shouldn't be providing an enable
> > > operation to the framework.
> 
> > The enabel control signal is always available, please check [1] table
> > 63. There is a mux in front of the enable pin so:
> 
> What I'm saying is that I think the binding needs to explicitly talk
> about that since at the minute it's really confusing reading it as it
> is, it sounds very much like it's trying to override that in a chip
> specific fashion as using gpiolib and the GPIO bindings for pinmuxing is
> really quite unusual.

Hm.. I still think that we don't mux the pin to some special function.
It is still a gpio input pin and if we don't request the pin we could
read the input from user-space too and get a 'valid' value. Muxing would
happen if we change the pad to so called _alternate_ function. Anyway,
lets find a binding description:

name:
 - dlg,vsel-sense-gpios

IMHO this is very descriptive and needs no update.

description:
 - A GPIO reference to a local general purpose input, [1] calls it GPI.
   The DA9062 regulators can select between voltage-a/-b settings.
   Each regulator has a VBUCK*_GPI or VLDO*_GPI input to determine the
   active setting. In front of the VBUCK*_GPI/VLDO*_GPI input is a mux
   to select between different signal sources, valid sources are: the
   internal sequencer, GPI1, GPI2 and GPI3. See [1] table 63 for more
   information. Most the time the internal sequencer is fine but
   sometimes it is necessary to use the signal from the DA9062 GPI
   pads. This binding covers the second use case.
   Attention: Sharing the same GPI for other purposes or across multiple
   regulators is possible but the polarity setting must equal.

[1] https://www.dialog-semiconductor.com/sites/default/files/da9062_datasheet_3v6.pdf

Regards,
  Marco


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

