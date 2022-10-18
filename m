From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 18 Oct 2022 09:32:28 -0400
Subject: [PATCH] ARM: dts: ast2600-evb: correct compatible (drop -a1)
In-Reply-To: <20220804092727.64742-1-krzysztof.kozlowski@linaro.org>
References: <20220804092727.64742-1-krzysztof.kozlowski@linaro.org>
Message-ID: <d681e41f-fd8e-f233-2a25-53c4e0a52c33@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 04/08/2022 05:27, Krzysztof Kozlowski wrote:
> Due to copy-paste, the ast2600-evb and ast2600-evb-a1 got the same
> compatible.  Drop the '-a1' suffix from the first to match what is
> expected by bindings.
> 
> Fixes: aa5e06208500 ("ARM: dts: ast2600-evb: fix board compatible")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index c698e6538269..2010e3cb6158 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "AST2600 EVB";
> -	compatible = "aspeed,ast2600-evb-a1", "aspeed,ast2600";
> +	compatible = "aspeed,ast2600-evb", "aspeed,ast2600";

This is weird. I sent this patch on 4th August but it was never
applied... yet instead I see a commit in mainline from end of September:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d916109169159f9319f45ce7e1339e41eccf22c4
which was never sent to mailing list.

So instead of picking up existing commit from mailing list waiting there
for 1.5 months, Joel just committed something without sharing in public way.

Best regards,
Krzysztof

