From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 5 Sep 2024 13:50:35 +0200
Subject: [PATCH 2/2] net: mdio: aspeed: Add AST2700 support
In-Reply-To: <20240905114754.519609-3-jacky_chou@aspeedtech.com>
References: <20240905114754.519609-1-jacky_chou@aspeedtech.com>
 <20240905114754.519609-3-jacky_chou@aspeedtech.com>
Message-ID: <ce910c90-0655-42d2-8b1b-d912698d4556@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 05/09/2024 13:47, Jacky Chou wrote:
> Add AST2700 compatible for Aspeed MDIO driver.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/mdio/mdio-aspeed.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
> index c2170650415c..607e5c56434f 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -188,6 +188,7 @@ static void aspeed_mdio_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id aspeed_mdio_of_match[] = {
>  	{ .compatible = "aspeed,ast2600-mdio", },
> +	{ .compatible = "aspeed,ast2700-mdio", },

Why? They are compatible, aren't they? Write useful commit msgs so you
won't get simple questions on each review.

Best regards,
Krzysztof

