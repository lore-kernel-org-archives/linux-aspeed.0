From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 4 Aug 2022 17:10:18 +0200
Subject: [PATCH] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc
 compatible after rename
In-Reply-To: <20220804092710.64636-1-krzysztof.kozlowski@linaro.org>
References: <20220804092710.64636-1-krzysztof.kozlowski@linaro.org>
Message-ID: <1260ddb0-7022-4934-e579-8ca6d9e87b7f@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 04/08/2022 11:27, Krzysztof Kozlowski wrote:
> The Nuvia DC-SCM BMC board compatible was renamed iin commit
> 7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
> so adjust the bindings as well.
> 
> Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 1895ce9de461..20469519e497 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -80,7 +80,7 @@ properties:
>                - ibm,tacoma-bmc
>                - inventec,transformer-bmc
>                - jabil,rbp-bmc
> -              - nuvia,dc-scm-bmc
> +              - qcom,dc-scm-bmc

I missed to add last-minute change, so this is not correct.

Best regards,
Krzysztof
