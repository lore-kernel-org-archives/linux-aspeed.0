From: Tao Ren <taoren@fb.com>
Date: Wed, 3 Oct 2018 07:46:00 +0000
Subject: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
In-Reply-To: <CACRpkdZXum+bQg1FO+EHhKWpxtPYXfeRhoAKkFXeMQh1Jng3Ww@mail.gmail.com>
References: <20181002041437.2493192-1-taoren@fb.com>
 <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
 <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
 <CACRpkdZXum+bQg1FO+EHhKWpxtPYXfeRhoAKkFXeMQh1Jng3Ww@mail.gmail.com>
Message-ID: <966C48A9-98F7-4B2B-BCD0-FAF3066C5794@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/2/18, 11:57 PM, "Linus Walleij" <linus.walleij@linaro.org> wrote:

> My thought is go for (2) and do all changes in one patch :)

No problem, Linus.
One more question: looks like my first patch 4451d3f59f2a (fix set_next_event handler) is not merged back to "timers/core". Should I generate this patch on top of the first patch or on top of the current "timers/core"? Which one would be easier for you (or Daniel/Thomas)? Sorry I'm pretty new to the community..

Thanks,
Tao Ren


