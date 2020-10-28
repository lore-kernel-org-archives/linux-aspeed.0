From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Oct 2020 05:25:54 +0000
Subject: [PATCH 1/3] ARM: dts: aspeed: amd-ethanolx: Update KCS nodes to
 use v2 binding
In-Reply-To: <20201027123722.2935-1-aladyshev22@gmail.com>
References: <20201027123722.2935-1-aladyshev22@gmail.com>
Message-ID: <CACPK8XcgKTEEfPL54Spd_AQTdJVm=xt+rqbteaYygLQw-GKRcQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2020 at 12:38, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> KCS nodes compatible property in the 'aspeed-g5.dtsi' file was
> changed to use v2 binding in the commit fa4c8ec6feaa
> ("ARM: dts: aspeed: Change KCS nodes to v2 binding").
> For the proper initialization of /dev/ipmi-kcs* devices
> KCS node variables also need to be changed to use v2 binding.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Fixes: 09f5f680707e ("ipmi: kcs: aspeed: Implement v2 bindings")
Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index 60ba86f3e5bc..89ddc3847222 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -139,17 +139,17 @@
>
>  &kcs1 {
>         status = "okay";
> -       kcs_addr = <0x60>;
> +       aspeed,lpc-io-reg = <0x60>;
>  };
>
>  &kcs2 {
>         status = "okay";
> -       kcs_addr = <0x62>;
> +       aspeed,lpc-io-reg = <0x62>;
>  };
>
>  &kcs4 {
>         status = "okay";
> -       kcs_addr = <0x97DE>;
> +       aspeed,lpc-io-reg = <0x97DE>;
>  };
>
>  &lpc_snoop {
> --
> 2.17.1
>
