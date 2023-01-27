From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Jan 2023 13:38:53 +0100
Subject: [PATCH] pinctrl: aspeed: Force to disable the function's signal
In-Reply-To: <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
 <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com> <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
Message-ID: <CACRpkdZPxZgWJ3jjiesOFGXmwzZFqeByZyx1VCy5pDWyVQHy+A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 19, 2023 at 2:54 AM Joel Stanley <joel@jms.id.au> wrote:

> As foreseen by Andrew, this caused a regression. On the Romulus
> machine the device tree contains a gpio hog for GPIO S7. With the
> patch applied:

OK shall I just revert the patch?

Yours,
Linus Walleij
