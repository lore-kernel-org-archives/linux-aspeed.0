From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Jan 2023 20:04:42 +0100
Subject: [PATCH 2/2] spi: dt-bindings: cleanup examples - indentation,
 lowercase hex
In-Reply-To: <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org> <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
Message-ID: <CAMuHMdWZOsrBwJrST=49v6JFqCyq_gT0kfA-QS7TS4oigZtM-w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 18, 2023 at 6:39 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Cleanup examples:
>  - use 4-space indentation (for cases when it is neither 4 not 2 space),
>  - drop redundant blank lines,
>  - use lowercase hex.
>
> No functional impact except adjusting to preferred coding style.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  .../devicetree/bindings/spi/renesas,rspi.yaml |  22 +--

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
