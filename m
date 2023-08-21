From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 21 Aug 2023 21:29:36 +0200
Subject: [PATCH v1 1/1] soc/aspeed: Add host side BMC device driver
In-Reply-To: <20230821183525.3427144-2-ninad@linux.ibm.com>
References: <20230821183525.3427144-1-ninad@linux.ibm.com>
 <20230821183525.3427144-2-ninad@linux.ibm.com>
Message-ID: <5159abb8-1b4c-4576-b370-4dd9db142beb@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Testing:
>   - This is tested on IBM rainier system with BMC. It requires BMC side
>     BMC device driver which is available in the ASPEED's 5.15 SDK
>     kernel.

How relevant is that? To the host side, it just appears to be an
16550A. Is the SDK emulating an 16550A? If you where to use a
different kernel, is it still guaranteed to be an 16550A? I also
notice there is a mainline
drivers/tty/serial/8250/8250_aspeed_vuart.c. Could that be used on the
BMC? That would be a better testing target than the vendor kernel.

> +config ASPEED_HOST_BMC_DEV
> +	bool "ASPEED SoC Host BMC device driver"
> +	default ARCH_ASPEED
> +	select SOC_BUS
> +	default ARCH_ASPEED

same default twice?

> +static int __init aspeed_host_bmc_device_init(void)
> +{
> +	int ret;
> +
> +	/* register pci driver */
> +	ret = pci_register_driver(&aspeed_host_bmc_dev_driver);
> +	if (ret < 0) {
> +		pr_err("pci-driver: can't register pci driver\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +}
> +
> +static void aspeed_host_bmc_device_exit(void)
> +{
> +	/* unregister pci driver */
> +	pci_unregister_driver(&aspeed_host_bmc_dev_driver);
> +}
> +
> +late_initcall(aspeed_host_bmc_device_init);
> +module_exit(aspeed_host_bmc_device_exit);

It looks like you can use module_pci_driver() ?
