From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 10 Jan 2024 11:06:08 -0800
Subject: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
In-Reply-To: <d56b1e3e-72c4-427f-937d-8c8146bf5b28@linaro.org>
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
Message-ID: <3830c26d-96be-4084-a04d-8edb9ccbab5e@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/10/24 09:54, Krzysztof Kozlowski wrote:
> On 10/01/2024 16:54, Ninad Palsule wrote:
>> Hello Krzysztof,
>>
>>
>> On 1/10/24 09:37, Krzysztof Kozlowski wrote:
>>> On 10/01/2024 15:31, Ninad Palsule wrote:
>>>> Hello Krzysztof,
>>>>
>>>>
>>>>
>>>>>>>> I have send it as a separate commit. https://lore.kernel.org/linux-kernel/20231214144954.3833998-1-ninad at linux.ibm.com/
>>>>>>> Why did you do that? It now just adds undocumented compatibles to the
>>>>>>> driver. Please, as Rob requested, work with Lukas on his series to make
>>>>>>> sure that these devices are documented.
>>>>>> I think krzysztof kozlowski suggested to send these patches separately:
>>>>>> https://lore.kernel.org/linux-kernel/1c5ace65-2fd8-4503-b22f-e0f564d1c83f at linaro.org/
>>>>>>
>>>>>> Did I misunderstood it? Do you guys want me to include that commit again?
>>>>> My comment was in DTS thread under specific DTS patch. How did you
>>>>> figure out it applies to driver and bindings? This does not make sense.
>>>> Sorry for the misunderstanding. Where do you want me to add driver
>>>> patch? Before all DTS patches or after all DTS patches?
>>> Does not matter, why do you insist on combining them with DTS? Drivers
>>> and bindings are going together. DTS better separate, although depending
>>> on the case can be together.
>>>
>> I have combined DTS and Driver because DTS was using compatibility
>> string which is not upstream yet hence I thought it is logical to send
>> it under same patchset.
> 
> Sometimes yes, sometimes not. DTS must not go via driver subsystem, so
> sending it in the same patchset has implications on maintainers applying
> it. Some like it, some don't and you will be nagged for combining them.
> 

"DTS must not go via driver subsystem"

I always thought the guideline was to submit separate _patches_ for dts
and driver changes, but as part of a single series. I didn't know that
there is a rule to submit separate patch _series_. I also didn't know
(and as far as I know no one called me on it) that I am not supposed
to _apply_ dts changes. So far, I typically applied dts changes together
with driver patches after receiving an Acked-by: or Reviewed-by:
from a devicetree maintainer.

This exchange suggests that I did it all wrong. Should I reject devicetree
patches submitted as part of a driver patch series going forward ?
Should I not apply dts patches submitted as part of a patch series ?
If so, it would help to have some documentation I can point to to explain
the rationale to submitters (and myself). Also, in that case, how is the
synchronization between device tree patches and driver patches supposed
to happen ?

FWIW, if dts changes are sent as separate series, I don't know how I would
be able to review driver changes/submissions without being copied on the
associated dts changes.

Guess I am more than a bit confused.

Thanks,
Guenter

