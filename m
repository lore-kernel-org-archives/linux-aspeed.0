From: Mark Brown <broonie@kernel.org>
Date: Tue, 7 Jan 2020 13:09:11 +0000
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <20200107083654.atgbjhrnhyax2gqq@pengutronix.de>
References: <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
 <20191212161019.GF4310@sirena.org.uk>
 <20191212162152.5uu3feacduetysq7@pengutronix.de>
 <20191212165124.GJ4310@sirena.org.uk>
 <20191216085525.csr2aglm5md4vtsw@pengutronix.de>
 <20191216114454.GB4161@sirena.org.uk>
 <20191217073533.GC31182@pengutronix.de>
 <20191217125832.GF4755@sirena.org.uk>
 <20200107083654.atgbjhrnhyax2gqq@pengutronix.de>
Message-ID: <20200107130911.GD4877@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 07, 2020 at 09:36:54AM +0100, Marco Felsch wrote:
> On 19-12-17 12:58, Mark Brown wrote:

> > This doesn't say anything about how the GPIO input is expected to be
> > controlled, for voltage setting any runtime control would need to be
> > done by the driver and it sounds like that's all that can be controlled.
> > The way this reads I'd expect one use of this to be for fast voltage
> > setting for example (you could even combine that with suspend sequencing
> > using the internal sequencer if you mux back to the sequencer during
> > suspend).

> The input signal is routed trough the da9062 gpio block to the
> regualtors. You can't set any voltage value using a gpio instead you
> decide which voltage setting is applied. The voltage values for
> runtime/suspend comes from the dt-data. No it's not just a fast
> switching option imagine the system suspend case where the cpu and soc
> voltage can be reduced to a very low value. Older soc's like the imx6
> signaling this state by a hard wired gpio line because the soc and
> cpu cores don't work properly on such low voltage values. This is
> my use case and I can't use the sequencer.

My point is that I can't tell any of this from the description.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200107/1c5a127f/attachment.sig>
