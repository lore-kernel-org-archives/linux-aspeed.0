From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 15 Feb 2022 07:27:43 +0100
Subject: [PATCH 03/10] spi: spi-mem: Add driver for Aspeed SMC controllers
In-Reply-To: <20220214094231.3753686-4-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-4-clg@kaod.org>
Message-ID: <20220215062743.GA12431@wunner.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 14, 2022 at 10:42:24AM +0100, C?dric Le Goater wrote:
> +static int aspeed_spi_probe(struct platform_device *pdev)
> +{
[...]
> +	ctlr = spi_alloc_master(dev, sizeof(*aspi));
> +	if (!ctlr)
> +		return -ENOMEM;

Use devm_spi_alloc_master() and remove the "put_controller" error path
for simplicity.


> +	ret = devm_spi_register_controller(dev, ctlr);
[...]
> +static int aspeed_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +	struct aspeed_spi *aspi = spi_controller_get_devdata(ctlr);
> +
> +	aspeed_spi_enable(aspi, false);
> +	spi_unregister_controller(ctlr);
> +	clk_disable_unprepare(aspi->clk);
> +	return 0;
> +}

You need to move the call to spi_unregister_controller() *before*
the call to aspeed_spi_enable().  The controller must be fully
operational until spi_unregister_controller() returns.

You also need to replace the call to devm_spi_register_controller()
in aspeed_spi_probe() with spi_register_controller().
Otherwise you'll unregister the controller twice because you're
calling spi_unregister_controller() in aspeed_spi_remove().

Thanks,

Lukas
