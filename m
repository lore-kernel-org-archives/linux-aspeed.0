From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Wed, 13 Sep 2023 17:52:59 +0800
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: document board compatibles
In-Reply-To: <26a53f62-d8d0-9583-e675-a3db99c60c8a@linaro.org>
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-2-yangchen.openbmc@gmail.com> <26a53f62-d8d0-9583-e675-a3db99c60c8a@linaro.org>
Message-ID: <CALFa7M_Gov4jd3wxrXWhxuPKbDr+cp8xmuWJCQH_N=a+q03M1A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

Thanks for your reply, Minerva is a project of Facebook server that
includes two types of boards. One is the motherboard that includes a BMC
and another is the Chassis Management Board that includes a CMC and both
use the Aspeed SoC (AST2600). These patches are for the CMC and the link
you provided is for the BMC and they need to use different DTS.

Thanks,
Yang Chen

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> ? 2023?9?13? ??
??4:20???

> On 12/09/2023 16:05, yangchen.openbmc at gmail.com wrote:
> > From: Yang Chen <yangchen.openbmc@gmail.com>
> >
> > Document the new compatibles used on the Facebook Minerva Chassis
> > Management Controller (CMC).
>
> How is this related to
>
> https://lore.kernel.org/all/20230907064514.1764010-3-peteryin.openbmc at gmail.com/
> ? Looks like duplicate :/
>
> Best regards,
> Krzysztof
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230913/bcddaed5/attachment-0001.htm>
