From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Aug 2017 12:30:34 +0930
Subject: [RESEND PATCH 2/2] gpio: aspeed: Remove reference to clock name
 in debounce warning message
In-Reply-To: <20170808061634.11857-3-andrew@aj.id.au>
References: <20170808061634.11857-1-andrew@aj.id.au>
 <20170808061634.11857-3-andrew@aj.id.au>
Message-ID: <CACPK8XfGohtL9d-RHryuLOGKGgyVQpmn-P3NejzeVg1TGaxbMQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 8, 2017 at 3:46 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> HPLL was in fact not the clock we need. Remove description of which
> clock to avoid any further error.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Joel Stanley <joel@jms.id.au>
