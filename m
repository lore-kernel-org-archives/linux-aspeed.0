From: Patrick Williams <patrick@stwcx.xyz>
Date: Mon, 29 Jul 2024 17:09:28 -0500
Subject: [PATCH v11 22/27] ARM: dts: aspeed: yosemite4: Revise i2c
 duty-cycle
In-Reply-To: <20240723092310.3565410-23-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
 <20240723092310.3565410-23-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <ZqgTGJ40wuaCJVe3@heinlein.vulture-banana.ts.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 23, 2024 at 05:23:03PM +0800, Delphine CC Chiu wrote:
> Revise duty cycle SMB11 and SMB16 to high: 40%, low: 60%,
> to meet 400kHz-i2c clock low time spec (> 1.3 us) from EE request
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index c2994651e747..c940d23c8a4b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -761,6 +761,7 @@ eeprom at 54 {
>  &i2c10 {
>  	status = "okay";
>  	bus-frequency = <400000>;
> +	i2c-clk-high-min-percent = <40>;

I don't see upstream code referencing this property.

It looks like this problem has been reported by Rob's bot multiple times
before when you've submitted this:

https://lore.kernel.org/lkml/171198916336.1093653.5612835610479588096.robh at kernel.org/

Is there a reason we aren't fixing this?

Maybe we are depending on this commit?  I think we need to reference it
somehow here.

https://lore.kernel.org/lkml/47e7eb15-e38d-ead3-de84-b7454e2c6eb8 at gmail.com/


>  	i2c-mux at 74 {
>  		compatible = "nxp,pca9544";
>  		i2c-mux-idle-disconnect;
> @@ -1314,6 +1315,7 @@ &i2c15 {
>  	mctp-controller;
>  	multi-master;
>  	bus-frequency = <400000>;
> +	i2c-clk-high-min-percent = <40>;
>  
>  	mctp at 10 {
>  		compatible = "mctp-i2c-controller";
> -- 
> 2.25.1
> 

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240729/abe3c04b/attachment.sig>
