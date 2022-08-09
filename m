From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Aug 2022 12:37:24 -0600
Subject: [PATCH v2] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc
 compatible after rename
In-Reply-To: <20220804150935.121890-1-krzysztof.kozlowski@linaro.org>
References: <20220804150935.121890-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20220809183724.GA2163454-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 04 Aug 2022 17:09:35 +0200, Krzysztof Kozlowski wrote:
> The Nuvia DC-SCM BMC board compatible was renamed iin commit
> 7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
> so adjust the bindings as well.
> 
> Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Use proper qcom compatible.
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
