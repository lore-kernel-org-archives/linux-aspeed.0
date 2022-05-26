From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 26 May 2022 14:11:41 +0200
Subject: [PATCH -next] ARM: dts: aspeed: nuvia: rename vendor nuvia to
 qcom
In-Reply-To: <71613fa5-c468-e3ab-935a-7aa675e822fc@quicinc.com>
References: <20220523175640.60155-1-quic_jaehyoo@quicinc.com>
 <dd67a453-b75b-d092-f999-3faf05ef8160@linaro.org>
 <71613fa5-c468-e3ab-935a-7aa675e822fc@quicinc.com>
Message-ID: <32077a17-6a95-d583-9d7f-2276cf586b38@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 24/05/2022 13:57, Jae Hyun Yoo wrote:
> Hi Krzysztof,
> 
> On 5/24/2022 2:53 AM, Krzysztof Kozlowski wrote:
>> On 23/05/2022 19:56, Jae Hyun Yoo wrote:
>>> Nuvia has been acquired by Qualcomm and the vendor name 'nuvia' will
>>> not be used anymore so rename aspeed-bmc-nuvia-dc-scm.dts to
>>> aspeed-bmc-qcom-dc-scm-v1.dts and change 'nuvia' to 'qcom' as its vendor
>>> name in the file.
>>
>> And all users of this DTB now have to update their bootloaders, scripts,
>> installation methods. We did not rename FSL or Marvell boards, so
>> neither should be renamed this one.
> 
> Yeah, I know that we don't rename dts but the previous version of this
> change was picked recently in the middle of code review
> https://lore.kernel.org/all/979a5c87-a7ea-a1f0-e42e-29043df6b348 at quicinc.com/
> and the v3 was pulled recently so it's still in the -next queue so
> I believe it has a chance to be renamed since no one is using the DTB
> yet.

Ah, so it is still in next (or was before this merge window). OK, thanks
for explanation.

> 
>>>
>>> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>>> ---
>>>   arch/arm/boot/dts/Makefile                                    | 2 +-
>>>   ...eed-bmc-nuvia-dc-scm.dts => aspeed-bmc-qcom-dc-scm-v1.dts} | 4 ++--
>>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>>   rename arch/arm/boot/dts/{aspeed-bmc-nuvia-dc-scm.dts => aspeed-bmc-qcom-dc-scm-v1.dts} (97%)
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 03f5b3a15415..2a3c95387613 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -1584,7 +1584,6 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>>   	aspeed-bmc-lenovo-hr630.dtb \
>>>   	aspeed-bmc-lenovo-hr855xg2.dtb \
>>>   	aspeed-bmc-microsoft-olympus.dtb \
>>> -	aspeed-bmc-nuvia-dc-scm.dtb \
>>>   	aspeed-bmc-opp-lanyang.dtb \
>>>   	aspeed-bmc-opp-mihawk.dtb \
>>>   	aspeed-bmc-opp-mowgli.dtb \
>>> @@ -1597,6 +1596,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>>>   	aspeed-bmc-opp-witherspoon.dtb \
>>>   	aspeed-bmc-opp-zaius.dtb \
>>>   	aspeed-bmc-portwell-neptune.dtb \
>>> +	aspeed-bmc-qcom-dc-scm-v1.dtb \
>>>   	aspeed-bmc-quanta-q71l.dtb \
>>>   	aspeed-bmc-quanta-s6q.dtb \
>>>   	aspeed-bmc-supermicro-x11spi.dtb \
>>> diff --git a/arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts b/arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dts
>>> similarity index 97%
>>> rename from arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts
>>> rename to arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dts
>>> index f4a97cfb0f23..259ef3f54c5c 100644
>>> --- a/arch/arm/boot/dts/aspeed-bmc-nuvia-dc-scm.dts
>>> +++ b/arch/arm/boot/dts/aspeed-bmc-qcom-dc-scm-v1.dts
>>> @@ -6,8 +6,8 @@
>>>   #include "aspeed-g6.dtsi"
>>>   
>>>   / {
>>> -	model = "Nuvia DC-SCM BMC";
>>> -	compatible = "nuvia,dc-scm-bmc", "aspeed,ast2600";
>>> +	model = "Qualcomm DC-SCM V1 BMC";
>>> +	compatible = "qcom,dc-scm-v1-bmc", "aspeed,ast2600";
>>
>>
>> You need also change bindings.
> 
> I didn't see any case of changing bindings for adding a new Aspped BMC
> dts.

Hmmm... Where do you document these bindings? Or does it mean Aspeed
does not document it at all, every time the checkpatch complains but no
one thought about it why? :)

Best regards,
Krzysztof
