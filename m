From: Joel Stanley <joel@jms.id.au>
Date: Fri, 1 Nov 2019 04:50:42 +0000
Subject: [PATCH v2 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate
 definitions
In-Reply-To: <20191010020725.3990-2-andrew@aj.id.au>
References: <20191010020725.3990-1-andrew@aj.id.au>
 <20191010020725.3990-2-andrew@aj.id.au>
Message-ID: <CACPK8XcGgGsoLNpCccKPb-5bojQS4c5BePewwocc-z29On7Rjg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi clock maintainers,

On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The AST2600 has an explicit gate for the RMII RCLK for each of the four
> MACs.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

I needed this patch and the aspeed-clock.h one for the aspeed dts
tree, so I've put them in a branch called "aspeed-clk-for-v5.5" and
merged that into the aspeed tree. Could you merge that into the clock
tree when you get to merging these ones?

https://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git/log/?h=aspeed-clk-for-v5.5

Cheers,

Joel

> ---
>  include/dt-bindings/clock/ast2600-clock.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
> index 38074a5f7296..62b9520a00fd 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -83,6 +83,10 @@
>  #define ASPEED_CLK_MAC12               64
>  #define ASPEED_CLK_MAC34               65
>  #define ASPEED_CLK_USBPHY_40M          66
> +#define ASPEED_CLK_MAC1RCLK            67
> +#define ASPEED_CLK_MAC2RCLK            68
> +#define ASPEED_CLK_MAC3RCLK            69
> +#define ASPEED_CLK_MAC4RCLK            70
>
>  /* Only list resets here that are not part of a gate */
>  #define ASPEED_RESET_ADC               55
> --
> 2.20.1
>
