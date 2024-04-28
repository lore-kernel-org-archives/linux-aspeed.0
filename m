From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 28 Apr 2024 18:39:24 +0200
Subject: [PATCH v3 12/14] ARM: dts: aspeed: Add IBM P11 FSI devices
In-Reply-To: <a608377b-3e51-4b59-bdab-8c4e9938f086@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-13-eajames@linux.ibm.com>
 <dc106aa2-8f69-4f71-ad9f-6dfb97c63a50@kernel.org>
 <a608377b-3e51-4b59-bdab-8c4e9938f086@linux.ibm.com>
Message-ID: <1d82580c-43fb-4510-8eb3-585007fba430@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/04/2024 15:18, Eddie James wrote:
> 
> On 4/26/24 01:31, Krzysztof Kozlowski wrote:
>> On 25/04/2024 23:36, Eddie James wrote:
>>> Add the P11 FSI device tree for use in upcoming BMC systems.
>>> Unlike P10, there is no system with only two processors, so
>>> only the quad processor FSI layout is necessary.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> ---
>>>   .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1696 +++++++++++++++++
>>>   1 file changed, 1696 insertions(+)
>>>   create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
>>> new file mode 100644
>>> index 000000000000..c3a0ecf12aa0
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
>>> @@ -0,0 +1,1696 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +// Copyright 2024 IBM Corp.
>>> +
>>> +&fsim0 {
>> This does not make sense. You do not include any file here, so what do
>> you want to override?
>>
>> How can you even test this file?
> 
> 
> This is an include file, to be included in the new device tree files in 
> the next two patches. It will be tested as part of those. Andrew 
> requested I split this up, and I have to add this one first, even though 
> nothing is referencing it yet. The same model is used for the P10 FSI 
> devices.
> 
> 
>>
>>> +	status = "okay";
>>> +
>>> +	#address-cells = <2>;
>>> +	#size-cells = <0>;
>>> +
>>> +	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
>>> +
>>
>>> +
>>> +&cfam3_i2c16 {
>>> +	fsi-i2cr at 20 {
>>> +		compatible = "ibm,i2cr-fsi-master";
>>> +		reg = <0x20>;
>>> +		#address-cells = <2>;
>>> +		#size-cells = <0>;
>>> +
>>> +		cfam at 0,0 {
>>> +			reg = <0 0>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			chip-id = <0>;
>>> +
>>> +			scom416: scom at 1000 {
>>> +				compatible = "ibm,i2cr-scom";
>>> +				reg = <0x1000 0x400>;
>>> +			};
>>> +
>>> +			sbefifo416: sbefifo at 2400 {
>>> +				compatible = "ibm,odyssey-sbefifo";
>>> +				reg = <0x2400 0x400>;
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&cfam3_i2c17 {
>> This looks randomly ordered.
> 
> 
> Not sure what you mean. Everything is sequentially ordered?

So what is the order for all Aspeed DTS? Is it sequential like in DTSI?
What does it even mean sequential?  There are two preferred orderings,
as expressed in DTS coding style.

Best regards,
Krzysztof

