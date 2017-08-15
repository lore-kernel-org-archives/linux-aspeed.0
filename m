From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Aug 2017 11:26:44 +0200
Subject: [RESEND PATCH 2/2] gpio: aspeed: Remove reference to clock name
 in debounce warning message
In-Reply-To: <20170808061634.11857-3-andrew@aj.id.au>
References: <20170808061634.11857-1-andrew@aj.id.au>
 <20170808061634.11857-3-andrew@aj.id.au>
Message-ID: <CACRpkdZB47CVqTLrAAb==uNOujxK0BFOJ2Yro+g7Jj3MROn+bw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 8, 2017 at 8:16 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> HPLL was in fact not the clock we need. Remove description of which
> clock to avoid any further error.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied with Joel's ACK.

Yours,
Linus Walleij
