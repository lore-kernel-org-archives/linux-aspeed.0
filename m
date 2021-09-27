From: Rob Herring <robh@kernel.org>
Date: Mon, 27 Sep 2021 13:59:11 -0500
Subject: [PATCH 10/10] dt-bindings: mmc: aspeed: Add a new compatible
 string
In-Reply-To: <20210922103116.30652-11-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-11-chin-ting_kuo@aspeedtech.com>
Message-ID: <YVIUf7/4ukMcrOb9@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 22, 2021 at 06:31:16PM +0800, Chin-Ting Kuo wrote:
> Add "aspeed,ast2600-emmc" compatible string for the sake of
> distinguishing between SD and eMMC device.

Why?

Is the h/w block different? We already have properties to handle some of 
the eMMC specifics. Also, you can have a child node for the eMMC device 
if you need that.

> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 5bb66849df65..41105cd104c6 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -52,6 +52,7 @@ patternProperties:
>            - aspeed,ast2400-sdhci
>            - aspeed,ast2500-sdhci
>            - aspeed,ast2600-sdhci
> +          - aspeed,ast2600-emmc
>        reg:
>          maxItems: 1
>          description: The SDHCI registers
> -- 
> 2.17.1
> 
> 
