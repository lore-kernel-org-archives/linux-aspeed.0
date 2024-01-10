From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 10 Jan 2024 21:34:53 +0100
Subject: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
In-Reply-To: <3830c26d-96be-4084-a04d-8edb9ccbab5e@roeck-us.net>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
 <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
 <20231212-mouth-choice-40a83caa34ec@spud>
 <2946fbb1-2a47-4d21-83dc-8e45bf6ba5a9@roeck-us.net>
 <60c8bbdb-4e08-44f0-88d4-ab164d4843b5@linux.ibm.com>
 <20240109-pep-coerce-2a86ae88753d@spud>
 <01974929-dfbf-4989-ba39-369e521827d0@linux.ibm.com>
 <3d194e84-bf1a-48e4-a376-e5c327c6508d@linaro.org>
 <2dd37d2b-28da-4e73-9047-61ec5d64bdb5@linux.ibm.com>
 <edbefdfd-eb59-4d86-ad07-feb066a21082@linaro.org>
 <385b06e9-1daa-408a-a0ed-7b09d7d539df@linux.ibm.com>
 <d56b1e3e-72c4-427f-937d-8c8146bf5b28@linaro.org>
 <3830c26d-96be-4084-a04d-8edb9ccbab5e@roeck-us.net>
Message-ID: <32d46b64-d4a5-437a-8737-c2d172608559@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/01/2024 20:06, Guenter Roeck wrote:
> On 1/10/24 09:54, Krzysztof Kozlowski wrote:
>> On 10/01/2024 16:54, Ninad Palsule wrote:
>>> Hello Krzysztof,
>>>
>>>
>>> On 1/10/24 09:37, Krzysztof Kozlowski wrote:
>>>> On 10/01/2024 15:31, Ninad Palsule wrote:
>>>>> Hello Krzysztof,
>>>>>
>>>>>
>>>>>
>>>>>>>>> I have send it as a separate commit. https://lore.kernel.org/linux-kernel/20231214144954.3833998-1-ninad at linux.ibm.com/
>>>>>>>> Why did you do that? It now just adds undocumented compatibles to the
>>>>>>>> driver. Please, as Rob requested, work with Lukas on his series to make
>>>>>>>> sure that these devices are documented.
>>>>>>> I think krzysztof kozlowski suggested to send these patches separately:
>>>>>>> https://lore.kernel.org/linux-kernel/1c5ace65-2fd8-4503-b22f-e0f564d1c83f at linaro.org/
>>>>>>>
>>>>>>> Did I misunderstood it? Do you guys want me to include that commit again?
>>>>>> My comment was in DTS thread under specific DTS patch. How did you
>>>>>> figure out it applies to driver and bindings? This does not make sense.
>>>>> Sorry for the misunderstanding. Where do you want me to add driver
>>>>> patch? Before all DTS patches or after all DTS patches?
>>>> Does not matter, why do you insist on combining them with DTS? Drivers
>>>> and bindings are going together. DTS better separate, although depending
>>>> on the case can be together.
>>>>
>>> I have combined DTS and Driver because DTS was using compatibility
>>> string which is not upstream yet hence I thought it is logical to send
>>> it under same patchset.
>>
>> Sometimes yes, sometimes not. DTS must not go via driver subsystem, so
>> sending it in the same patchset has implications on maintainers applying
>> it. Some like it, some don't and you will be nagged for combining them.
>>
> 
> "DTS must not go via driver subsystem"
> 
> I always thought the guideline was to submit separate _patches_ for dts
> and driver changes, but as part of a single series. I didn't know that
> there is a rule to submit separate patch _series_. I also didn't know
> (and as far as I know no one called me on it) that I am not supposed
> to _apply_ dts changes. So far, I typically applied dts changes together
> with driver patches after receiving an Acked-by: or Reviewed-by:
> from a devicetree maintainer.

I did not notice you applying them, but such guideline - DTS must go via
respective SoC tree - was always repeated by me and SoC maintainers.
Just like gazillion other things probably was not documented... or even
if it was documented, it would be so deep among hundreds of other rules
nobody would find it. :)

> 
> This exchange suggests that I did it all wrong. Should I reject devicetree
> patches submitted as part of a driver patch series going forward ?

I propose: just ignore them. The SoC maintainer will pick them up.

> Should I not apply dts patches submitted as part of a patch series ?

No, please do not apply them.

> If so, it would help to have some documentation I can point to to explain
> the rationale to submitters (and myself). Also, in that case, how is the

Yes, it would. I can try to create something.

> synchronization between device tree patches and driver patches supposed
> to happen ?

There should not be synchronization. Just to remind: we talk about DTS
(so also DTSI and DTSO), thus everything being in arch/*/boot/dts/. We
do not talk about DT bindings, right? The bindings are obvious (and
documented): preferably go via driver subsystem, with fallback/special
cases via SoC tree and fallback to Rob.

The DTS must be independent from driver changes. If synchronization is
needed, it means it is not independent. It happens from time to time,
kind of expected exception, with proper justifications. In such case,
recommendation is to send DTS for the next kernel release, so after the
driver changes hit rc1.

> 
> FWIW, if dts changes are sent as separate series, I don't know how I would
> be able to review driver changes/submissions without being copied on the
> associated dts changes.

People are also encouraged to provide links between them. One lore link
is required: the DTS patchset, if sent in parallel, should have a link
to the thread with the bindings being reviewed on the list. Of course if
bindings are already accepted (in linux-next), then it's not necessary.
We all know how to use git grep.

Now about your specific question:

As a driver subsystem maintainer you are not expected, as a requirement,
to review DTS code. You can, you are welcomed, but don't you have
already too much stuff to review? Why would like to jump to DTS? If you
do, your help is appreciated, though. However think for a sec how would
it even work? Imagine we send new driver + bindings + DTS for OMAP in
one thread, so you see the DTS for your review. Now 2 months later I
send DTS for Qualcomm using that driver. You would never be Cc-ed on
this second submission. It wouldn't be even possible: get_maintainers.pl
would not print your email. Why would you be expected to be CCed on
first DTS to review and not on all others/further ones? This does not
make sense, really.

BTW, I am not saying here anything new. I was babbling about this every
second month since few years. :)

Best regards,
Krzysztof

