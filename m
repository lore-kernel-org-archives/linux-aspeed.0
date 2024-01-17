From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 17 Jan 2024 16:20:28 +0800
Subject: [PATCH 1/3] dt-bindings: i3c: drop "master" node name suffix
In-Reply-To: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
Message-ID: <491efee1860ef1fbe94f990faea9c40cd99294c4.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

> Drop the requirement of "-master" suffix in node names because:
> 1. "Master" word is discouraged and MIPI Alliance renamed it to
> ?? "Controller".
> 2. Some devices can operate in Controller (Master) or Target mode,
>    thus the name is not accurate in such cases.
> 3. Other buses, like I2C controllers, use simple "i2c".

Sounds good, thanks!

For the ast2600-i3c changes:

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy
