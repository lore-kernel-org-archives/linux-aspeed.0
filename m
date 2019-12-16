From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 16 Dec 2019 09:55:25 +0100
Subject: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
In-Reply-To: <20191212165124.GJ4310@sirena.org.uk>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-4-m.felsch@pengutronix.de>
 <20191204134631.GT1998@sirena.org.uk>
 <20191210094144.mxximpuouchy3fqu@pengutronix.de>
 <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
 <20191212161019.GF4310@sirena.org.uk>
 <20191212162152.5uu3feacduetysq7@pengutronix.de>
 <20191212165124.GJ4310@sirena.org.uk>
Message-ID: <20191216085525.csr2aglm5md4vtsw@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19-12-12 16:51, Mark Brown wrote:
> On Thu, Dec 12, 2019 at 05:21:53PM +0100, Marco Felsch wrote:
> 
> > "... what's driving the input ..":
> > Sorry I didn't get you here. What did you mean? The input is driven by
> > the host. This can be any gpio line and in my case it is a gpio line
> > driven by the soc-hw during a suspend operation.
> 
> Something needs to say what that thing is, especially if it's runtime
> controllable.  In your case from the point of view of software there is
> actually no enable control so we shouldn't be providing an enable
> operation to the framework.

The enabel control signal is always available, please check [1] table
63. There is a mux in front of the enable pin so:

             +-------------
 Seq. |\     |   Regulator
 GPI1 | \    |
 GPI2 | | -- > Enable
 GPI3 | /    |
      |/     .
             .
             .

Adam please correct me if this is wrong.

[1] https://www.dialog-semiconductor.com/sites/default/files/da9062_datasheet_3v6.pdf

Regards,
  Marco

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
