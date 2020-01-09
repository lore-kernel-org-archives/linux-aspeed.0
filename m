From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 09 Jan 2020 15:38:20 +1030
Subject: [PATCH v4 06/12] soc: aspeed: Add XDMA Engine Driver
In-Reply-To: <1577993276-2184-7-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-7-git-send-email-eajames@linux.ibm.com>
Message-ID: <3c44c745-d39a-4724-860d-a66537b2adbb@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 3 Jan 2020, at 05:57, Eddie James wrote:
> +static int aspeed_xdma_init_scu(struct aspeed_xdma *ctx, struct device *dev)
> +{
> +	struct regmap *scu = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							     "aspeed,scu");
> +
> +	if (!IS_ERR(scu)) {
> +		u32 selection;
> +		bool pcie_device_bmc = true;
> +		const u32 bmc = SCU_PCIE_CONF_BMC_EN |
> +			SCU_PCIE_CONF_BMC_EN_MSI | SCU_PCIE_CONF_BMC_EN_IRQ |
> +			SCU_PCIE_CONF_BMC_EN_DMA;
> +		const u32 vga = SCU_PCIE_CONF_VGA_EN |
> +			SCU_PCIE_CONF_VGA_EN_MSI | SCU_PCIE_CONF_VGA_EN_IRQ |
> +			SCU_PCIE_CONF_VGA_EN_DMA;
> +		const char *pcie = NULL;
> +
> +		if (!of_property_read_string(dev->of_node, "pcie-device",
> +					     &pcie)) {
> +			if (!strcmp(pcie, "vga")) {
> +				pcie_device_bmc = false;
> +			} else if (strcmp(pcie, "bmc")) {
> +				dev_err(dev,
> +					"Invalid pcie-device property %s.\n",
> +					pcie);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		if (pcie_device_bmc) {
> +			selection = bmc;
> +			regmap_write(scu, ctx->chip->scu_bmc_class,
> +				     SCU_BMC_CLASS_REV_XDMA);
> +		} else {
> +			selection = vga;
> +		}
> +
> +		regmap_update_bits(scu, ctx->chip->scu_pcie_conf, bmc | vga,
> +				   selection);
> +	} else {
> +		dev_warn(dev, "Unable to configure PCIe; continuing.\n");
> +	}

Not something you need to fix but generally I'd structure this as a early-return:

    if (IS_ERR(scu)) {
        dev_warn(dev, "Unable to configure PCIe; continuing.\n");
        return 0;
    }
    ...

Could probably also improve the warning message to say what caused the
failure, but again, something that can be changed later.
