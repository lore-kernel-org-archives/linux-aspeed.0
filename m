From: Mark Brown <broonie@kernel.org>
Date: Thu, 12 Dec 2019 16:51:24 +0000
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <20191212162152.5uu3feacduetysq7@pengutronix.de>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-4-m.felsch@pengutronix.de>
 <20191204134631.GT1998@sirena.org.uk>
 <20191210094144.mxximpuouchy3fqu@pengutronix.de>
 <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
 <20191212161019.GF4310@sirena.org.uk>
 <20191212162152.5uu3feacduetysq7@pengutronix.de>
Message-ID: <20191212165124.GJ4310@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 12, 2019 at 05:21:53PM +0100, Marco Felsch wrote:

> "... what's driving the input ..":
> Sorry I didn't get you here. What did you mean? The input is driven by
> the host. This can be any gpio line and in my case it is a gpio line
> driven by the soc-hw during a suspend operation.

Something needs to say what that thing is, especially if it's runtime
controllable.  In your case from the point of view of software there is
actually no enable control so we shouldn't be providing an enable
operation to the framework.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20191212/5eb5904c/attachment-0001.sig>
