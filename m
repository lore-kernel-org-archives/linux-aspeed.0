From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 26 Jul 2019 08:56:08 +0300
Subject: [PATCH v2 2/2] mmc: Add support for the ASPEED SD controller
In-Reply-To: <7cd30f3d-43fd-42da-9301-091eb2625c65@www.fastmail.com>
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-3-andrew@aj.id.au>
 <d6f7fdf2-07ed-354a-ca29-f3175623679c@intel.com>
 <7cd30f3d-43fd-42da-9301-091eb2625c65@www.fastmail.com>
Message-ID: <8a7bfe52-83ca-7601-7d75-e5615da7b5de@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/07/19 3:52 AM, Andrew Jeffery wrote:
> On Thu, 25 Jul 2019, at 22:49, Adrian Hunter wrote:
>> On 12/07/19 6:32 AM, Andrew Jeffery wrote:
>>> +static int aspeed_sdhci_probe(struct platform_device *pdev)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host;
>>> +	struct aspeed_sdhci *dev;
>>> +	struct sdhci_host *host;
>>> +	struct resource *res;
>>> +	int slot;
>>> +	int ret;
>>> +
>>> +	host = sdhci_pltfm_init(pdev, &aspeed_sdc_pdata, sizeof(*dev));
>>> +	if (IS_ERR(host))
>>> +		return PTR_ERR(host);
>>> +
>>> +	pltfm_host = sdhci_priv(host);
>>> +	dev = sdhci_pltfm_priv(pltfm_host);
>>> +	dev->parent = dev_get_drvdata(pdev->dev.parent);
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	slot = aspeed_sdhci_calculate_slot(dev, res);
>>> +	if (slot < 0)
>>> +		return slot;
>>> +	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
>>> +	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
>>
>> That implies that you only support 2 slots which begs the question why
>> you don't validate slot.
> 
> I'm not sure what you mean here, but I'll dig into it.

I just meant, if you only support 2 slots:

	if (slot > 1)
		return -EINVAL;
