From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Thu, 4 Aug 2022 08:14:28 -0700
Subject: [PATCH v2] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc
 compatible after rename
In-Reply-To: <20220804150935.121890-1-krzysztof.kozlowski@linaro.org>
References: <20220804150935.121890-1-krzysztof.kozlowski@linaro.org>
Message-ID: <7f698b2b-bc4f-e5a4-fdf1-2de228791607@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 8/4/2022 8:09 AM, Krzysztof Kozlowski wrote:
> The Nuvia DC-SCM BMC board compatible was renamed iin commit
> 7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
> so adjust the bindings as well.
> 
> Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Acked-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>

Thanks,
Jae

> 
> Changes since v1:
> 1. Use proper qcom compatible.
> ---
>   Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 1895ce9de461..4f0b308e9f0f 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -80,7 +80,7 @@ properties:
>                 - ibm,tacoma-bmc
>                 - inventec,transformer-bmc
>                 - jabil,rbp-bmc
> -              - nuvia,dc-scm-bmc
> +              - qcom,dc-scm-v1-bmc
>                 - quanta,s6q-bmc
>             - const: aspeed,ast2600
>   
