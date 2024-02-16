From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Feb 2024 12:26:12 +0100
Subject: [PATCH 1/3] dt-bindings: i3c: drop "master" node name suffix
In-Reply-To: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
Message-ID: <00d6a0d5-6787-4777-8fb2-dcad4304a724@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 17/01/2024 08:56, Krzysztof Kozlowski wrote:
> Drop the requirement of "-master" suffix in node names because:
> 1. "Master" word is discouraged and MIPI Alliance renamed it to
>    "Controller".
> 2. Some devices can operate in Controller (Master) or Target mode, thus
>    the name is not accurate in such cases.
> 3. Other buses, like I2C controllers, use simple "i2c".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Rob, can you pick this one up? It seems Alexandre did not take it.

Best regards,
Krzysztof

