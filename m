From: Kevin Chen <kevin_chen@aspeedtech.com>
Date: Fri, 16 Aug 2024 04:06:48 +0000
Subject: [PATCH v1 01/10] dt-binding: mfd: aspeed,ast2x00-scu: Add binding
 for ASPEED AST2700 SCU
In-Reply-To: <e6cb6f26-fef2-49bc-ab25-fdc9a659f593@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-2-kevin_chen@aspeedtech.com>
 <e6cb6f26-fef2-49bc-ab25-fdc9a659f593@kernel.org>
Message-ID: <PSAPR06MB4949851D669EB456677AFC3A89812@PSAPR06MB4949.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzk,

I will separate clock part in the v3 patch into Ryan's clock series.
>
> Missing commit msg.
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory your
> patch is touching. For bindings, the preferred subjects are explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patch
> es.html#i-for-patch-submitters
>
> A nit, subject: drop second/last, redundant "bindings for". The "dt-bindings"
> prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bin
> dings/submitting-patches.rst#L18
Agree, already fixed in another commit in Ryan's series.
https://patchwork.kernel.org/project/linux-clk/patch/20240808075937.2756733-2-ryan_chen at aspeedtech.com/

>
>
>
> Best regards,
> Krzysztof

--
Best Regards,
Kevin.Chen
************* Email Confidentiality Notice ********************
????:
???(????)????????????????? ???????????????????????????, ??????????????????????????????!

DISCLAIMER:
This message (and any attachments) may contain legally privileged and/or other confidential information. If you have received it in error, please notify the sender by reply e-mail and immediately delete the e-mail and any attachments without copying or disclosing the contents. Thank you.
