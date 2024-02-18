From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Sun, 18 Feb 2024 23:57:19 +0100
Subject: (subset) [PATCH 1/3] dt-bindings: i3c: drop "master" node name
 suffix
In-Reply-To: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
Message-ID: <170829700336.822203.177392854952786485.b4-ty@bootlin.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 17 Jan 2024 08:56:16 +0100, Krzysztof Kozlowski wrote:
> Drop the requirement of "-master" suffix in node names because:
> 1. "Master" word is discouraged and MIPI Alliance renamed it to
>    "Controller".
> 2. Some devices can operate in Controller (Master) or Target mode, thus
>    the name is not accurate in such cases.
> 3. Other buses, like I2C controllers, use simple "i2c".
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: i3c: drop "master" node name suffix
      https://git.kernel.org/abelloni/c/c53611f2e27a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
