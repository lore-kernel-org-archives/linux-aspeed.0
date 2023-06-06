From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 6 Jun 2023 16:23:52 +0200
Subject: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
 <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
Message-ID: <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/06/2023 16:06, Patrick Williams wrote:
> On Tue, Jun 06, 2023 at 12:49:04PM +0200, Krzysztof Kozlowski wrote:
> 
> Hi Krzysztof,
> 
> Thank you for reviewing this from Billy.
> 
> The Aspeed chip is heavily used by the OpenBMC community and the 2600
> has been used in production systems for almost 2 years now.  Many
> companies are having to carry previous versions of these as patches, and
> some of the APIs changed since the last revision from Billy.  So, I had
> asked him to submit the latest patch set with as many revisions as he
> understood what to change, since the conversation seemed to have died
> since last time he submitted.  
> 
> I don't believe Billy is intentionally ignoring your feedback and he is
> motivated to get this patch set wrapped up into an acceptable state.
> 
>> On 06/06/2023 11:45, Billy Tsai wrote:
>  
>> NAK. You got here clear comment. You cannot have simple MFD with
>> resources. It is not simple anymore.
>>
> 
> In fairness, Billy asked for clarification from you on this point and didn't
> receive it.
> 
> https://lore.kernel.org/lkml/24DD1FEB-95F3-47BE-BE61-8B0E6FBDE20F at aspeedtech.com/

I gave the instruction what Billy should do:

https://lore.kernel.org/lkml/41500a04-b004-0e2c-20a1-3a3092b90e6d at linaro.org/

What about other ignored comments? About subject, quotes and more? Even
if this one was unclear, then why ignoring all the rest?

> 
> He felt what he was trying to accomplish met the documented
> expectations.  Are there some changes that need to be done in mfd.txt to
> further clarify when to use it and when not to?

I think mfd.txt clearly states:
"For more complex devices, when the nexus driver has to
probe registers to figure out what child devices exist etc, this should
not be used. In the latter case the child devices will be determined by
the operating system."

Also, repeated many times:
https://lore.kernel.org/all/YXhINE00HG6hbQI4 at robh.at.kernel.org/
https://lore.kernel.org/all/20220701000959.GA3588170-robh at kernel.org/
https://osseu2022.sched.com/event/15z0W

Best regards,
Krzysztof

