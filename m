From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 29 May 2024 09:27:47 +0200
Subject: [PATCH 2/4] dt-bindings: gpio: aspeed,sgpio: Specify
 gpio-line-names
In-Reply-To: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-2-91c42976833b@codeconstruct.com.au>
References: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
 <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-2-91c42976833b@codeconstruct.com.au>
Message-ID: <5d0016f1-ccdc-4645-9840-6f8c2870ef6c@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/05/2024 07:13, Andrew Jeffery wrote:
> Some devicetrees specify gpio-line-names in the sgpio node despite it
> not being defined by the binding. It's a reasonable thing to do, so
> define the property to squash warnings such as:
> 
> ```

No need for ```

This is just commit log. Not markdown.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

