From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Jul 2022 19:17:15 +0200
Subject: [PATCH 4/6] ARM: defconfig: address renamed CONFIG_DEBUG_INFO=y
In-Reply-To: <CAK8P3a0yc_iZ1dqbReckvune6KszCPvysCX9okYoaU-by+YRhQ@mail.gmail.com>
References: <20220721141325.2413920-1-arnd@kernel.org>
 <20220721141325.2413920-5-arnd@kernel.org>
 <e83c98f9-f32a-6bfd-71b6-9aba22aa7abb@linaro.org>
 <CAK8P3a0yc_iZ1dqbReckvune6KszCPvysCX9okYoaU-by+YRhQ@mail.gmail.com>
Message-ID: <3c3bccc2-786f-45f2-fe30-3e0c9f95da63@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/07/2022 22:43, Arnd Bergmann wrote:

> I'd rather keep them together: while removing the DEBUG_INFO is
> now a NOP, keeping the two changes together explains much better
> why this is done and is atomically needed based on the single patch
> that caused the change.
> 
> It's the same with the LEDS patch that replaces the CONFIG_LEDS
> option with CONFIG_NEW_LEDS.

OK,

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
