From: Ninad Palsule <ninad@linux.ibm.com>
Date: Thu, 14 Dec 2023 10:30:55 -0600
Subject: [PATCH v1 5/8] ARM: dts: aspeed: System1: Voltage regulators
In-Reply-To: <6a3d4551-66a2-411a-9d5f-cffb57ee0ce2@linaro.org>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-6-ninad@linux.ibm.com>
 <6a3d4551-66a2-411a-9d5f-cffb57ee0ce2@linaro.org>
Message-ID: <e1ec02cf-072b-4678-8986-336c1cb8ca92@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

On 12/12/23 14:22, Krzysztof Kozlowski wrote:
> On 12/12/2023 17:40, Ninad Palsule wrote:
>> This commit adds different voltage regulators.
>>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 266 ++++++++++++++++++
> Squash it.
Done.
>
>>   1 file changed, 266 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> index 0557bff9f36a..b8e7e52d4600 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -114,10 +114,127 @@ vga_memory: region at bf000000 {
>>   		};
>>   	};
>>   
>> +	iio-hwmon {
>> +		compatible = "iio-hwmon";
>> +		io-channels = <&p12v_vd 0>, <&p5v_aux_vd 0>,
>> +			<&p5v_bmc_aux_vd 0>, <&p3v3_aux_vd 0>,
>> +			<&p3v3_bmc_aux_vd 0>, <&p1v8_bmc_aux_vd 0>,
>> +			<&adc1 4>, <&adc0 2>, <&adc1 0>,
>> +			<&p2V5_aux_vd 0>, <&adc1 7>;
>> +	};
>> +
>> +	p12v_vd: voltage_divider1 {
> Same comments as in other patches.
Fixed.
>
>> +		compatible = "voltage-divider";
>> +		io-channels = <&adc1 3>;
>> +		#io-channel-cells = <1>;
>> +
>> +		/* Scale the system voltage by 1127/127 to fit the ADC range.
> Use Linux coding style comments. /* and blank line

Fixed.

Thanks for the review.

Regards,

Ninad

>
>
> ....
>
> Best regards,
> Krzysztof
>
