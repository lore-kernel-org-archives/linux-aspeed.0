From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 10 Apr 2023 17:21:08 +0200
Subject: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
In-Reply-To: <PS2PR04MB3592E90B033CA23F47CD02F2B7959@PS2PR04MB3592.apcprd04.prod.outlook.com>
References: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
 <20230329083235.24123-2-Delphine_CC_Chiu@Wiwynn.com>
 <b66f708c-5369-c1c9-5506-c609a245bf4c@linaro.org>
 <PS2PR04MB3592E90B033CA23F47CD02F2B7959@PS2PR04MB3592.apcprd04.prod.outlook.com>
Message-ID: <44a7ee80-e770-4918-9caa-f606713fe584@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/04/2023 09:11, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> Thank you for reviewing.
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Wednesday, March 29, 2023 4:37 PM
>> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
>> patrick at stwcx.xyz; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
>> Jeffery <andrew@aj.id.au>
>> Cc: devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
>> Subject: Re: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
>>
>>   Security Reminder: Please be aware that this email is sent by an external
>> sender.
>>
>> On 29/03/2023 10:32, Delphine CC Chiu wrote:
>>> From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
>>>
>>> Add GPIO names for SOC lines.
>>>
>>> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
>>> ---
>>>  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 49
>> +++++++++++++++++++
>>>  1 file changed, 49 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> index 8c05bd56ce1e..59819115c39d 100644
>>> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
>>> @@ -238,4 +238,53 @@
>>>  &gpio0 {
>>>       pinctrl-names = "default";
>>>       pinctrl-0 = <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
>>> +     status = "okay";
>>
>> Was it disabled before?
>>
> Yes, 

Really? Can you provide any proof for this?

> we have to enable gpio status for meeting aspeed-g6 device tree setting, and set net names for pulling gpio pin from application layer.

What is "enable gpio status"? What does it mean to "meet aspeeg-g6
devicetree setting"?
What names have anything to do with my question?

Sorry, I cannot parse it at all.

>>> +     gpio-line-names =
>>> +     /*A0-A7*/ "","","","","","","","",
>>> +     /*B0-B7*/ "power-bmc-nic","presence-ocp-debug",
>>> +               "power-bmc-slot1","power-bmc-slot2",
>>> +               "power-bmc-slot3","power-bmc-slot4","","",
>>> +     /*C0-C7*/ "presence-ocp-nic","","","reset-cause-nic-primary",
>>> +               "reset-cause-nic-secondary","","","",
>>> +     /*D0-D7*/ "","","","","","","","",
>>> +     /*E0-E7*/ "","","","","","","","",
>>> +     /*F0-F7*/ "slot1-bmc-reset-button","slot2-bmc-reset-button",
>>> +               "slot3-bmc-reset-button","slot4-bmc-reset-button",
>>> +               "","","","presence-emmc",
>>> +     /*G0-G7*/ "","","","","","","","",
>>> +     /*H0-H7*/ "","","","",
>>> +               "presence-mb-slot1","presence-mb-slot2",
>>> +               "presence-mb-slot3","presence-mb-slot4",
>>> +     /*I0-I7*/ "","","","","","","bb-bmc-button","",
>>> +     /*J0-J7*/ "","","","","","","","",
>>> +     /*K0-K7*/ "","","","","","","","",
>>> +     /*L0-L7*/ "","","","","","","","",
>>> +     /*M0-M7*/
>> "","power-nic-bmc-enable","","usb-bmc-enable","","reset-cause-usb-hub","","",
>>> +     /*N0-N7*/ "","","","","bmc-ready","","","",
>>> +     /*O0-O7*/
>> "","","","","","","fan0-bmc-cpld-enable","fan1-bmc-cpld-enable",
>>> +     /*P0-P7*/ "fan2-bmc-cpld-enable","fan3-bmc-cpld-enable",
>>> +               "reset-cause-pcie-slot1","reset-cause-pcie-slot2",
>>> +               "reset-cause-pcie-slot3","reset-cause-pcie-slot4","","",
>>> +     /*Q0-Q7*/ "","","","","","","","",
>>> +     /*R0-R7*/ "","","","","","","","",
>>> +     /*S0-S7*/ "","","power-p5v-usb","presence-bmc-tpm","","","","",
>>> +     /*T0-T7*/ "","","","","","","","",
>>> +     /*U0-U7*/ "","","","","","","","GND",
>>> +     /*V0-V7*/ "bmc-slot1-ac-button","bmc-slot2-ac-button",
>>> +               "bmc-slot3-ac-button","bmc-slot4-ac-button",
>>> +               "","","","",
>>> +     /*W0-W7*/ "","","","","","","","",
>>> +     /*X0-X7*/ "","","","","","","","",
>>> +     /*Y0-Y7*/ "","","","reset-cause-emmc","","","","",
>>> +     /*Z0-Z7*/ "","","","","","","",""; };
>>> +
>>> +&gpio1 {
>>> +     status = "okay";
>>
>> Same question...
> Yes, the answer is same as above.

So the same incorrect?


Best regards,
Krzysztof

