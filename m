From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Mar 2023 00:51:29 +0000
Subject: [PATCH v4 2/5] dt-bindings: clock: ast2600: Add top-level I3C clock
In-Reply-To: <20230228091638.206569-3-jk@codeconstruct.com.au>
References: <20230228091638.206569-1-jk@codeconstruct.com.au> <20230228091638.206569-3-jk@codeconstruct.com.au>
Message-ID: <CACPK8XebiPGe3o7uQgvpOyQ5tzn+o-AyugbJOqUh+4QzG8QgrA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 28 Feb 2023 at 09:16, Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> The ast2600 hardware has a top-level clock for all i3c controller
> peripherals (then gated to each individual controller), so add a
> top-level i3c clock line to control this.
>
> This is a partial cherry-pick and rework of ed44b8cdfdb and 1a35eb926d7
> from Aspeed's own tree, originally by Dylan Hung
> <dylan_hung@aspeedtech.com>.
>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> ---
> v4:
>  - use contiguous clock index
> v3:
>  - split into separate bindings & clk changes
> v2:
>  - reword commit message
> ---
>  include/dt-bindings/clock/ast2600-clock.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> index d8b0db2f7a7d..dd1581bfdf58 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -87,6 +87,7 @@
>  #define ASPEED_CLK_MAC2RCLK            68
>  #define ASPEED_CLK_MAC3RCLK            69
>  #define ASPEED_CLK_MAC4RCLK            70
> +#define ASPEED_CLK_I3C                 71
>
>  /* Only list resets here that are not part of a gate */
>  #define ASPEED_RESET_ADC               55
> --
> 2.39.1
>
