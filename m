From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 16:18:04 +0200
Subject: [PATCH v4 6/6] gpio: aspeed: Add the flush write to ensure the
 write complete.
In-Reply-To: <20240919094339.2407641-7-billy_tsai@aspeedtech.com>
References: <20240919094339.2407641-1-billy_tsai@aspeedtech.com> <20240919094339.2407641-7-billy_tsai@aspeedtech.com>
Message-ID: <CACRpkdbFD9CiqVwQ5xxZ9SfQtVvDJGCr=8spxBG4u-JQ0PKJ3w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 19, 2024 at 11:43?AM Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Performing a dummy read ensures that the register write operation is fully
> completed, mitigating any potential bus delays that could otherwise impact
> the frequency of bitbang usage. E.g., if the JTAG application uses GPIO to
> control the JTAG pins (TCK, TMS, TDI, TDO, and TRST), and the application
> sets the TCK clock to 1 MHz, the GPIO?s high/low transitions will rely on
> a delay function to ensure the clock frequency does not exceed 1 MHz.
> However, this can lead to rapid toggling of the GPIO because the write
> operation is POSTed and does not wait for a bus acknowledgment.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

If this applies cleanly on mainline I think it should go into fixes as-is.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
