From: Tao Ren <taoren@fb.com>
Date: Tue, 2 Oct 2018 22:08:07 +0000
Subject: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
In-Reply-To: <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
References: <20181002041437.2493192-1-taoren@fb.com>
 <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
Message-ID: <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/02/2018 12:35 AM, Linus Walleij wrote:

> This struct member "count_down" is a bit badly named now don't you think?
> The patch is fine semantically, but please rename this member "is_aspeed" or something like that and update the code everywhere,

Thank you Linus for the quick review.
I was actually planning a cleanup patch which handles is_aspeed/count_down stuff. Basically we have 2 options:
??? 1) adding "is_aspeed" flag. "count_down" is kept because potentially faraday-fttmr could also be configured as count_down timer (although I don't see any reason to do so).
??? 2) renaming "count_down" to "is_aspeed". By doing this, we set restriction that faraday-fttmr will always be upward.
What's your thought? Do you want me to include all the changes in this diff?

> then insert a comments like
> /* The Aspeed variant counts downward */
> /* The Aspeed variant does not have a match interrupt */
> in the code snippets so we see what is going on.

Make sense. Let me add more comments.


Thanks,
Tao Ren
