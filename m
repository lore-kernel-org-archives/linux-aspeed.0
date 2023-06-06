From: Patrick Williams <patrick@stwcx.xyz>
Date: Tue, 6 Jun 2023 09:06:53 -0500
Subject: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
Message-ID: <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 06, 2023 at 12:49:04PM +0200, Krzysztof Kozlowski wrote:

Hi Krzysztof,

Thank you for reviewing this from Billy.

The Aspeed chip is heavily used by the OpenBMC community and the 2600
has been used in production systems for almost 2 years now.  Many
companies are having to carry previous versions of these as patches, and
some of the APIs changed since the last revision from Billy.  So, I had
asked him to submit the latest patch set with as many revisions as he
understood what to change, since the conversation seemed to have died
since last time he submitted.  

I don't believe Billy is intentionally ignoring your feedback and he is
motivated to get this patch set wrapped up into an acceptable state.

> On 06/06/2023 11:45, Billy Tsai wrote:
 
> NAK. You got here clear comment. You cannot have simple MFD with
> resources. It is not simple anymore.
> 

In fairness, Billy asked for clarification from you on this point and didn't
receive it.

https://lore.kernel.org/lkml/24DD1FEB-95F3-47BE-BE61-8B0E6FBDE20F at aspeedtech.com/

He felt what he was trying to accomplish met the documented
expectations.  Are there some changes that need to be done in mfd.txt to
further clarify when to use it and when not to?

Again, we appreciate the time you've spent reviewing this patch set
already.  Thank you.

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230606/7fd1927b/attachment-0001.sig>
