From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 4 Jan 2021 16:03:02 +0100
Subject: [PATCH v3] driver: aspeed: g6: Fix PWMG0 pinctrl setting
In-Reply-To: <20201217024912.3198-1-billy_tsai@aspeedtech.com>
References: <1e823780-b1ef-42dd-bb60-321b4d482d31@www.fastmail.com>
 <20201217024912.3198-1-billy_tsai@aspeedtech.com>
Message-ID: <CACRpkdbLG5Sc8JjonGjDdJraStoz7PfQxBEb5ai_gktV4whzdQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 17, 2020 at 3:50 AM Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The SCU offset for signal PWM8 in group PWM8G0 is wrong, fix it from
> SCU414 to SCU4B4.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Patch applied for fixes.

Yours,
Linus Walleij
