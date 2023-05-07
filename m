From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 7 May 2023 10:23:34 +0200
Subject: [PATCH 2/4] ARM: dts: aspeed: mtmitchell: Add I2C Fan
In-Reply-To: <5d1cc7d5-2d73-c1a2-f95d-5810757640d2@amperemail.onmicrosoft.com>
References: <20230425065715.21871-1-chanh@os.amperecomputing.com>
 <20230425065715.21871-3-chanh@os.amperecomputing.com>
 <7ee3eec8-b5b4-2591-adcd-1831bf7de02b@linaro.org>
 <5d1cc7d5-2d73-c1a2-f95d-5810757640d2@amperemail.onmicrosoft.com>
Message-ID: <969bfca0-9fff-0b22-6db1-113a7e998bc8@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 07/05/2023 10:20, Chanh Nguyen wrote:
> 
> On 25/04/2023 20:15, Krzysztof Kozlowski wrote:
>> On 25/04/2023 08:57, Chanh Nguyen wrote:
>>> Add the MAX31790 node as a Fan I2C controller. It controls the
>>> TACH and PWM for Fan Mt.Mitchell system.
>>>
>>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>>> ---
>>>   arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> index e79f56208b89..6455cf80da0e 100644
>>> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
>>> @@ -477,6 +477,18 @@
>>>   			line-name = "bmc-ocp0-en-n";
>>>   		};
>>>   	};
>>> +
>>> +	max31790 at 20 {
>>
>> Node names should be generic.
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Thank Krzysztof,
> 
> I think these node names should be "fan-i2c-0" and "fan-i2c-1". Do you 
> have any other idea ?

i2c-0 is not generic. This should be either fan or fan-controller,
depending what this is.
> 
>>
>>> +		compatible = "maxim,max31790";
>>
>> Unfortunately the compatible is undocumented.
>>
>> Please run scripts/checkpatch.pl and fix reported warnings.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Yes Krzysztof,
> 
> This compatible has not yes documented.
> 
> Should I push a document for max31790 to 
> ./Documentation/devicetree/bindings/ or ask to maintainer (Guenter Roeck 
> <linux@roeck-us.net> or Jean Delvare <jdelvare@suse.com>) ?

Check on lore.kernel.org if there is ongoing work. If there is no, then
please submit new the bindings (in DT schema). Maintainers are not for
writing your code, so it's you or some other developer who should do it.

Best regards,
Krzysztof

