From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 Feb 2024 08:47:58 +0100
Subject: [PATCH v6] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT
 schema
In-Reply-To: <20240228003043.1167394-1-andrew@codeconstruct.com.au>
References: <20240228003043.1167394-1-andrew@codeconstruct.com.au>
Message-ID: <c2060450-4b76-4740-afe4-d14717245f01@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 28/02/2024 01:30, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/gpio at 1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> ```
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> v6: Address more constraint feedback from Krzysztof:
>     https://lore.kernel.org/all/f69ef2ad-8ace-40c8-b923-4dde20eda2ec at linaro.org/

You still have way too many examples. One is enough, two is still okay.
We really do not want more of examples with minor differences.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

