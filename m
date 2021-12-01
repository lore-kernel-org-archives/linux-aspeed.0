From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 1 Dec 2021 10:53:48 +0000
Subject: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <3b80b2a52362cbadb26052685566e2c1f75a0b68.camel@pengutronix.de>
References: <20211129064329.27006-1-billy_tsai@aspeedtech.com>
 <20211129064329.27006-3-billy_tsai@aspeedtech.com>
 <e28a5d5de9b940717e6444f019eab63ab1bb0b75.camel@pengutronix.de>
 <CDB0374F-3835-4501-964E-DB771588114D@aspeedtech.com>
 <3b80b2a52362cbadb26052685566e2c1f75a0b68.camel@pengutronix.de>
Message-ID: <A49ACA24-D607-443F-8C96-4E2BEF902F8E@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Philipp,

On 2021/12/1, 5:12 PM, "Philipp Zabel" <p.zabel@pengutronix.de> wrote:

    Hi Billy,

    On Wed, 2021-12-01 at 03:30 +0000, Billy Tsai wrote:
    >   > Hi Philipp,
    >   > 
    >   > On 2021/11/30, 5:52 PM, "Philipp Zabel" <p.zabel@pengutronix.de> wrote:
    >   > 
    >   >     On Mon, 2021-11-29 at 14:43 +0800, Billy Tsai wrote:
    >   >     [...]
    >   >     >   > +	ret = clk_prepare_enable(priv->clk);
    >   >     >   > +	if (ret)
    >   >     >   > +		return dev_err_probe(dev, ret, "Couldn't enable clock\n");
    >   >     >   > +
    >   >     >   > +	ret = reset_control_deassert(priv->reset);
    >   >     >   > +	if (ret) {
    >   >     >   > +		dev_err_probe(dev, ret, "Couldn't deassert reset control\n");
    >   >     >   > +		goto err_disable_clk;
    >   >     >   > +	}
    >   > 
    >   >     >   Is there any reason to keep the clocks running and the controller out of
    >   >     >   reset while the PWM outputs are disabled?
    >   > 
    >   > Can you tell me about your concerns with this process?

    >   No particular concerns, just curiosity.

    >   > In my opinion, they are used to provide the clock and de-assert the reset of the PWM engine. If we didn't release
    >   > them in probe stage the CPU can't and shouldn't read the register of the PWM engine when call the get_state.
    >   > Assume that we want to adjust them dynamically, the driver needs to add more conditions to check and keep the status
    >   > of each PWM channel, which is not a good deal for the server platform.

    >   Thanks. I don't know the hardware, so I have no idea whether disabling
    >   the clocks would even save a measurable (let alone appreciable) amount
    >   of power.

    >   I've just seen other PWM drivers use runtime PM or enable/disable clocks
    >   dynamically, and wondered why this one doesn't.

Thanks for the heads up, I think that for the usage we don't need to implement that.

Best Regards,
Billy Tsai



