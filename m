From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 2 Oct 2024 17:48:16 +0200
Subject: [PATCH v4 6/6] gpio: aspeed: Add the flush write to ensure the
 write complete.
In-Reply-To: <OSQPR06MB7252DF4BB404D5C01785BB5B8B702@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20240919094339.2407641-1-billy_tsai@aspeedtech.com>
 <20240919094339.2407641-7-billy_tsai@aspeedtech.com> <CACRpkdbFD9CiqVwQ5xxZ9SfQtVvDJGCr=8spxBG4u-JQ0PKJ3w@mail.gmail.com>
 <CAMRc=MdvV7Z2yPpoR9mXLH6UCF5uA=TbkC_qUSj=akP_09M0WQ@mail.gmail.com> <OSQPR06MB7252DF4BB404D5C01785BB5B8B702@OSQPR06MB7252.apcprd06.prod.outlook.com>
Message-ID: <CAMRc=MdXeRCj9ExsKH31isE9qdbNyC7=nWL=GgORknSZjf7oVg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2024 at 5:09?PM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
> > >
> > > On Thu, Sep 19, 2024 at 11:43?AM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> > >
> > > > Performing a dummy read ensures that the register write operation is fully
> > > > completed, mitigating any potential bus delays that could otherwise impact
> > > > the frequency of bitbang usage. E.g., if the JTAG application uses GPIO to
> > > > control the JTAG pins (TCK, TMS, TDI, TDO, and TRST), and the application
> > > > sets the TCK clock to 1 MHz, the GPIO?s high/low transitions will rely on
> > > > a delay function to ensure the clock frequency does not exceed 1 MHz.
> > > > However, this can lead to rapid toggling of the GPIO because the write
> > > > operation is POSTed and does not wait for a bus acknowledgment.
> > > >
> > > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > >
> > > If this applies cleanly on mainline I think it should go into fixes as-is.
> > >
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > >
> > > Yours,
> > > Linus Walleij
>
> > I agree but it doesn't. :(
>
> > Billy: please send it separately and - while at it - use a C-style comment.
>
> > Bart
>
> Hi Linus Walleij and Bart,
>
> Sorry, I don?t quite understand the meaning of ?send it separately.?
> Does this mean I need to send this patch individually after the GPIO patch series has been accepted?
>

This is a fix, meaning: it should go upstream now and get backported
to stable branches. The other patches from this series will go in the
next merge window in two months or so. So send this as the first patch
in the series with an appropriate Fixes: tag or even send it entirely
independently from the rest.

Bart
