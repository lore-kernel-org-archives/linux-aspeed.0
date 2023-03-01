From: Joel Stanley <joel@jms.id.au>
Date: Wed, 1 Mar 2023 00:50:24 +0000
Subject: [PATCH v4 1/5] clk: ast2600: allow empty entries in aspeed_g6_gates
In-Reply-To: <20230228091638.206569-2-jk@codeconstruct.com.au>
References: <20230228091638.206569-1-jk@codeconstruct.com.au> <20230228091638.206569-2-jk@codeconstruct.com.au>
Message-ID: <CACPK8XffdV3YMy0eu4sZQhw-tS2g5kz_RHLD98Up9G0P9NAR4A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 28 Feb 2023 at 09:16, Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> We're about to remove an entry from aspeed_g6_gates, but we won't want
> to alter/reorder existing entries. Allow empty entries in this array.

Nice. So it's recorded somewhere: the gates array should be
sequential, with the include/dt-bindings/clock/ast2600-clock.h defines
starting at 0 and counting up. If a clock gets mistakenly added and
needs to be removed, we can't have a "hole" in the array so instead we
leave it NULL and skip over adding it.

We could simply remove the bad entry but this would break the
theoretical case of a device tree with an old header, so we leave the
gaps in place :(

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel




>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
>
> ---
> v3:
>  - reword commit message
> ---
>  drivers/clk/clk-ast2600.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index 9c3305bcb27a..1f08ff3c60fa 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -652,6 +652,9 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
>                 const struct aspeed_gate_data *gd = &aspeed_g6_gates[i];
>                 u32 gate_flags;
>
> +               if (!gd->name)
> +                       continue;
> +
>                 /*
>                  * Special case: the USB port 1 clock (bit 14) is always
>                  * working the opposite way from the other ones.
> --
> 2.39.1
>
