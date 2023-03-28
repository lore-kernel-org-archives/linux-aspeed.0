From: Andi Shyti <andi.shyti@kernel.org>
Date: Tue, 28 Mar 2023 15:12:19 +0200
Subject: [PATCH v7 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <20230327092524.3916389-3-ryan_chen@aspeedtech.com>
References: <20230327092524.3916389-1-ryan_chen@aspeedtech.com>
 <20230327092524.3916389-3-ryan_chen@aspeedtech.com>
Message-ID: <20230328131219.khfd2jz3z4es5bzy@intel.intel>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

[...]

> +	ret = of_property_read_u32(dev->of_node,
> +							"i2c-scl-clk-low-timeout-us",
> +							&i2c_bus->timeout);

in your v6 patch this was a boolean value. If you need to keep it
boolean you have the "i2c-scl-has-clk-low-timeout".

> +	if (ret < 0) {
> +		i2c_bus->timeout = 0;
> +	} else {
> +		/* i2c timeout counter: use base clk4 1Mhz
> +		 * per unit: 1/(1000/4096) = 4096us
> +		 */
> +		i2c_bus->timeout /= 4096;
> +	}

Can you please run checkpatch.pl before sending the patch?

[...]

> +	dev_info(dev, "%s [%d]: adapter [%d khz] mode [%d]\n",
> +		 dev->of_node->name, i2c_bus->adap.nr, i2c_bus->bus_frequency / 1000,
> +		 i2c_bus->mode);
> +
> +	return 0;
> +
> +	return ret;

can you also please do some cleanups before sending the patch?

Thanks,
Andi
