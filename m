From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Jul 2024 13:10:16 +0200
Subject: [PATCH v1 01/10] dt-binding: mfd: aspeed,ast2x00-scu: Add binding
 for ASPEED AST2700 SCU
In-Reply-To: <20240726110355.2181563-2-kevin_chen@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-2-kevin_chen@aspeedtech.com>
Message-ID: <e6cb6f26-fef2-49bc-ab25-fdc9a659f593@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/07/2024 13:03, Kevin Chen wrote:
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>

Missing commit msg.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18



Best regards,
Krzysztof

