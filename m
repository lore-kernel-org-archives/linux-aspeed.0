From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Jun 2022 07:57:40 +0200
Subject: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
In-Reply-To: <20220629032008.1579899-3-neal_liu@aspeedtech.com>
References: <20220629032008.1579899-1-neal_liu@aspeedtech.com>
 <20220629032008.1579899-3-neal_liu@aspeedtech.com>
Message-ID: <b70e06e7-81fc-dfc1-f9c5-f83cb4a18293@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/06/2022 05:20, Neal Liu wrote:
> Add HACE reset bit definition for AST2500/AST2600.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  include/dt-bindings/clock/aspeed-clock.h  | 3 ++-
>  include/dt-bindings/clock/ast2600-clock.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> index 9ff4f6e4558c..6e040f7c3426 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -46,11 +46,12 @@
>  #define ASPEED_RESET_MCTP		1
>  #define ASPEED_RESET_ADC		2
>  #define ASPEED_RESET_JTAG_MASTER	3
> -#define ASPEED_RESET_MIC		4
> +#define ASPEED_RESET_HACE		4

I did not ack such change. This is a significant change from previous
version, invalidating my previous ack.

This breaks the ABI, so NAK without proper explanation why ABI break is
accepted.

>  #define ASPEED_RESET_PWM		5
>  #define ASPEED_RESET_PECI		6
>  #define ASPEED_RESET_I2C		7
>  #define ASPEED_RESET_AHB		8
>  #define ASPEED_RESET_CRT1		9
> +#define ASPEED_RESET_MIC		18
>  
>  #endif
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> index 62b9520a00fd..d8b0db2f7a7d 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -111,6 +111,7 @@
>  #define ASPEED_RESET_PCIE_RC_O		19
>  #define ASPEED_RESET_PCIE_RC_OEN	18
>  #define ASPEED_RESET_PCI_DP		5
> +#define ASPEED_RESET_HACE		4
>  #define ASPEED_RESET_AHB		1
>  #define ASPEED_RESET_SDRAM		0
>  


Best regards,
Krzysztof
