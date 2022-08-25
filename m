From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Aug 2022 15:03:12 +0300
Subject: [PATCH] dt-bindings: usb: Add missing
 (unevaluated|additional)Properties on child nodes
In-Reply-To: <20220823145649.3118479-9-robh@kernel.org>
References: <20220823145649.3118479-9-robh@kernel.org>
Message-ID: <cb6c855c-2931-b957-8cab-5df33de4792e@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/08/2022 17:56, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
