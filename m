From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 26 Sep 2022 15:02:08 +0700
Subject: [PATCH] ARM: dts: aspeed: mtjade: Remove gpio-keys entries
In-Reply-To: <20220915080828.2894070-1-quan@os.amperecomputing.com>
References: <20220915080828.2894070-1-quan@os.amperecomputing.com>
Message-ID: <9a5699a1-0649-808a-ff5b-e37c1e299418@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear reviewers,
Just a gentle ping for the patch.

Thank you,
- Quan

On 15/09/2022 15:08, Quan Nguyen wrote:
> Remove the gpio-keys entries from the Ampere's Mt. Jade BMC device
> tree. The user space applications are going to change from using
> libevdev to libgpiod.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
>   .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 95 -------------------
>   1 file changed, 95 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> index 82a6f14a45f0..d127cbcc7998 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> @@ -97,101 +97,6 @@ identify {
>   		};
>   	};
>   
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -
> -		event-shutdown-ack {
> -			label = "SHUTDOWN_ACK";
> -			gpios = <&gpio ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(G, 2)>;
> -		};
> -
> -		event-reboot-ack {
> -			label = "REBOOT_ACK";
> -			gpios = <&gpio ASPEED_GPIO(J, 3) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(J, 3)>;
> -		};
> -
> -		event-s0-overtemp {
> -			label = "S0_OVERTEMP";
> -			gpios = <&gpio ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(G, 3)>;
> -		};
> -
> -		event-s0-hightemp {
> -			label = "S0_HIGHTEMP";
> -			gpios = <&gpio ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(J, 0)>;
> -		};
> -
> -		event-s0-cpu-fault {
> -			label = "S0_CPU_FAULT";
> -			gpios = <&gpio ASPEED_GPIO(J, 1) GPIO_ACTIVE_HIGH>;
> -			linux,code = <ASPEED_GPIO(J, 1)>;
> -		};
> -
> -		event-s0-scp-auth-fail {
> -			label = "S0_SCP_AUTH_FAIL";
> -			gpios = <&gpio ASPEED_GPIO(J, 2) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(J, 2)>;
> -		};
> -
> -		event-s1-scp-auth-fail {
> -			label = "S1_SCP_AUTH_FAIL";
> -			gpios = <&gpio ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(Z, 5)>;
> -		};
> -
> -		event-s1-overtemp {
> -			label = "S1_OVERTEMP";
> -			gpios = <&gpio ASPEED_GPIO(Z, 6) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(Z, 6)>;
> -		};
> -
> -		event-s1-hightemp {
> -			label = "S1_HIGHTEMP";
> -			gpios = <&gpio ASPEED_GPIO(AB, 0) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(AB, 0)>;
> -		};
> -
> -		event-s1-cpu-fault {
> -			label = "S1_CPU_FAULT";
> -			gpios = <&gpio ASPEED_GPIO(Z, 1) GPIO_ACTIVE_HIGH>;
> -			linux,code = <ASPEED_GPIO(Z, 1)>;
> -		};
> -
> -		event-id {
> -			label = "ID_BUTTON";
> -			gpios = <&gpio ASPEED_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(Q, 5)>;
> -		};
> -
> -		event-psu1-vin-good {
> -			label = "PSU1_VIN_GOOD";
> -			gpios = <&gpio ASPEED_GPIO(H, 4) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(H, 4)>;
> -		};
> -
> -		event-psu2-vin-good {
> -			label = "PSU2_VIN_GOOD";
> -			gpios = <&gpio ASPEED_GPIO(H, 5) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(H, 5)>;
> -		};
> -
> -		event-psu1-present {
> -			label = "PSU1_PRESENT";
> -			gpios = <&gpio ASPEED_GPIO(I, 0) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(I, 0)>;
> -		};
> -
> -		event-psu2-present {
> -			label = "PSU2_PRESENT";
> -			gpios = <&gpio ASPEED_GPIO(I, 1) GPIO_ACTIVE_LOW>;
> -			linux,code = <ASPEED_GPIO(I, 1)>;
> -		};
> -
> -	};
> -
>   	gpioA0mux: mux-controller {
>   		compatible = "gpio-mux";
>   		#mux-control-cells = <0>;
