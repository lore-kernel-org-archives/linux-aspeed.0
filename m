From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 7 Oct 2024 08:58:28 +0200
Subject: [PATCH 1/4] dt-bindings: watchdog: aspeed: Add property for WDT
 SW reset
In-Reply-To: <20241007063408.2360874-2-chin-ting_kuo@aspeedtech.com>
References: <20241007063408.2360874-1-chin-ting_kuo@aspeedtech.com>
 <20241007063408.2360874-2-chin-ting_kuo@aspeedtech.com>
Message-ID: <6bb599b4-141c-43a5-8b9f-4cf6ca6c3384@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 07/10/2024 08:34, Chin-Ting Kuo wrote:
> Add "aspeed,restart-sw" property to distinguish normal WDT
> reset from system restart triggered by SW consciously.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  .../bindings/watchdog/aspeed,ast2400-wdt.yaml         | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> index be78a9865584..6cc3604c295a 100644
> --- a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
> @@ -95,6 +95,17 @@ properties:
>        array with the first word defined using the AST2600_WDT_RESET1_* macros,
>        and the second word defined using the AST2600_WDT_RESET2_* macros.
>  
> +  aspeed,restart-sw:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: >

Why >?

> +      Normally, ASPEED WDT reset may occur when system hangs or reboot
> +      triggered by SW consciously. However, system doesn't know whether the
> +      restart is triggered by SW consciously since the reset event flag is
> +      the same as normal WDT timeout reset. With this property, SW can

So DTS has this property and watchdog bites (timeout) but you will
ignore it and claim that it was software choice?

This does not make much sense to me, at least based on this explanation

> +      restart the system immediately and directly without wait for WDT
> +      timeout occurs. The reset event flag is also different from the normal
> +      WDT reset. This property is only supported since AST2600 platform.

Supported as drivers? How is this related? Or you mean hardware? Then
property should be restricted there.

Best regards,
Krzysztof

