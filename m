From: Andi Shyti <andi.shyti@kernel.org>
Date: Fri, 23 Aug 2024 02:47:51 +0200
Subject: [PATCH] dt-bindings: i2c: aspeed: drop redundant multi-master
In-Reply-To: <20240822132708.51884-1-krzysztof.kozlowski@linaro.org>
References: <20240822132708.51884-1-krzysztof.kozlowski@linaro.org>
Message-ID: <htpetam5ykc622qcc5xrnl45d2qqniuucqf62ogoqq4esqnkvx@36lblj4ptzib>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On Thu, Aug 22, 2024 at 03:27:08PM GMT, Krzysztof Kozlowski wrote:
> 'multi-master' property is defined by core i2c-controller schema in
> dtschema package, so binding which references it and has
> unevaluatedProperties:false, does not need to mention it.  It is
> completely redundant here.
> 
> Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for taking care of this! Merged to i2c/i2c-host.

Andi
