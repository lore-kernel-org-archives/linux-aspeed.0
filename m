From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 24 Apr 2024 08:58:38 +0200
Subject: [PATCH] ARM: dts: aspeed: Add vendor prefixes to lm25066 compat strings
In-Reply-To: <20240224103712.20864-2-zev@bewilderbeest.net>
References: <20240224103712.20864-2-zev@bewilderbeest.net>
Message-ID: <171394189432.44668.6061047707500811188.b4-ty@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Sat, 24 Feb 2024 02:37:07 -0800, Zev Weiss wrote:
> Due to the way i2c driver matching works (falling back to the driver's
> id_table if of_match_table fails) this didn't actually cause any
> misbehavior, but let's add the vendor prefixes so things actually work
> the way they were intended to.
> 
> 

Two months passed, no replies from maintainers about picking it up. Dunno,
looks abandoned, so let me grab this. If anyone else wants to pick it up, let
me know.

Applied, thanks!

[1/1] ARM: dts: aspeed: Add vendor prefixes to lm25066 compat strings
      https://git.kernel.org/krzk/linux-dt/c/1afe35e54a89d762f1cf71da1ef29be2c387be35

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
