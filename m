From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Date: Wed, 16 Oct 2024 17:26:42 +0700
Subject: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jefferson BMC
In-Reply-To: <7555c528c90e6151f54d0e17c278527f95fac184.camel@codeconstruct.com.au>
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
 <172891445289.1127319.4114892374425336022.robh@kernel.org>
 <b5919d904c9f06a618a54d49bc895c3081a511e4.camel@codeconstruct.com.au>
 <e8e31fb4-4a9f-4ea9-be4d-9ba29d824cc5@amperemail.onmicrosoft.com>
 <7555c528c90e6151f54d0e17c278527f95fac184.camel@codeconstruct.com.au>
Message-ID: <c42be4ea-9902-4fac-8b1e-afc38fe04bad@amperemail.onmicrosoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 16/10/2024 12:07, Andrew Jeffery wrote:
> On Tue, 2024-10-15 at 13:39 +0700, Chanh Nguyen wrote:
>>
>> On 15/10/2024 07:44, Andrew Jeffery wrote:
>>> Hi Chanh,
>>>
>>> On Mon, 2024-10-14 at 09:05 -0500, Rob Herring (Arm) wrote:
>>>> On Mon, 14 Oct 2024 10:50:31 +0000, Chanh Nguyen wrote:
>>>>> The Mt. Jefferson BMC is an ASPEED AST2600-based BMC for the Mt. Jefferson
>>>>> hardware reference platform with AmpereOne(TM)M processor.
>>>>>
>>>>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>>>>> ---
>>>>>    arch/arm/boot/dts/aspeed/Makefile             |   1 +
>>>>>    .../aspeed/aspeed-bmc-ampere-mtjefferson.dts  | 646 ++++++++++++++++++
>>>>>    2 files changed, 647 insertions(+)
>>>>>    create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
>>>>>
>>>>
>>>>
>>>> My bot found new DTB warnings on the .dts files added or changed in this
>>>> series.
>>>>
>>>> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
>>>> are fixed by another series. Ultimately, it is up to the platform
>>>> maintainer whether these warnings are acceptable or not. No need to reply
>>>> unless the platform maintainer has comments.
>>>>
>>>> If you already ran DT checks and didn't see these error(s), then
>>>> make sure dt-schema is up to date:
>>>>
>>>>     pip3 install dtschema --upgrade
>>>>
>>>>
>>>> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ampere-mtjefferson.dtb' for 20241014105031.1963079-1-chanh at os.amperecomputing.com:
>>>>
>>>> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
>>>> 	'ampere,mtjefferson-bmc' is not one of ['delta,ahe50dc-bmc', 'facebook,galaxy100-bmc', 'facebook,wedge100-bmc', 'facebook,wedge40-bmc', 'microsoft,olympus-bmc', 'quanta,q71l-bmc', 'tyan,palmetto-bmc', 'yadro,vesnin-bmc']
>>>> 	'ampere,mtjefferson-bmc' is not one of ['amd,daytonax-bmc', 'amd,ethanolx-bmc', 'ampere,mtjade-bmc', 'aspeed,ast2500-evb', 'asrock,e3c246d4i-bmc', 'asrock,e3c256d4i-bmc', 'asrock,romed8hm3-bmc', 'asrock,spc621d8hm3-bmc', 'asrock,x570d4u-bmc', 'bytedance,g220a-bmc', 'facebook,cmm-bmc', 'facebook,minipack-bmc', 'facebook,tiogapass-bmc', 'facebook,yamp-bmc', 'facebook,yosemitev2-bmc', 'facebook,wedge400-bmc', 'hxt,stardragon4800-rep2-bmc', 'ibm,mihawk-bmc', 'ibm,mowgli-bmc', 'ibm,romulus-bmc', 'ibm,swift-bmc', 'ibm,witherspoon-bmc', 'ingrasys,zaius-bmc', 'inspur,fp5280g2-bmc', 'inspur,nf5280m6-bmc', 'inspur,on5263m5-bmc', 'intel,s2600wf-bmc', 'inventec,lanyang-bmc', 'lenovo,hr630-bmc', 'lenovo,hr855xg2-bmc', 'portwell,neptune-bmc', 'qcom,centriq2400-rep-bmc', 'supermicro,x11spi-bmc', 'tyan,s7106-bmc', 'tyan,s8036-bmc', 'yadro,nicole-bmc', 'yadro,vegman-n110-bmc', 'yadro,vegman-rx20-bmc', 'yadro,vegman-sx20-bmc']
>>>> 	'ampere,mtjefferson-bmc' is not one of ['ampere,mtmitchell-bmc', 'aspeed,ast2600-evb', 'aspeed,ast2600-evb-a1', 'asus,x4tf-bmc', 'facebook,bletchley-bmc', 'facebook,catalina-bmc', 'facebook,cloudripper-bmc', 'facebook,elbert-bmc', 'facebook,fuji-bmc', 'facebook,greatlakes-bmc', 'facebook,harma-bmc', 'facebook,minerva-cmc', 'facebook,yosemite4-bmc', 'ibm,blueridge-bmc', 'ibm,everest-bmc', 'ibm,fuji-bmc', 'ibm,rainier-bmc', 'ibm,system1-bmc', 'ibm,tacoma-bmc', 'inventec,starscream-bmc', 'inventec,transformer-bmc', 'jabil,rbp-bmc', 'qcom,dc-scm-v1-bmc', 'quanta,s6q-bmc', 'ufispace,ncplite-bmc']
>>>> 	'aspeed,ast2400' was expected
>>>> 	'aspeed,ast2500' was expected
>>>> 	from schema $id: http://devicetree.org/schemas/arm/aspeed/aspeed.yaml#
>>>>
>>>
>>> This needs to be fixed as pointed out by Krzysztof.
>>>
>>
>> Thank Andrew, I'll update that in patch v2
>>
>>> *snip*
>>>
>>>> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb/bus at 1e78a000/i2c at 180/i2c-mux at 70/i2c at 0/psu at 58: failed to match any schema with compatible: ['pmbus']
>>>> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb/bus at 1e78a000/i2c at 180/i2c-mux at 70/i2c at 0/psu at 59: failed to match any schema with compatible: ['pmbus']
>>>
>>> These two should also be fixed. The compatible must describe the
>>> physical device, not the communication/application protocol. It may be
>>> necessary to add a binding if there's not one already for the device.
>>>
>>
>> Hi Andrew, My device is following the pmbus specification. So I'm using
>> the generic pmbus driver
>> (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/hwmon/pmbus/pmbus.c#n237)
>> to probe my device.
>>
> 
> The devicetree doesn't describe drivers though, it describes devices.
> The compatible string needs to represent the device.
> 
>>   In arch/arm/boot/dts/aspeed/ directory, many boards
>> are also using this compatible to probe our devices.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts#n219
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts#n263
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/aspeed/aspeed-bmc-tyan-s8036.dts#n260
>>
>> Andrew, Recently I saw the ASPEED platform's maintainer accept the
>> "pmbus" compatible with a warning log. You can see in the below list
>> that patches were merged recently.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=bb3776e564d2190db0ef45609e66f13c60ce5b48
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=28cfb03afcb20a841e96e821ba20870a7c437034
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=36d96827f480e90037d162098061333e279ea35f
>>
> 
> Unfortunately for your argument, I'm not trying to make the case that
> some people are allowed to do this and others (such as yourself) are
> not.
> 
> Rather, this is the review process in action, where hopefully everyone,
> including myself, tries to improve their practices with feedback.
> 

Thank Andrew for your feedback!

> You can also find discussions where other maintainers (Guenter, hwmon
> maintainer; Krzysztof, devicetree maintainer) have asked that "pmbus"
> not be used as a compatible:
> 
> https://lore.kernel.org/all/f76798ea-6edd-4888-8057-c09aaed88f25 at roeck-us.net/
> 

Hi Andrew,
I checked the discussion at 
https://lore.kernel.org/all/f76798ea-6edd-4888-8057-c09aaed88f25 at roeck-us.net/ 
. It seems the maintainers don't want to use the "pmbus" compatible for 
specific devices. The maintaners require an explicitly compatible from 
device list in drivers/hwmon/pmbus/pmbus.c . Please correct me if I'm 
wrong anything!

This is device list from drivers/hwmon/pmbus/pmbus.c

	{"adp4000", (kernel_ulong_t)&pmbus_info_one},
	{"bmr310", (kernel_ulong_t)&pmbus_info_one_status},
	{"bmr453", (kernel_ulong_t)&pmbus_info_one},
	{"bmr454", (kernel_ulong_t)&pmbus_info_one},
	{"bmr456", (kernel_ulong_t)&pmbus_info_one},
	{"bmr457", (kernel_ulong_t)&pmbus_info_one},
	{"bmr458", (kernel_ulong_t)&pmbus_info_one_status},
	{"bmr480", (kernel_ulong_t)&pmbus_info_one_status},
	{"bmr490", (kernel_ulong_t)&pmbus_info_one_status},
	{"bmr491", (kernel_ulong_t)&pmbus_info_one_status},
	{"bmr492", (kernel_ulong_t)&pmbus_info_one},
	{"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
	{"dps650ab", (kernel_ulong_t)&pmbus_info_one_skip},
	{"dps800", (kernel_ulong_t)&pmbus_info_one_skip},
	{"max20796", (kernel_ulong_t)&pmbus_info_one},
	{"mdt040", (kernel_ulong_t)&pmbus_info_one},
	{"ncp4200", (kernel_ulong_t)&pmbus_info_one},
	{"ncp4208", (kernel_ulong_t)&pmbus_info_one},
	{"pdt003", (kernel_ulong_t)&pmbus_info_one},
	{"pdt006", (kernel_ulong_t)&pmbus_info_one},
	{"pdt012", (kernel_ulong_t)&pmbus_info_one},
	{"pmbus", (kernel_ulong_t)&pmbus_info_zero},
	{"sgd009", (kernel_ulong_t)&pmbus_info_one_skip},
	{"tps40400", (kernel_ulong_t)&pmbus_info_one},
	{"tps544b20", (kernel_ulong_t)&pmbus_info_one},
	{"tps544b25", (kernel_ulong_t)&pmbus_info_one},
	{"tps544c20", (kernel_ulong_t)&pmbus_info_one},
	{"tps544c25", (kernel_ulong_t)&pmbus_info_one},
	{"udt020", (kernel_ulong_t)&pmbus_info_one},


My device is similar with the "pmbus" compatible about the 
"pmbus_info_zero" attribute. So I chose the "pmbus" compatible string 
for my device. If the maintainers require an explicitly compatible from 
device list in drivers/hwmon/pmbus/pmbus.c but not "pmbus", then I must 
add my device compatible string to the list in 
drivers/hwmon/pmbus/pmbus.c . Please help me confirm my understanding.

Thanks,
Chanh


> The tools are asking you to do something different via the warnings,
> and so am I :) Please define the compatible according to the device
> used in the design.
> 
> Thanks,
> 
> Andrew

