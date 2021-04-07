From: Brandon Wyman <bjwyman@gmail.com>
Date: Wed, 7 Apr 2021 17:19:05 -0500
Subject: [PATCH 18/22] ARM: dts: aspeed: everest: GPIOs support
In-Reply-To: <20210329150020.13632-19-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
 <20210329150020.13632-19-eajames@linux.ibm.com>
Message-ID: <b74fd3a3-53d9-5dfd-f668-476a27f45ed0@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 2021-03-29 10:00, Eddie James wrote:
> From: Alpana Kumari <alpankum@in.ibm.com>
>
> This commit adds support for-
> - Presence GPIOs
> - I2C control GPIOs
> - Op-panel GPIOs (ex PHR)
>
> Signed-off-by: Alpana Kumari <alpankum@in.ibm.com>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Brandon Wyman <bjwyman@gmail.com>
> ---
>   arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 297 +++++++++++++++++++
>   1 file changed, 297 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> index 9e77bbb3e4d1..18a3d65fb67d 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
> @@ -204,6 +204,37 @@ fan3-presence {
>   	};
>   };
>   
> +&gpio0 {
> +	gpio-line-names =
> +	/*A0-A7*/	"","","","","","","","",
> +	/*B0-B7*/	"USERSPACE_RSTIND_BUFF","","","","","","","",
> +	/*C0-C7*/	"","","","","","","","",
> +	/*D0-D7*/	"","","","","","","","",
> +	/*E0-E7*/	"","","","","","","","",
> +	/*F0-F7*/	"PIN_HOLE_RESET_IN_N","","",
> +				"PIN_HOLE_RESET_OUT_N","","","","",
> +	/*G0-G7*/	"","","","","","","","",
> +	/*H0-H7*/	"","","","","","","","",
> +	/*I0-I7*/	"","","","","","","","",
> +	/*J0-J7*/	"","","","","","","","",
> +	/*K0-K7*/	"","","","","","","","",
> +	/*L0-L7*/	"","","","","","","","",
> +	/*M0-M7*/	"","","","","","","","",
> +	/*N0-N7*/	"","","","","","","","",
> +	/*O0-O7*/	"","","","","","","","",
> +	/*P0-P7*/	"","","","","","","","",
> +	/*Q0-Q7*/	"","","","","","","","",
> +	/*R0-R7*/	"","","","","","I2C_FLASH_MICRO_N","","",
> +	/*S0-S7*/	"","","","","","","","",
> +	/*T0-T7*/	"","","","","","","","",
> +	/*U0-U7*/	"","","","","","","","",
> +	/*V0-V7*/	"","BMC_3RESTART_ATTEMPT_P","","","","","","",
> +	/*W0-W7*/	"","","","","","","","",
> +	/*X0-X7*/	"","","","","","","","",
> +	/*Y0-Y7*/	"","","","","","","","",
> +	/*Z0-Z7*/   "","","","","","","","";
> +};
> +
>   &i2c0 {
>   	status = "okay";
>   
> @@ -211,10 +242,276 @@ eeprom at 51 {
>   		compatible = "atmel,24c64";
>   		reg = <0x51>;
>   	};
> +
> +	pca1: pca9552 at 62 {
> +		compatible = "nxp,pca9552";
> +		reg = <0x62>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names =
> +			"presence-ps0",
> +			"presence-ps1",
> +			"presence-ps2",
> +			"presence-ps3",
> +			"presence-pdb",
> +			"presence-tpm",
> +			"", "",
> +			"presence-cp0",
> +			"presence-cp1",
> +			"presence-cp2",
> +			"presence-cp3",
> +			"presence-dasd",
> +			"presence-lcd-op",
> +			"presence-base-op",
> +			"";
> +
> +		gpio at 0 {
> +			reg = <0>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 01 {
> +			reg = <1>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 2 {
> +			reg = <2>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 3 {
> +			reg = <3>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 4 {
> +			reg = <4>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 5 {
> +			reg = <5>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 6 {
> +			reg = <6>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 7 {
> +			reg = <7>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 8 {
> +			reg = <8>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 9 {
> +			reg = <9>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 10 {
> +			reg = <10>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 11 {
> +			reg = <11>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 12 {
> +			reg = <12>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 13 {
> +			reg = <13>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 14 {
> +			reg = <14>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 15 {
> +			reg = <15>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +	};
>   };
>   
>   &i2c1 {
>   	status = "okay";
> +
> +	pca2: pca9552 at 61 {
> +		compatible = "nxp,pca9552";
> +		reg = <0x61>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names =
> +			"presence-cable-card1",
> +			"presence-cable-card2",
> +			"presence-cable-card3",
> +			"presence-cable-card4",
> +			"presence-cable-card5",
> +			"expander-cable-card1",
> +			"expander-cable-card2",
> +			"expander-cable-card3",
> +			"expander-cable-card4",
> +			"expander-cable-card5";
> +
> +		gpio at 0 {
> +			reg = <0>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 1 {
> +			reg = <1>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 2 {
> +			reg = <2>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 3 {
> +			reg = <3>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 4 {
> +			reg = <4>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 5 {
> +			reg = <5>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 6 {
> +			reg = <6>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 7 {
> +			reg = <7>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 8 {
> +			reg = <8>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 9 {
> +			reg = <9>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +	};
> +
> +	pca3: pca9552 at 62 {
> +		compatible = "nxp,pca9552";
> +		reg = <0x62>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		gpio-line-names =
> +			"presence-cable-card6",
> +			"presence-cable-card7",
> +			"presence-cable-card8",
> +			"presence-cable-card9",
> +			"presence-cable-card10",
> +			"presence-cable-card11",
> +			"expander-cable-card6",
> +			"expander-cable-card7",
> +			"expander-cable-card8",
> +			"expander-cable-card9",
> +			"expander-cable-card10",
> +			"expander-cable-card11";
> +
> +		gpio at 0 {
> +			reg = <0>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 1 {
> +			reg = <1>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 2 {
> +			reg = <2>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 3 {
> +			reg = <3>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 4 {
> +			reg = <4>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 5 {
> +			reg = <5>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 6 {
> +			reg = <6>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 7 {
> +			reg = <7>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 8 {
> +			reg = <8>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 9 {
> +			reg = <9>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 10 {
> +			reg = <10>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +		gpio at 11 {
> +			reg = <11>;
> +			type = <PCA955X_TYPE_GPIO>;
> +		};
> +
> +	};
> +
>   };
>   
>   &i2c2 {
