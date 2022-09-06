From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 6 Sep 2022 02:22:50 +0200
Subject: [PATCH net-next 2/2] ARM: dts: aspeed: elbert: Enable mac3
 controller
In-Reply-To: <20220905235634.20957-3-rentao.bupt@gmail.com>
References: <20220905235634.20957-1-rentao.bupt@gmail.com>
 <20220905235634.20957-3-rentao.bupt@gmail.com>
Message-ID: <YxaS2mS5vwW4HuqL@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 05, 2022 at 04:56:34PM -0700, rentao.bupt at gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Enable mac3 controller in Elbert dts: Elbert MAC3 is connected to the
> onboard switch directly (fixed link).

What is the switch? Could you also add a DT node for it?

> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
> index 27b43fe099f1..52cb617783ac 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
> @@ -183,3 +183,14 @@ imux31: i2c at 7 {
>  &i2c11 {
>  	status = "okay";
>  };
> +
> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rgmii";

'rgmii' is suspicious, though not necessarily wrong. This value is
normally passed to the PHY, so the PHY inserts the RGMII delay. You
however don't have a PHY. So i assume the switch is inserting the
delay? Again, being able to see the DT properties for the switch would
be useful.

   Andrew
