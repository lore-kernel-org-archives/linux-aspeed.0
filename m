From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Jan 2020 15:43:14 +0000
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <20200107133811.rua5i6lflzyzlh24@pengutronix.de>
References: <20191212161019.GF4310@sirena.org.uk>
 <20191212162152.5uu3feacduetysq7@pengutronix.de>
 <20191212165124.GJ4310@sirena.org.uk>
 <20191216085525.csr2aglm5md4vtsw@pengutronix.de>
 <20191216114454.GB4161@sirena.org.uk>
 <20191217073533.GC31182@pengutronix.de>
 <20191217125832.GF4755@sirena.org.uk>
 <20200107083654.atgbjhrnhyax2gqq@pengutronix.de>
 <20200107130911.GD4877@sirena.org.uk>
 <20200107133811.rua5i6lflzyzlh24@pengutronix.de>
Message-ID: <20200114154314.GZ3897@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 07, 2020 at 02:38:11PM +0100, Marco Felsch wrote:
> On 20-01-07 13:09, Mark Brown wrote:
> > On Tue, Jan 07, 2020 at 09:36:54AM +0100, Marco Felsch wrote:

> > > The input signal is routed trough the da9062 gpio block to the
> > > regualtors. You can't set any voltage value using a gpio instead you
> > > decide which voltage setting is applied. The voltage values for
> > > runtime/suspend comes from the dt-data. No it's not just a fast
> > > switching option imagine the system suspend case where the cpu and soc
> > > voltage can be reduced to a very low value. Older soc's like the imx6
> > > signaling this state by a hard wired gpio line because the soc and
> > > cpu cores don't work properly on such low voltage values. This is
> > > my use case and I can't use the sequencer.

> > My point is that I can't tell any of this from the description.

> Therefore I want to discuss the dt-binding documentation with you and
> the others to get this done. Is the above description better to
> understand the dt-binding?

That text really doesn't feel like text that'd be idiomatic
directly in a binding document but some of those ideas probably
do need to be in the text I think.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200114/9fd25c00/attachment.sig>
