From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Wed, 13 Sep 2023 22:19:15 +0800
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: document board compatibles
In-Reply-To: <605e4577-1e01-cd0b-9d42-34401bd7f3a7@linaro.org>
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-2-yangchen.openbmc@gmail.com> <26a53f62-d8d0-9583-e675-a3db99c60c8a@linaro.org>
 <CALFa7M_Gov4jd3wxrXWhxuPKbDr+cp8xmuWJCQH_N=a+q03M1A@mail.gmail.com> <605e4577-1e01-cd0b-9d42-34401bd7f3a7@linaro.org>
Message-ID: <CALFa7M9uaFuX4OEy9XdRa7xtKECOvJvg=MH_jkJ+jrfRe4M_SQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On 13/09/2023 11:52, Yang Chen wrote:
> > Hi Krzysztof,
> >
> > Thanks for your reply, Minerva is a project of Facebook server that
> > includes two types of boards. One is the motherboard that includes a BMC
> > and another is the Chassis Management Board that includes a CMC and both
> > use the Aspeed SoC (AST2600). These patches are for the CMC and the link
> > you provided is for the BMC and they need to use different DTS.
>
> Are they similar? Maybe you should share board DTSI?
>
> Best regards,
> Krzysztof
>

No, they are not similar. They just use the same SoC but they are on
different system boards with different electronic schematic.

Thanks,
Yang Chen
