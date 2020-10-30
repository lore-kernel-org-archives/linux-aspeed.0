From: Joel Stanley <joel@jms.id.au>
Date: Fri, 30 Oct 2020 03:47:45 +0000
Subject: [PATCH] ARM: dts: aspeed-g6: Fix HVI3C function-group in pinctrl
 dtsi
In-Reply-To: <20201029062723.20798-1-dylan_hung@aspeedtech.com>
References: <20201029062723.20798-1-dylan_hung@aspeedtech.com>
Message-ID: <CACPK8XcJ6oWkj04kb3cjNkYY4q48Vk2p7zitCDp1_Q8etjFb1w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2020 at 06:28, Dylan Hung <dylan_hung@aspeedtech.com> wrote:
>
> The HVI3C shall be a group of I3C function, not an independent function.
> Correct the function name from "HVI3C" to "I3C".
>
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>

Fixes: f510f04c8c83 ("ARM: dts: aspeed: Add AST2600 pinmux nodes")

I have a few device tree fixes for 5.10 that I will include this in.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> index 7028e21bdd98..910eacc8ad3b 100644
> --- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> @@ -208,12 +208,12 @@
>         };
>
>         pinctrl_hvi3c3_default: hvi3c3_default {
> -               function = "HVI3C3";
> +               function = "I3C3";
>                 groups = "HVI3C3";
>         };
>
>         pinctrl_hvi3c4_default: hvi3c4_default {
> -               function = "HVI3C4";
> +               function = "I3C4";
>                 groups = "HVI3C4";
>         };
>
> --
> 2.17.1
>
