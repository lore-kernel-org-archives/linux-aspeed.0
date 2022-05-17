From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 17 May 2022 14:03:39 +0200
Subject: [PATCH v2 3/3] dt-bindings: usb: add documentation for aspeed udc
In-Reply-To: <20220517082558.3534161-4-neal_liu@aspeedtech.com>
References: <20220517082558.3534161-1-neal_liu@aspeedtech.com>
 <20220517082558.3534161-4-neal_liu@aspeedtech.com>
Message-ID: <414d09f8-328a-4bf4-c20e-f8ce4a6ddfc7@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 17/05/2022 10:25, Neal Liu wrote:
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    usb: usb at 1e6a2000 {
> +            compatible = "aspeed,ast2600-udc";

Sorry for not noticing it earlier - slipped through the cracks. You use
here unusual indentation (not matching the rest of the example - above
is 4 spaces, here is 7 or 8).

Just keep 4 spaces for DTS example.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
