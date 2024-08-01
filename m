From: Ninad Palsule <ninad@linux.ibm.com>
Date: Thu, 1 Aug 2024 11:24:47 -0500
Subject: [PATCH v1 0/1] ARM: dts: aspeed: system1: IBM System1 BMC update
In-Reply-To: <172252600790.120672.12772438670145461296.robh@kernel.org>
References: <20240731214737.986010-1-ninad@linux.ibm.com>
 <172252600790.120672.12772438670145461296.robh@kernel.org>
Message-ID: <4d5b8958-2d33-42df-ac97-82bb63fdff38@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

On 8/1/24 10:29, Rob Herring (Arm) wrote:
> On Wed, 31 Jul 2024 16:47:28 -0500, Ninad Palsule wrote:
>> Hello,
>>
>> This patch only applies to openbmc/linux. The max31785 pmbus driver
>> changes are not available in the upstream yet. I will try to send those
>> changes upstream.
>>
>> Ninad Palsule (1):
>>    ARM: dts: aspeed: system1: IBM System1 BMC update
>>
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 96 +++++++++++++++++++
>>   1 file changed, 96 insertions(+)
>>
>> --
>> 2.43.0
>>
>>
>>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>    pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20240731214737.986010-1-ninad at linux.ibm.com:
>
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 52/fan at 0: failed to match any schema with compatible: ['pmbus-fan']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 52/fan at 1: failed to match any schema with compatible: ['pmbus-fan']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 52/fan at 2: failed to match any schema with compatible: ['pmbus-fan']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 52/fan at 3: failed to match any schema with compatible: ['pmbus-fan']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 52/fan at 4: failed to match any schema with compatible: ['pmbus-fan']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 54/fan at 0: failed to match any schema with compatible: ['pmbus-fan']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: /ahb/apb/bus at 1e78a000/i2c at 380/fan-controller at 54/fan at 1: failed to match any schema with compatible: ['pmbus-fan']
>
I have seen these warning. I am not sure how to fix them as it is 
already documented in the following file.

Documentation/devicetree/bindings/hwmon/pmbus/max31785.txt

May be because its not converted to YAML yet?

Thanks & Rehads,

Ninad Palsule

