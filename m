From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 7 Jun 2023 06:26:19 +0000
Subject: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
 <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
 <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
Message-ID: <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

        On 06/06/2023 16:06, Patrick Williams wrote:
        >> On Tue, Jun 06, 2023 at 12:49:04PM +0200, Krzysztof Kozlowski wrote:
        >>
        >> Hi Krzysztof,
        >>
        >> Thank you for reviewing this from Billy.
        >>
        >> The Aspeed chip is heavily used by the OpenBMC community and the 2600
        >> has been used in production systems for almost 2 years now.  Many
        >> companies are having to carry previous versions of these as patches, and
        >> some of the APIs changed since the last revision from Billy.  So, I had
        >> asked him to submit the latest patch set with as many revisions as he
        >> understood what to change, since the conversation seemed to have died
        >> since last time he submitted.
        >>
        >> I don't believe Billy is intentionally ignoring your feedback and he is
        >> motivated to get this patch set wrapped up into an acceptable state.
        >>
        >>> On 06/06/2023 11:45, Billy Tsai wrote:
        >>
        >>> NAK. You got here clear comment. You cannot have simple MFD with
        >>> resources. It is not simple anymore.
        >>>
        >>
        >> In fairness, Billy asked for clarification from you on this point and didn't
        >> receive it.
        >>
        >> https://lore.kernel.org/lkml/24DD1FEB-95F3-47BE-BE61-8B0E6FBDE20F at aspeedtech.com/

        > I gave the instruction what Billy should do:

        > https://lore.kernel.org/lkml/41500a04-b004-0e2c-20a1-3a3092b90e6d at linaro.org/

        > What about other ignored comments? About subject, quotes and more? Even
        > if this one was unclear, then why ignoring all the rest?

It's possible that there was some confusion regarding your message. I apologize for any misunderstanding.
About the subject: I apologize for the misunderstanding. I just drop the redundant "bindings" in the commit message.
About the quotes: I believe the issue was simply related to the order of the patches, and I have resolved it. Did I misunderstand?
About the Missing description:

> +patternProperties:
> +  "^fan@[a-z0-9]+$":
> +    type: object

> Missing description. But more important - why do you have such child
> nodes? Your example does not have them. What's the point? Do you expect
> different number of fans per one device (one compatible)?

In this patch series, I have included examples and descriptions to provide additional information.
The child node is used to enable the channel of this tach controller.
I expect that the dts will include information regarding the number of fans connected to the board and their corresponding channels.

        >>
        >> He felt what he was trying to accomplish met the documented
        >> expectations.  Are there some changes that need to be done in mfd.txt to
        >> further clarify when to use it and when not to?

        > I think mfd.txt clearly states:
        > "For more complex devices, when the nexus driver has to
        > probe registers to figure out what child devices exist etc, this should
        > not be used. In the latter case the child devices will be determined by
        > the operating system."

About the mfd:
For our pwm and tach devices, there is no need to check/apply any hardware register from parent to determine child?s existence or functional.
They don?t have any dependency on the parent node. In fact, it doesn?t require a specific driver to bind with the "aspeed,ast2600-pwm-tach" label. Their purpose is solely to share the same clock, reset phandle and base address. The main reason for using simple-mfd in this case is because these two independent devices share the same base address. In fact, I can relocate the clock and reset configurations to the child nodes rather than the parent node.  In this case, I still can't use simple-mfd?

I appreciate your assistance and review.

Best Regards,
Billy Tsai
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230607/30c6b1f7/attachment.htm>
