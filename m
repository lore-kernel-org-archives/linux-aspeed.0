From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 12 Aug 2024 14:17:45 +0200
Subject: [PATCH v3] media: aspeed: Allow to capture from SoC display (GFX)
In-Reply-To: <20240812091656.2617664-1-jammy_huang@aspeedtech.com>
References: <20240812091656.2617664-1-jammy_huang@aspeedtech.com>
Message-ID: <323f5038-f9d5-459a-a5e2-f1e4dbd4c386@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/08/2024 11:16, Jammy Huang wrote:
> ASPEED BMC IC has 2 different display engines. Please find AST2600's
> datasheet to get detailed information.
> 
> 1. VGA on PCIe
> 2. SoC Display (GFX)

...

>  
> +/*
> + * Get regmap without checking res, such as clk/reset, that could lead to
> + * conflict.
> + */
> +static struct regmap *aspeed_regmap_lookup(struct device_node *np, const char *property)
> +{
> +	struct device_node *syscon_np;
> +	struct regmap *regmap;

Drop...

> +
> +	syscon_np = of_parse_phandle(np, property, 0);

This joins first line and then use scoped/cleanup to make everything
simpler.

> +	if (!syscon_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	regmap = device_node_to_regmap(syscon_np);
> +	of_node_put(syscon_np);
> +
> +	return regmap;
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

This looks undocumented.

You will need to convert the bindings to DT Schema first.

Anyway, you miss here error checking.

Best regards,
Krzysztof

