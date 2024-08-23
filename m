From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 23 Aug 2024 13:18:26 +0930
Subject: [PATCH] dt-bindings: i2c: aspeed: drop redundant multi-master
In-Reply-To: <20240822132708.51884-1-krzysztof.kozlowski@linaro.org>
References: <20240822132708.51884-1-krzysztof.kozlowski@linaro.org>
Message-ID: <ce983ad163263ad32e4291f3a7f9361e395fd70e.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-08-22 at 15:27 +0200, Krzysztof Kozlowski wrote:
> 'multi-master' property is defined by core i2c-controller schema in
> dtschema package, so binding which references it and has
> unevaluatedProperties:false, does not need to mention it.  It is
> completely redundant here.
> 
> Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
