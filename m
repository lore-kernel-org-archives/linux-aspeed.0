From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Aug 2017 11:25:31 +0200
Subject: [RESEND PATCH 1/2] dt-bindings: gpio: aspeed: Remove reference to
 clock name
In-Reply-To: <20170808061634.11857-2-andrew@aj.id.au>
References: <20170808061634.11857-1-andrew@aj.id.au>
 <20170808061634.11857-2-andrew@aj.id.au>
Message-ID: <CACRpkdbzU2=-ny962gZ+-3+Gdme3ohewfaqozkfk6q1Wy1dHKg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 8, 2017 at 8:16 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> HPLL was in fact not the clock we need. Remove prescription of which
> clock to avoid further error. Please refer to your datasheet and double
> check like I should have.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied with the ACKs.

Yours,
Linus Walleij
