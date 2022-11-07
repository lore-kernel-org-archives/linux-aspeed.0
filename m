From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 7 Nov 2022 10:16:31 +0100
Subject: [v2 2/2] dt-bindings: iio: adc: Remove the property
 "aspeed,trim-data-valid"
In-Reply-To: <20221107091506.28630-2-billy_tsai@aspeedtech.com>
References: <20221107091506.28630-1-billy_tsai@aspeedtech.com>
 <20221107091506.28630-2-billy_tsai@aspeedtech.com>
Message-ID: <9ddc0bc9-c5cf-6c94-d15e-77a7a7e2b7f1@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 07/11/2022 10:15, Billy Tsai wrote:
> The valid of the trimming data will use the otp default value as a
> criterion.
> 
> Fixes: 2bdb2f00a895 ("dt-bindings: iio: adc: Add ast2600-adc bindings")

If this is a fix, you need to describe the bug.

> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof

