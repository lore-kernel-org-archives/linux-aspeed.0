From: Heiko Stuebner <heiko@sntech.de>
Date: Wed, 22 Jun 2022 21:47:36 +0200
Subject: (subset) [PATCH v3 00/40] dt-bindings: input: gpio-keys: rework matching children
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
Message-ID: <165592714968.3933570.9891201783444800337.b4-ty@sntech.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 15 Jun 2022 17:52:24 -0700, Krzysztof Kozlowski wrote:
> Merging
> =======
> 1. dt-bindings: rebased on top of Rob's:
>    https://lore.kernel.org/all/20220608211207.2058487-1-robh at kernel.org/
> 
> 2. DTS patches are independent. They can be picked up directly by sub-arch
>    maintainers, by Arnd or Olof, or eventually by me (if you wish).
> 
> [...]

Applied, thanks!

[26/40] arm64: dts: rockchip: align gpio-key node names with dtschema
        commit: 517ed0ffd3cc691bef747288d51d01d2705b2251

        In the pinenote dts the original patch changed "cover" to
        switch, so to keep the cover information intact, I changed
        the node to "switch-cover" ... similar to other "switch-lid"
        instances in some other Rockchip devicetrees.

[27/40] ARM: dts: rockchip: align gpio-key node names with dtschema
        commit: 271e2c92285075a890c58cba9ad5979a8959f6ff
[28/40] ARM: dts: rockchip: rk3288-tinker: correct gpio-keys properties
        commit: e5a3cbe8b45b0a436a39cc969b7bcc8353248018

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
