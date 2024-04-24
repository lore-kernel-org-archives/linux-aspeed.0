From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 24 Apr 2024 08:55:46 +0200
Subject: [PATCH] ARM: dts: aspeed: Add vendor prefixes to lm25066 compat
 strings
In-Reply-To: <20240224103712.20864-2-zev@bewilderbeest.net>
References: <20240224103712.20864-2-zev@bewilderbeest.net>
Message-ID: <32449cf7-a2f7-40c4-a3dd-bb10429ebdbd@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 24/02/2024 11:37, Zev Weiss wrote:
> Due to the way i2c driver matching works (falling back to the driver's
> id_table if of_match_table fails) this didn't actually cause any
> misbehavior, but let's add the vendor prefixes so things actually work
> the way they were intended to.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

