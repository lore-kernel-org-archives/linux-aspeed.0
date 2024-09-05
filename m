From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 5 Sep 2024 13:51:06 +0200
Subject: [PATCH 1/2] dt-bindings: net: aspeed: Add binding for ASPEED
 AST2700 MDIO
In-Reply-To: <20240905114754.519609-2-jacky_chou@aspeedtech.com>
References: <20240905114754.519609-1-jacky_chou@aspeedtech.com>
 <20240905114754.519609-2-jacky_chou@aspeedtech.com>
Message-ID: <49eda495-fe7a-4f83-b9cc-03a04543005c@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 05/09/2024 13:47, Jacky Chou wrote:
> Add a new compatible for ASPEED AST2700 MDIO.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Best regards,
Krzysztof

