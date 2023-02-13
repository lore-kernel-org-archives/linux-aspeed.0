From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 14:42:51 +0100
Subject: [PATCH v3 2/5] dt-bindings: clock: ast2600: Add top-level I3C
 clock
In-Reply-To: <cfa142894e3e3a2895ae1ef7dce9bc89c493b9f4.1676294433.git.jk@codeconstruct.com.au>
References: <cover.1676294433.git.jk@codeconstruct.com.au>
 <cfa142894e3e3a2895ae1ef7dce9bc89c493b9f4.1676294433.git.jk@codeconstruct.com.au>
Message-ID: <6066657a-8e6d-77d2-7074-7ab1ad402b89@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/02/2023 14:24, Jeremy Kerr wrote:
> The ast2600 hardware has a top-level clock for all i3c controller
> peripherals (then gated to each individual controller), so add a
> top-level i3c clock line to control this.
> 
> This is a partial cherry-pick and rework of ed44b8cdfdb and 1a35eb926d7
> from Aspeed's own tree, originally by Dylan Hung
> <dylan_hung@aspeedtech.com>.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

