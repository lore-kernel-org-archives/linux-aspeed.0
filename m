From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Wed, 3 Nov 2021 09:13:13 -0700
Subject: [PATCH -next v2 5/6] dt-bindings: ipmi: aspeed,kcs-bmc: add
 'clocks' as a required property
In-Reply-To: <20211103015227.GO4667@minyard.net>
References: <20211102203717.96794-1-jae.hyun.yoo@intel.com>
 <20211102203717.96794-6-jae.hyun.yoo@intel.com>
 <1635902437.654631.3880388.nullmailer@robh.at.kernel.org>
 <20211103015227.GO4667@minyard.net>
Message-ID: <e5646939-79ed-a588-da22-4ec45213e49a@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/2/2021 6:52 PM, Corey Minyard wrote:
> On Tue, Nov 02, 2021 at 08:20:37PM -0500, Rob Herring wrote:
>> On Tue, 02 Nov 2021 13:37:16 -0700, jae.hyun.yoo at intel.com wrote:
>>> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>>
>>> Add 'clocks' as a required property.
>>>
>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>> ---
>>> v1 -> v2:
>>> Changes sinve v1:
>>>   - Added 'clocks' property into kcs-bmc bindings using
>>>     'aspeed,ast2400-kcs-bmc.yaml' because it's not merged into
>>>     'aspeed-lpc.yaml' yet. The bindings merging could be done using a
>>>     separate patch later.
>>>
>>>   .../devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml   | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
>>
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/patch/1549943
>>
> 
>  From the code, I think this change will break all these platforms, as
> the initialization of kcs will fail without the clock property.  I'm
> going to pull this out until it gets sorted out.
> 
> Also, could you rebase on the latest kernel when submitting next time?
> There was a minor thing I had to fix up.
> 
> -corey

Hi Corey,

I believe that this series will not break these platforms if this series
applied correctly but I agree with that we don't need to rush this.

I'll submit v3 after rebasing it on the latest master when all queued
changes in '-next' are merged. It would be also good for reducing
confusions if any.

Thanks,
Jae

>>
>> kcs at 114: 'clocks' is a required property
>> 	arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dt.yaml
>> 	arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dt.yaml
>> 	arch/arm/boot/dts/aspeed-bmc-inspur-nf5280m6.dt.yaml
>>
>> kcs at 24: 'clocks' is a required property
>> 	arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dt.yaml
>>
>> kcs at 28: 'clocks' is a required property
>> 	arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dt.yaml
>> 	arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dt.yaml
>> 	arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dt.yaml
>>
>> kcs at 2c: 'clocks' is a required property
>> 	arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dt.yaml
>> 	arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dt.yaml
>> 	arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dt.yaml
>> 	arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dt.yaml
>> 	arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dt.yaml
>> 	arch/arm/boot/dts/aspeed-bmc-inspur-nf5280m6.dt.yaml
>>
