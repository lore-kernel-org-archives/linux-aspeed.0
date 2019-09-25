From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 25 Sep 2019 16:15:10 +0200
Subject: [v1, 0/1] gpio: dts: aspeed: Add SGPIO driver
In-Reply-To: <1569351740-6285-1-git-send-email-hongweiz@ami.com>
References: <1569351740-6285-1-git-send-email-hongweiz@ami.com>
Message-ID: <CACRpkdbhRo62inQS96OfFO4iWkLn2+P+w1+6g+Y=HFvVyVnXAA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 24, 2019 at 9:02 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> The related SGPIO driver has been accepted and merged into v5.4:
> _http://patchwork.ozlabs.org/patch/1150357/

Oh what a mess, it didn't add the necessary code into Kconfig
and Makefile, also names it sgpio-gpio.c when everything
else is named gpio-sgpio.c.

I guess I have to fix it up. My fault for missing.

Linus Walleij
