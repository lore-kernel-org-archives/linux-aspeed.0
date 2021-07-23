From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Jul 2021 11:57:24 +0200
Subject: [PATCH v6 5/9] gpio: gpio-aspeed-sgpio: Add AST2600 sgpio support
In-Reply-To: <20210712100317.23298-6-steven_lee@aspeedtech.com>
References: <20210712100317.23298-1-steven_lee@aspeedtech.com>
 <20210712100317.23298-6-steven_lee@aspeedtech.com>
Message-ID: <CACRpkdbSEXd4bfhEi2UfHvjrUzzibqNBCfdcYfcWcknSgndyYQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 12, 2021 at 12:04 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> The maximum number of gpio pins of SoC is hardcoded as 80 and the gpio pin
> count mask for GPIO Configuration register is hardcode as GENMASK(9,6).
> However, AST2600 has 2 sgpio master interfaces, one of them supports up
> to 128 gpio pins and pin count mask of GPIO Configuration Register is 5
> bits.
>
> The patch adds ast2600 compatibles, removes MAX_NR_HW_SGPIO and
> corresponding design to make the gpio input/output pin base are determined
> by ngpios.
> The patch also removed hardcoded pin mask and adds ast2400, ast2500,
> ast2600 platform data that include gpio pin count mask for GPIO
> Configuration Register.
>
> The original pin order is as follows:
> (suppose MAX_NR_HW_SGPIO is 80 and ngpios is 10 as well)
> Input:
> 0 1 2 3 ... 9
> Output:
> 80 81 82 ... 89
>
> The new pin order is as follows:
> Input:
> 0 2 4 6 ... 18
> Output:
> 1 3 5 7 ... 19
>
> SGPIO pin id and input/output pin mapping is as follows:
> SGPIO0(0,1), SGPIO1(2,3), ..., SGPIO79(158,159)
>
> For example:
> Access SGPIO5(10,11)
> Get SGPIO pin 5 (suppose sgpio chip id is 2)
> gpioget 2 10
>
> Set SGPIO pin 5 (suppose sgpio chip id is 2)
> gpioset 2 11=1
> gpioset 2 11=0
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>

Nice use of match data. This is exactly how it shall be done.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
