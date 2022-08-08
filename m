From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 08 Aug 2022 11:06:13 +0930
Subject: [PATCH] ARM: dts: ast2600-evb: correct compatible (drop -a1)
In-Reply-To: <20220804092727.64742-1-krzysztof.kozlowski@linaro.org>
References: <20220804092727.64742-1-krzysztof.kozlowski@linaro.org>
Message-ID: <86969f10-9eb1-4c1e-955c-1a00890d10dd@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 4 Aug 2022, at 18:57, Krzysztof Kozlowski wrote:
> Due to copy-paste, the ast2600-evb and ast2600-evb-a1 got the same
> compatible.  Drop the '-a1' suffix from the first to match what is
> expected by bindings.
>
> Fixes: aa5e06208500 ("ARM: dts: ast2600-evb: fix board compatible")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
