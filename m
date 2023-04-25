From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 25 Apr 2023 10:00:26 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
Message-ID: <7fe274df-6bcd-5993-d6cc-8fbcef435866@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/04/2023 00:10, Rob Herring wrote:
>> I had some problem with gmail and sending mail too much users. I put Rob
>> and You and all the various list to try to workaround the "gmail spam
>> protection"
>>
>>> I am pretty sure we were discussing such split idea in the past and it
>>> did not get traction, but I cannot recall the exact discussion.
>>>
>>
>> I think the main issue here is how to handle bot and how problematic is
>> to merge this. As written in the cover letter the final version of this
>> should be a big series of 50+ patch with every commit specific to each
>> oem. In theory we should be able to merge the different oem separately
>> and try to at least start the categorization.
>> Another idea I got to at least have a "migration path" is to convert
>> every dts in the dts/ directory to a symbolic link that target the dts
>> in the correct oem. But I assume that would fix only part of the problem
>> and git am will still be problematic.
> 
> I have a script[1] that does the conversion written the last time this
> came up. Just have to agree on directory names. I think the easiest
> would be for Arnd/Olof to run it at the end of a merge window before
> rc1.
> 
> I'm very much in favor of this happening especially before *any*
> overlays are added to add to the mess (it's probably already
> happened).
> 
> Rob
> 
> [1] https://lore.kernel.org/all/20181204183649.GA5716 at bogus/

This is the thread I was thinking about. Looks good for me (the original
script with exynos->samsung).

Best regards,
Krzysztof

