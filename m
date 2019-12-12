From: Mark Brown <broonie@kernel.org>
Date: Thu, 12 Dec 2019 16:10:19 +0000
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-4-m.felsch@pengutronix.de>
 <20191204134631.GT1998@sirena.org.uk>
 <20191210094144.mxximpuouchy3fqu@pengutronix.de>
 <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
Message-ID: <20191212161019.GF4310@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 11, 2019 at 06:09:18PM +0100, Marco Felsch wrote:

> so one argument more for my solution. Also we don't configure the "pad"
> to be a vsel/ena-pin. The hw-pad can only be a gpio or has an alternate
> function (WDKICK for GPIO0, Seq. SYS_EN for GPIO2, Seq. PWR_EN for GPIO4).
> Instead we tell the regulator to use _this_ GPIO e.g. for voltage
> selection so we go the other way around. My last argument why pinctrl
> isn't the correct place is that the GPIO1 can be used for
> regulator-0:vsel-in and for regulator-1:enable-in. So this pad would
> have different states which is invalid IMHO.

Note that there's two bits to my concern - one is if we should be using
gpiolib or pinctrl, the other is what's driving the input (whichever API
it's configured through) which didn't seem to be mentioned.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20191212/661db55a/attachment-0001.sig>
