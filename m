From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 16 Feb 2023 09:24:09 +0100
Subject: [PATCH 1/4] dt-bindings: i3c: Add AST2600 i3c controller
In-Reply-To: <82d750f53df622d8986e9a07053c7ee27dee61a2.1676532146.git.jk@codeconstruct.com.au>
References: <cover.1676532146.git.jk@codeconstruct.com.au>
 <82d750f53df622d8986e9a07053c7ee27dee61a2.1676532146.git.jk@codeconstruct.com.au>
Message-ID: <03fe68be-ca9f-967c-b5ef-0599177caf90@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 16/02/2023 08:41, Jeremy Kerr wrote:
> Add a devicetree binding for the ast2600 i3c controller hardware. This
> is heavily based on the designware i3c core, plus a reset facility
> and two platform-specific properties:
> 
>  - sda-pullup-ohms: to specify the value of the configurable pullup
>    resistors on the SDA line
> 
>  - aspeed,global-regs: to reference the (ast2600-specific) i3c global
>    register block, and the device index to use within it.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

