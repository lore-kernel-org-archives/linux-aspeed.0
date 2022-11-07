From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 7 Nov 2022 08:47:35 +0000
Subject: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
In-Reply-To: <OS0PR01MB5922014A7D74A884D2E7BDC286399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-3-billy_tsai@aspeedtech.com>
 <OS0PR01MB5922014A7D74A884D2E7BDC286399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Message-ID: <C7224BE1-D81E-4FE0-8B7C-5A3CA69898D2@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2022/11/2, 11:56 PM, "Biju Das" <biju.das.jz@bp.renesas.com> wrote:

    > > +	parent_dev = of_find_device_by_node(np);
    > > +	priv->clk = devm_clk_get_enabled(&parent_dev->dev, NULL);
    > > +	if (IS_ERR(priv->clk))
    > > +		return dev_err_probe(dev, PTR_ERR(priv->clk),
    > > +				     "Couldn't get clock\n");

    > What is the use case?

    > Is pwm configured by boot loader initially ?

    > Or

    > pwm configured by Linux, not by the bootloader initially?

    > Or

    > Driver needs to handle both cases?

    > Just asking, because you are turning on the clock unnecessarily here,
    > If you need to address all the use cases. If it is just first one, then
    > It is ok.

Hi Biju,

The driver want to handle all of the use cases. Can you tell me why turning on the clock
is unnecessarily here?

Thanks

Best Regards,
Billy Tsai



