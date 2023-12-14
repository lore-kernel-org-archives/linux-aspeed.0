From: Ninad Palsule <ninad@linux.ibm.com>
Date: Thu, 14 Dec 2023 09:04:41 -0600
Subject: [PATCH v1 8/8] ARM: dts: aspeed: System1: PS, sensor and more
In-Reply-To: <5b98538a-8ffe-42ec-b020-514dcfcebba3@linaro.org>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-9-ninad@linux.ibm.com>
 <5b98538a-8ffe-42ec-b020-514dcfcebba3@linaro.org>
Message-ID: <7b14aa01-24c2-425c-8bf3-48e5b7890b95@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

On 12/12/23 14:26, Krzysztof Kozlowski wrote:
> On 12/12/2023 17:40, Ninad Palsule wrote:
>> This drop adds following devices in the device tree.
>> - EEPROM/VPD
>> - Power supplies
>> - Humidity, pressure and temperature sensors.
>> - Trusted platform module(TPM) chip
>>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
> Don't mix DTS with drivers. DTS and drivers go via different subsystems
> and cannot have dependencies, so why DTS is patch #6, then driver #7 and
> now again DTS #7?
I have sent a driver patch as a separate patchset and removed it from 
this patchset.
>
>
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 76 +++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> index 75562aa63701..d960b938fe8d 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -461,6 +461,11 @@ &kcs3 {
>>   &i2c0 {
>>   	status = "okay";
>>   
>> +	eeprom at 50 {
>> +		compatible = "atmel,24c64";
>> +		reg = <0x50>;
>> +	};
>> +
>>   	regulator at 60 {
>>   		compatible = "maxim,max8952";
>>   		reg = <0x60>;
>> @@ -655,6 +660,25 @@ pca0: pca9539 at 74 {
>>   
>>   &i2c2 {
>>   	status = "okay";
>> +
>> +	power-supply at 58 {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x58>;
>> +	};
>> +
>> +	power-supply at 59 {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x59>;
>> +	};
>> +
>> +	power-supply at 5a {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x5a>;
>> +	};
> Missing blank line

Fixed it.

Thanks for the review.

Regards,

Ninad

>
>> +	power-supply at 5b {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x5b>;
>> +	};
>
> Best regards,
> Krzysztof
>
