From: Joel Stanley <joel@jms.id.au>
Date: Mon, 30 Jan 2023 03:06:46 +0000
Subject: [PATCH] pinctrl: aspeed: Force to disable the function's signal
In-Reply-To: <CACRpkdZPxZgWJ3jjiesOFGXmwzZFqeByZyx1VCy5pDWyVQHy+A@mail.gmail.com>
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
 <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com> <CACPK8XfQ=uarsOgJ7LaXqLyGG2vSF-47RkAEV=T2gruapx-yfg@mail.gmail.com>
 <CACRpkdZPxZgWJ3jjiesOFGXmwzZFqeByZyx1VCy5pDWyVQHy+A@mail.gmail.com>
Message-ID: <CACPK8XcL-T_zv0aoeM5DJzGirp6dqD9UOn6=enSZDLao6hg2bg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 27 Jan 2023 at 12:39, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Jan 19, 2023 at 2:54 AM Joel Stanley <joel@jms.id.au> wrote:
>
> > As foreseen by Andrew, this caused a regression. On the Romulus
> > machine the device tree contains a gpio hog for GPIO S7. With the
> > patch applied:
>
> OK shall I just revert the patch?

Yep! I was going to send a revert but I thought I should write up a
commit message. If you're happy just putting a revert in with a note
that it caused a regression that's enough for me.
