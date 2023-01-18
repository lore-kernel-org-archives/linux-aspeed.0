From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 17 Jan 2023 17:08:22 -0800
Subject: [PATCH net-next 6/6] net: phy: Remove probe_capabilities
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-6-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
 <20230116-net-next-remove-probe-capabilities-v1-6-5aa29738a023@walle.cc>
Message-ID: <a4da45c6-7a04-c649-b841-ee1567c531ea@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/16/2023 4:55 AM, Michael Walle wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Deciding if to probe of PHYs using C45 is now determine by if the bus
> provides the C45 read method. This makes probe_capabilities redundant
> so remove it.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michael Walle <michael@walle.cc>
...

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index fceaac0fb319..fbeba4fee8d4 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -419,14 +419,6 @@ struct mii_bus {
>   	/** @reset_gpiod: Reset GPIO descriptor pointer */
>   	struct gpio_desc *reset_gpiod;
>   
> -	/** @probe_capabilities: bus capabilities, used for probing */
> -	enum {
> -		MDIOBUS_NO_CAP = 0,
> -		MDIOBUS_C22,
> -		MDIOBUS_C45,
> -		MDIOBUS_C22_C45,
> -	} probe_capabilities;
> -

I'm a little surprised there is no Documentation regarding this stuff, 
that needs to be removed or fixed up, but since there isn't...

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

