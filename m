From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 29 Aug 2024 09:56:18 +0200
Subject: [PATCH v6 2/2] media: aspeed: Allow to capture from SoC display
 (GFX)
In-Reply-To: <20240829064508.3706672-3-jammy_huang@aspeedtech.com>
References: <20240829064508.3706672-1-jammy_huang@aspeedtech.com>
 <20240829064508.3706672-3-jammy_huang@aspeedtech.com>
Message-ID: <51d48faf-9f62-431f-b1bf-b78f0a30ae14@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/08/2024 08:45, Jammy Huang wrote:
> ASPEED BMC IC has 2 different display engines. Please find AST2600's
> datasheet to get detailed information.
> 

...

>  
> +/*
> + * Get regmap without checking res, such as clk/reset, that could lead to
> + * conflict.
> + */
> +static struct regmap *aspeed_regmap_lookup(struct device_node *np, const char *property)
> +{
> +	struct device_node *syscon_np __free(device_node) = of_parse_phandle(np, property, 0);
> +
> +	if (!syscon_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	return device_node_to_regmap(syscon_np);
> +}
> +
>  static int aspeed_video_init(struct aspeed_video *video)
>  {
>  	int irq;
>  	int rc;
>  	struct device *dev = video->dev;
>  
> +	video->scu = aspeed_regmap_lookup(dev->of_node, "aspeed,scu");
> +	video->gfx = aspeed_regmap_lookup(dev->of_node, "aspeed,gfx");

So that's a new property? Not related to conversion? Then split the
patches. Conversion is one logical change. Adding properties for new
hardware is completely different.

Best regards,
Krzysztof

