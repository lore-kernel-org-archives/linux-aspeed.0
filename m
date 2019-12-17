From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Dec 2019 12:58:32 +0000
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <20191217073533.GC31182@pengutronix.de>
References: <20191204134631.GT1998@sirena.org.uk>
 <20191210094144.mxximpuouchy3fqu@pengutronix.de>
 <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
 <20191212161019.GF4310@sirena.org.uk>
 <20191212162152.5uu3feacduetysq7@pengutronix.de>
 <20191212165124.GJ4310@sirena.org.uk>
 <20191216085525.csr2aglm5md4vtsw@pengutronix.de>
 <20191216114454.GB4161@sirena.org.uk>
 <20191217073533.GC31182@pengutronix.de>
Message-ID: <20191217125832.GF4755@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 17, 2019 at 08:35:33AM +0100, Marco Felsch wrote:
> On 19-12-16 11:44, Mark Brown wrote:

> > What I'm saying is that I think the binding needs to explicitly talk
> > about that since at the minute it's really confusing reading it as it
> > is, it sounds very much like it's trying to override that in a chip
> > specific fashion as using gpiolib and the GPIO bindings for pinmuxing is
> > really quite unusual.

> Hm.. I still think that we don't mux the pin to some special function.
> It is still a gpio input pin and if we don't request the pin we could
> read the input from user-space too and get a 'valid' value. Muxing would
> happen if we change the pad to so called _alternate_ function. Anyway,
> lets find a binding description:

I don't think any of this makes much difference from a user point of
view.

> IMHO this is very descriptive and needs no update.

> description:
>  - A GPIO reference to a local general purpose input, [1] calls it GPI.
>    The DA9062 regulators can select between voltage-a/-b settings.
>    Each regulator has a VBUCK*_GPI or VLDO*_GPI input to determine the
>    active setting. In front of the VBUCK*_GPI/VLDO*_GPI input is a mux
>    to select between different signal sources, valid sources are: the
>    internal sequencer, GPI1, GPI2 and GPI3. See [1] table 63 for more
>    information. Most the time the internal sequencer is fine but
>    sometimes it is necessary to use the signal from the DA9062 GPI
>    pads. This binding covers the second use case.
>    Attention: Sharing the same GPI for other purposes or across multiple
>    regulators is possible but the polarity setting must equal.

This doesn't say anything about how the GPIO input is expected to be
controlled, for voltage setting any runtime control would need to be
done by the driver and it sounds like that's all that can be controlled.
The way this reads I'd expect one use of this to be for fast voltage
setting for example (you could even combine that with suspend sequencing
using the internal sequencer if you mux back to the sequencer during
suspend).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20191217/fac494a2/attachment.sig>
