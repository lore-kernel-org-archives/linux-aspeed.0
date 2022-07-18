From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Jul 2022 13:42:30 +0200
Subject: [PATCH] ARM: dts: aspeed: centriq2400: drop the board
In-Reply-To: <20220623072428.33697-1-krzysztof.kozlowski@linaro.org>
References: <20220623072428.33697-1-krzysztof.kozlowski@linaro.org>
Message-ID: <CAK8P3a0ob26oEL=af0KpyCqA4nxHW_PaaK3azKT504Q+VrFctA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 23, 2022 at 9:24 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The board is unmaintained and unused, according to Joel, so simply let's
> remove it.
>
> Link: https://lore.kernel.org/all/CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ at mail.gmail.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 -
>  .../dts/aspeed-bmc-arm-centriq2400-rep.dts    | 225 ------------------

I found this one in my patchwork backlog. I had expected Joel it pick it up, but
it's not in linux-next yet.

Joel, should I just apply it for 5.20 or do you want to send me a pull
request with
this included?

         Arnd
