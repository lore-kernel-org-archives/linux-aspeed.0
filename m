From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 14 Aug 2024 08:09:06 +0200
Subject: [PATCH v4 2/2] media: aspeed: Allow to capture from SoC display
 (GFX)
In-Reply-To: <20240814005421.3362441-3-jammy_huang@aspeedtech.com>
References: <20240814005421.3362441-1-jammy_huang@aspeedtech.com>
 <20240814005421.3362441-3-jammy_huang@aspeedtech.com>
Message-ID: <003090ab-4ce2-4624-b5c5-33ceef521e9d@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/08/2024 02:54, Jammy Huang wrote:
> +/*
> + * Get regmap without checking res, such as clk/reset, that could lead to
> + * conflict.
> + */
> +static struct regmap *aspeed_regmap_lookup(struct device_node *np, const char *property)
> +{
> +	struct device_node *syscon_np __free(device_node) = of_parse_phandle(np, property, 0);
> +	struct regmap *regmap;

Drop. The point of using __free was to make this very simple.

> +
> +	if (!syscon_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	regmap = device_node_to_regmap(syscon_np);
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

Still undocumented. Respond to previous comment and confirm that you
understood it.


Best regards,
Krzysztof

