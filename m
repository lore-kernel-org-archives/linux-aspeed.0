From: Ninad Palsule <ninad@linux.ibm.com>
Date: Mon, 8 Jan 2024 13:56:05 -0600
Subject: [PATCH v1 6/8] ARM: dts: aspeed: System1: GPIO, Fan ctrl, Led
In-Reply-To: <1b19af6f-645a-4913-b9db-49b1f3ad54f9@linaro.org>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-7-ninad@linux.ibm.com>
 <1b19af6f-645a-4913-b9db-49b1f3ad54f9@linaro.org>
Message-ID: <7ff0e3ca-98bb-47d9-8cf8-20a4e6aadd1e@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

On 12/12/23 14:25, Krzysztof Kozlowski wrote:
> On 12/12/2023 17:40, Ninad Palsule wrote:
>> This commit adds following devices to the device tree.
>> - GPIO pin assignements, GPIO expansion devices
>> - LED brinker devices
>> - Fan controllers
>>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 547 +++++++++++++++++-
> Squash it.

Yes, I made a single commit for device tree.

>
>>   1 file changed, 542 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> index b8e7e52d4600..75562aa63701 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -114,6 +114,99 @@ vga_memory: region at bf000000 {
>>   		};
>>   	};
>>   
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		bmc-ready {
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
Fixed names.
>
>> +			gpios = <&gpio0 ASPEED_GPIO(L, 7) GPIO_ACTIVE_HIGH>;
>> +		};
>> +
>> +		bmc-hb {
> None of these were tested.
Fixed names
>
>>   	/*A0-A7*/	"","","","","","","","",
>> -	/*B0-B7*/	"","","","","","","","",
>> +	/*B0-B7*/	"","","","","bmc-tpm-reset","","","",
> Really? You just added these lines. There is no point in adding a new
> line and immediately changing it.
>
> This points how your split is artificial and not helpful.
> ...
Now I have a single commit for device tree.
>
>
>>   &i2c2 {
>> @@ -486,6 +744,20 @@ regulator at 43 {
>>   &i2c6 {
>>   	status = "okay";
>>   
>> +	fan-controller at 52 {
>> +		compatible = "maxim,max31785a";
>> +		reg = <0x52>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
> Why do you need cells?
Removed cells.
>
>> +	};
>> +
>> +	fan-controller at 54 {
>> +		compatible = "maxim,max31785a";
>> +		reg = <0x54>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
> Why do you need cells?
Removed cells.
>
>> +	};
>> +
>>   	i2c-mux at 70 {
>>   		compatible = "nxp,pca9548";
>>   		reg = <0x70>;
>> @@ -522,6 +794,48 @@ i2c6mux0chn4: i2c at 4 {
>>   			#address-cells = <1>;
>>   			#size-cells = <0>;
>>   			reg = <4>;
>> +
>> +			led-controller at 60 {
>> +				compatible = "nxp,pca9551";
>> +				reg = <0x60>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +
>> +				led at 0 {
>> +					label = "enclosure-id-led";
>> +					reg = <0>;
>> +					retain-state-shutdown;
>> +					default-state = "keep";
>> +					type = <PCA955X_TYPE_LED>;
>> +				};
>> +
>> +				led at 1 {
>> +					label = "attention-led";
>> +					reg = <1>;
>> +					retain-state-shutdown;
>> +					default-state = "keep";
>> +					type = <PCA955X_TYPE_LED>;
>> +				};
>> +
>> +				led at 2 {
>> +					label = "enclosure-fault-rollup-led";
>> +					reg = <2>;
>> +					retain-state-shutdown;
>> +					default-state = "keep";
>> +					type = <PCA955X_TYPE_LED>;
>> +				};
>> +
>> +				led at 3 {
>> +					label = "power-on-led";
>> +					reg = <3>;
>> +					retain-state-shutdown;
>> +					default-state = "keep";
>> +					type = <PCA955X_TYPE_LED>;
>> +				};
>> +			};
>>   		};
>>   
>>   		i2c6mux0chn5: i2c at 5 {
>> @@ -542,6 +856,44 @@ i2c6mux0chn7: i2c at 7 {
>>   			reg = <7>;
>>   		};
>>   	};
>> +
>> +	pca3: pca9539 at 74 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
Fixed node names.
>
>
>> +		compatible = "nxp,pca9539";
>> +		reg = <0x74>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +	};
>> +
>> +	pca4: pca9539 at 77 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
Fixed node names.
>
>
>> +		compatible = "nxp,pca9539";
>> +		reg = <0x77>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +
>> +		gpio-line-names =
>> +			"PE_NVMED0_EXP_PRSNT_N",
>> +			"PE_NVMED1_EXP_PRSNT_N",
>> +			"PE_NVMED2_EXP_PRSNT_N",
>> +			"PE_NVMED3_EXP_PRSNT_N",
>> +			"LED_FAULT_NVMED0",
>> +			"LED_FAULT_NVMED1",
>> +			"LED_FAULT_NVMED2",
>> +			"LED_FAULT_NVMED3",
>> +			"FAN0_PRESENCE_R_N",
>> +			"FAN1_PRESENCE_R_N",
>> +			"FAN2_PRESENCE_R_N",
>> +			"FAN3_PRESENCE_R_N",
>> +			"FAN4_PRESENCE_R_N",
>> +			"FAN5_PRESENCE_N",
>> +			"FAN6_PRESENCE_N",
>> +			"";
>> +	};
>>   };
>>   
>>   &i2c7 {
>> @@ -809,6 +1161,191 @@ regulator at 41 {
>>   		compatible = "infineon,ir38263";
>>   		reg = <0x41>;
>>   	};
>> +
>> +	led-controller at 61 {
>> +		compatible = "nxp,pca9552";
>> +		reg = <0x61>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
> ...
>
>> +		led at 15 {
>> +			label = "pe-cp-drv3-perst";
>> +			reg = <15>;
>> +			retain-state-shutdown;
>> +			default-state = "keep";
>> +			type = <PCA955X_TYPE_LED>;
>> +		};
>> +	};
>> +
>> +	pca1: pca9539 at 75 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
Fixed names.

Thanks for the review.

Regards,

Ninad

