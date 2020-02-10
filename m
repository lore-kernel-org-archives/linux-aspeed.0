From: Joel Stanley <joel@jms.id.au>
Date: Mon, 10 Feb 2020 02:28:13 +0000
Subject: [PATCH 1/2] ARM: dts: aspeed: ast2500: Fix SCU IRQ controller
 node address
In-Reply-To: <20200204224908.19967-2-eajames@linux.ibm.com>
References: <20200204224908.19967-1-eajames@linux.ibm.com>
 <20200204224908.19967-2-eajames@linux.ibm.com>
Message-ID: <CACPK8XcYSoAM0VZFZSnVTRXHsEcib+-s8e3p7HD67VV35hEA=Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2020 at 22:49, Eddie James <eajames@linux.ibm.com> wrote:
>
> The node was defined with a unit address but had no reg property,
> resulting in a warning. The address is unecessary, so drop it.

Please add a reg property instead of removing the unit address.

The hardware still lives at that address, even if your driver doesn't
currently use that information.

Cheers,

Joel

>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 569f9d74c696..aeee18fc1e7e 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -222,7 +222,7 @@ syscon: syscon at 1e6e2000 {
>                                 #clock-cells = <1>;
>                                 #reset-cells = <1>;
>
> -                               scu_ic: interrupt-controller at 18 {
> +                               scu_ic: interrupt-controller {
>                                         #interrupt-cells = <1>;
>                                         compatible = "aspeed,ast2500-scu-ic";
>                                         interrupts = <21>;
> --
> 2.24.0
>
