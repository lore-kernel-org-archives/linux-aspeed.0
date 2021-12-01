From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 1 Dec 2021 03:30:00 +0000
Subject: [v13 2/2] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <e28a5d5de9b940717e6444f019eab63ab1bb0b75.camel@pengutronix.de>
References: <20211129064329.27006-1-billy_tsai@aspeedtech.com>
 <20211129064329.27006-3-billy_tsai@aspeedtech.com>
 <e28a5d5de9b940717e6444f019eab63ab1bb0b75.camel@pengutronix.de>
Message-ID: <CDB0374F-3835-4501-964E-DB771588114D@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Philipp,

On 2021/11/30, 5:52 PM, "Philipp Zabel" <p.zabel@pengutronix.de> wrote:

    On Mon, 2021-11-29 at 14:43 +0800, Billy Tsai wrote:
    [...]
    >   > +	ret = clk_prepare_enable(priv->clk);
    >   > +	if (ret)
    >   > +		return dev_err_probe(dev, ret, "Couldn't enable clock\n");
    >   > +
    >   > +	ret = reset_control_deassert(priv->reset);
    >   > +	if (ret) {
    >   > +		dev_err_probe(dev, ret, "Couldn't deassert reset control\n");
    >   > +		goto err_disable_clk;
    >   > +	}

    >   Is there any reason to keep the clocks running and the controller out of
    >   reset while the PWM outputs are disabled?

Can you tell me about your concerns with this process?
In my opinion, they are used to provide the clock and de-assert the reset of the PWM engine. If we didn't release
them in probe stage the CPU can't and shouldn't read the register of the PWM engine when call the get_state.
Assume that we want to adjust them dynamically, the driver needs to add more conditions to check and keep the status
of each PWM channel, which is not a good deal for the server platform.

Thanks

Best Regards,
Billy Tsai


