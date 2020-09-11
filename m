From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Sep 2020 01:33:49 +0000
Subject: [PATCH 1/4] dt-bindings: clock: Add AST2600 APLLdivN definition
In-Reply-To: <20200910151840.25333-2-eajames@linux.ibm.com>
References: <20200910151840.25333-1-eajames@linux.ibm.com>
 <20200910151840.25333-2-eajames@linux.ibm.com>
Message-ID: <CACPK8XcywanG8BN0-0a41CeTJEAb89OR7SnsPRgbddaC01vO-w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2020 at 15:18, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add a new clock definition for the "APLLdivN" as described in the
> AST2600 specification. This clock is simply the APLL divided by a
> factor defined in the SCU registers. It is the input to the FSI
> bus.

Ah, that's where the name comes from. Would calling it APLL_DIV make more sense?

>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  include/dt-bindings/clock/ast2600-clock.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> index 62b9520a00fd..5a9ae0a1d574 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -87,6 +87,7 @@
>  #define ASPEED_CLK_MAC2RCLK            68
>  #define ASPEED_CLK_MAC3RCLK            69
>  #define ASPEED_CLK_MAC4RCLK            70
> +#define ASPEED_CLK_APLLN               71
>
>  /* Only list resets here that are not part of a gate */
>  #define ASPEED_RESET_ADC               55
> --
> 2.26.2
>
