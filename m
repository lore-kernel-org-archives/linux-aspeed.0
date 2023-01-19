From: Serge Semin <fancer.lancer@gmail.com>
Date: Thu, 19 Jan 2023 19:24:31 +0300
Subject: [PATCH 1/2] spi: dt-bindings: drop unneeded quotes
In-Reply-To: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20230119162431.mepdze3xibqjgwsi@mobilestation>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 18, 2023 at 06:39:31PM +0100, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

[nip]

>  .../bindings/spi/snps,dw-apb-ssi.yaml          |  2 +-

[nip]

> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index d33b72fabc5d..a132b5fc56e0 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Mark Brown <broonie@kernel.org>
>  
>  allOf:
> -  - $ref: "spi-controller.yaml#"
> +  - $ref: spi-controller.yaml#
>    - if:
>        properties:
>          compatible:

For the Synopsys DW SSI bindings:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thanks
-Serge(y)

