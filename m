From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 31 Jul 2024 16:57:11 -0500
Subject: [PATCH v1 1/1] ARM: dts: aspeed: system1: IBM System1 BMC update
In-Reply-To: <20240731214737.986010-2-ninad@linux.ibm.com>
References: <20240731214737.986010-1-ninad@linux.ibm.com>
 <20240731214737.986010-2-ninad@linux.ibm.com>
Message-ID: <5d86ab31-7b29-4f5e-9c9f-be904c128497@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 7/31/24 16:47, Ninad Palsule wrote:
> Updated MAX31785a pmbus based fans in the device tree.
>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 96 +++++++++++++++++++
>   1 file changed, 96 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index f3efecc7eb8d0..f96b299d743ba 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -764,17 +764,113 @@ regulator at 43 {
>   	};
>   };
>   
> +


Don't really need the white space here, but no worries.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>   &i2c6 {
>   	status = "okay";
>   
>   	fan-controller at 52 {
>   		compatible = "maxim,max31785a";
>   		reg = <0x52>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		fan0: fan at 0 {
> +			compatible = "pmbus-fan";
> +			reg = <0>;
> +			tach-pulses = <2>;
> +			maxim,fan-rotor-input = "tach";
> +			maxim,fan-pwm-freq = <25000>;
> +			maxim,fan-dual-tach;
> +			maxim,fan-no-watchdog;
> +			maxim,fan-no-fault-ramp;
> +			maxim,fan-ramp = <2>;
> +			maxim,fan-fault-pin-mon;
> +		};
> +
> +		fan1: fan at 1 {
> +			compatible = "pmbus-fan";
> +			reg = <1>;
> +			tach-pulses = <2>;
> +			maxim,fan-rotor-input = "tach";
> +			maxim,fan-pwm-freq = <25000>;
> +			maxim,fan-dual-tach;
> +			maxim,fan-no-watchdog;
> +			maxim,fan-no-fault-ramp;
> +			maxim,fan-ramp = <2>;
> +			maxim,fan-fault-pin-mon;
> +		};
> +
> +		fan2: fan at 2 {
> +			compatible = "pmbus-fan";
> +			reg = <2>;
> +			tach-pulses = <2>;
> +			maxim,fan-rotor-input = "tach";
> +			maxim,fan-pwm-freq = <25000>;
> +			maxim,fan-dual-tach;
> +			maxim,fan-no-watchdog;
> +			maxim,fan-no-fault-ramp;
> +			maxim,fan-ramp = <2>;
> +			maxim,fan-fault-pin-mon;
> +		};
> +
> +		fan3: fan at 3 {
> +			compatible = "pmbus-fan";
> +			reg = <3>;
> +			tach-pulses = <2>;
> +			maxim,fan-rotor-input = "tach";
> +			maxim,fan-pwm-freq = <25000>;
> +			maxim,fan-dual-tach;
> +			maxim,fan-no-watchdog;
> +			maxim,fan-no-fault-ramp;
> +			maxim,fan-ramp = <2>;
> +			maxim,fan-fault-pin-mon;
> +		};
> +
> +		fan4: fan at 4 {
> +			compatible = "pmbus-fan";
> +			reg = <4>;
> +			tach-pulses = <2>;
> +			maxim,fan-rotor-input = "tach";
> +			maxim,fan-pwm-freq = <25000>;
> +			maxim,fan-dual-tach;
> +			maxim,fan-no-watchdog;
> +			maxim,fan-no-fault-ramp;
> +			maxim,fan-ramp = <2>;
> +			maxim,fan-fault-pin-mon;
> +		};
>   	};
>   
>   	fan-controller at 54 {
>   		compatible = "maxim,max31785a";
>   		reg = <0x54>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		fan5: fan at 0 {
> +			compatible = "pmbus-fan";
> +			reg = <0>;
> +			tach-pulses = <2>;
> +			maxim,fan-rotor-input = "tach";
> +			maxim,fan-pwm-freq = <25000>;
> +			maxim,fan-dual-tach;
> +			maxim,fan-no-watchdog;
> +			maxim,fan-no-fault-ramp;
> +			maxim,fan-ramp = <2>;
> +			maxim,fan-fault-pin-mon;
> +		};
> +
> +		fan6: fan at 1 {
> +			compatible = "pmbus-fan";
> +			reg = <1>;
> +			tach-pulses = <2>;
> +			maxim,fan-rotor-input = "tach";
> +			maxim,fan-pwm-freq = <25000>;
> +			maxim,fan-dual-tach;
> +			maxim,fan-no-watchdog;
> +			maxim,fan-no-fault-ramp;
> +			maxim,fan-ramp = <2>;
> +			maxim,fan-fault-pin-mon;
> +		};
>   	};
>   
>   	eeprom at 55 {
