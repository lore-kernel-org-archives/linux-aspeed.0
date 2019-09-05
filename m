From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 05 Sep 2019 09:14:44 +0800
Subject: [PATCH v2 1/3] drivers/tty/serial/8250: Make Aspeed VUART SIRQ
 polarity configurable
In-Reply-To: <20190731013404.243755-1-osk@google.com>
References: <20190731013404.243755-1-osk@google.com>
Message-ID: <a2ff0b6edb87d5495dd8e683e95d3b719e55f970.camel@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Oskar,

Looks good to me, some minor comments though:

> +
> +What:		/sys/bus/platform/drivers/aspeed-vuart/*/sirq_polarity
> +Date:		July 2019
> +Contact:	Oskar Senft <osk@google.com>
> +Description:	Configures the polarity of the serial interrupt to the
> +		host via the BMC LPC bus.

Can you mention what the value represents? 1/0 don't really indicate a
specific polarity.

Alternatively, we could use descriptive values (say, "active-low" /
"idle-low").

> @@ -310,6 +379,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	u32 clk, prop;
>  	int rc;
> +	struct of_phandle_args espi_enabled_args;

Minor: can you reverse-christmas-tree this?

> @@ -402,6 +472,18 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
>  
>  	vuart->line = rc;
>  
> +	rc = of_parse_phandle_with_fixed_args(
> +		np, "espi-enabled", 2, 0, &espi_enabled_args);
> +	if (rc < 0) {
> +		dev_warn(&pdev->dev, "espi-enabled property not found\n");

In the binding spec, you've listed this property at optional, but here
we dev_warn() if its not present. Can we default to existing behaviour
if it's not there?

That may just be a matter of changing this to dev_debug.

Cheers,


Jeremy

