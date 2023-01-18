From: Joel Stanley <joel@jms.id.au>
Date: Wed, 18 Jan 2023 22:44:27 +0000
Subject: [PATCH] arm: dts: aspeed: tyan s8036: enable kcs interrupts.
In-Reply-To: <20230118150030.2079226-1-aaelhaj@google.com>
References: <20230118150030.2079226-1-aaelhaj@google.com>
Message-ID: <CACPK8XeAX8de_J7px2R2Bc0V7m7hMgGEfB1xpkwFKDzDDr73Og@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 18 Jan 2023 at 15:00, Ali El-Haj-Mahmoud <aaelhaj@google.com> wrote:
>
> When the BIOS is built with kcs interrupts enabled, not enabling
> interrupts on the BMC results in very poor IPMI performance.
> The other way around (BIOS with interrupts disabled, BMC with
> interrupts enabled) doesn't suffer degraded IPMI performance.
> Enabling interrupts on the BMC covers both scenarios, and should
> be the default.
>
> TESTED: manually verified IPMI performance when BIOS is built with and
> without KCS interrupts.
>
> Signed-off-by: Ali El-Haj-Mahmoud <aaelhaj@google.com>

Thanks, I've applied this for 6.3.

> ---
>  arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
> index 708ee78e4b83..f6c4549c0ac4 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
> @@ -364,6 +364,7 @@ &kcs1 {
>  &kcs3 {
>         status = "okay";
>         aspeed,lpc-io-reg = <0xca2>;
> +       aspeed,lpc-interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
>  };
>
>  /* Enable BMC VGA output to show an early (pre-BIOS) boot screen */
> --
> 2.39.0.314.g84b9a713c41-goog
>
