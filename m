From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 13:42:53 +0930
Subject: [PATCH 13/14] arm: dts: OpenPower Romulus system can use
 coprocessor for FSI
In-Reply-To: <20180626232605.13420-14-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-14-benh@kernel.crashing.org>
Message-ID: <CACPK8XcyncbmU3kMVPVZV49Hnt+avbzgUOL=KMP+Ed12axWqRQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I will take this through the ASPEED SoC tree once we've got acks on
the bindings.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> index 347938673c83..070b8f8f1d62 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> @@ -37,6 +37,11 @@
>                         compatible = "shared-dma-pool";
>                         reusable;
>                 };
> +
> +               coldfire_memory: codefire_memory at 9ef00000 {
> +                       reg = <0x9ef00000 0x00100000>;
> +                       no-map;
> +               };
>         };
>
>         leds {
> @@ -56,10 +61,16 @@
>         };
>
>         fsi: gpio-fsi {
> -               compatible = "fsi-master-gpio", "fsi-master";
> +               compatible = "ibm,fsi-master-ast2500-cf", "fsi-master";
>                 #address-cells = <2>;
>                 #size-cells = <0>;
> -               no-gpio-delays;
> +
> +               memory-region = <&coldfire_memory>;
> +               sram = <&sram>;
> +               cvic = <&cvic>;
> +
> +               fw-name = "romulus";
> +               fw-platform-sig = <0x526d>;
>
>                 clock-gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
>                 data-gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_HIGH>;
> --
> 2.17.1
>
