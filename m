From: Joel Stanley <joel@jms.id.au>
Date: Fri, 2 Aug 2019 03:02:30 +0000
Subject: [PATCH] ARM: dts: aspeed: Add Facebook Wedge100 BMC
In-Reply-To: <20190802010155.489238-1-taoren@fb.com>
References: <20190802010155.489238-1-taoren@fb.com>
Message-ID: <CACPK8XdS4m9+74oxK0-ed3ZLr_QCh--AsFgGcF-OpLw24v9g4Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2 Aug 2019 at 01:02, Tao Ren <taoren@fb.com> wrote:
> +
> +       chosen {
> +               stdout-path = &uart3;
> +               bootargs = "debug console=ttyS2,9600n8 root=/dev/ram rw";

Are you sure you want 'debug' in your boot arguments?

The rest lgtm. I can remove debug when applying, or leave it there if
it was intentional.

Cheers,

Joel
