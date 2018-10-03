From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Oct 2018 08:56:53 +0200
Subject: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
In-Reply-To: <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
References: <20181002041437.2493192-1-taoren@fb.com>
 <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
 <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
Message-ID: <CACRpkdZXum+bQg1FO+EHhKWpxtPYXfeRhoAKkFXeMQh1Jng3Ww@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 3, 2018 at 12:08 AM Tao Ren <taoren@fb.com> wrote:

>     1) adding "is_aspeed" flag. "count_down" is kept because potentially faraday-fttmr could also be configured as count_down timer (although I don't see any reason to do so).
>     2) renaming "count_down" to "is_aspeed". By doing this, we set restriction that faraday-fttmr will always be upward.
> What's your thought? Do you want me to include all the changes in this diff?

My thought is go for (2) and do all changes in one patch :)

Yours,
Linus Walleij
