From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 19 Aug 2023 12:15:57 +0200
Subject: [PATCH] dt-bindings: pinctrl: aspeed: Allow only defined pin mux
 node properties
In-Reply-To: <20230819010907.916061-1-robh@kernel.org>
References: <20230819010907.916061-1-robh@kernel.org>
Message-ID: <7ec61967-c899-4ebf-abde-3c1c5576d54f@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19/08/2023 03:09, Rob Herring wrote:
> The Aspeed pinctrl bindings are missing an additionalProperties/
> unevaluatedProperties schemas on the child pin mux nodes which means any
> undefined properties are allowed. In addition, using
> 'additionalProperties' for child nodes with any name works better than a
> pattern matching everything with an if/then schema to select nodes only.
> 
> With 'additionalProperties' added, 'pins' and 'bias-disable'
> properties need to be added as they were not defined. A $ref to
> pinmux-node.yaml which defines the common property types was also
> missing.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Really 'pins' should have some constraints, but I don't know what the
> possible values are. Happy to add if someone can tell me what.
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

