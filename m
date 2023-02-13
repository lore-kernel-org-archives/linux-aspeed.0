From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 14:43:31 +0100
Subject: [PATCH v3 4/5] dt-bindings: clock: ast2600: remove IC36 & I3C7
 clock definitions
In-Reply-To: <1b9bb33e75c0a84880035954d500a6e608668b99.1676294433.git.jk@codeconstruct.com.au>
References: <cover.1676294433.git.jk@codeconstruct.com.au>
 <1b9bb33e75c0a84880035954d500a6e608668b99.1676294433.git.jk@codeconstruct.com.au>
Message-ID: <bc0adda7-9636-b1f5-3fe4-67ba6a3ddc9b@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/02/2023 14:24, Jeremy Kerr wrote:
> The current ast2600 clock definitions include entries for i3c6 and i3c7
> devices, which don't exist: there are no clock control lines documented
> for these, and only i3c devices 0 through 5 are present.
> 
> So, remove the definitions for I3C6 and I3C7. Although this is a
> potential ABI-breaking change, there are no in-tree users of these, and
> any references would be broken anyway, as the hardware doesn't exist.
> 
> This is a partial cherry-pick and rework of ed44b8cdfdb and 1a35eb926d7
> from Aspeed's own tree, originally by Dylan Hung
> <dylan_hung@aspeedtech.com>.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

