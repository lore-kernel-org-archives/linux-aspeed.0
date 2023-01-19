From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Date: Thu, 19 Jan 2023 08:41:36 +0100
Subject: [PATCH 1/2] spi: dt-bindings: drop unneeded quotes
In-Reply-To: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
Message-ID: <39af6fac-3e8e-4929-43b3-eb0b7af0ab30@foss.st.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof

On 1/18/23 18:39, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

[...]

> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> index 1eb17f7a4d86..8bba965a9ae6 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> @@ -11,7 +11,7 @@ maintainers:
>    - Patrice Chotard <patrice.chotard@foss.st.com>
>  
>  allOf:
> -  - $ref: "spi-controller.yaml#"
> +  - $ref: spi-controller.yaml#
>  
>  properties:
>    compatible:


For stm32-qspi 
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
