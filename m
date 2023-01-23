From: Vijay Khemka <vijaykhemkalinux@gmail.com>
Date: Mon, 23 Jan 2023 13:26:04 -0800
Subject: KCS over eSPI
In-Reply-To: <79c1441e-20dd-4c2a-8dfc-a8fdaded20b7@app.fastmail.com>
References: <CAJTGxZH2VAn8-=LKuA76bGkrXtm1y99LW_-yDqh52UX7Kd4tZw@mail.gmail.com>
 <79c1441e-20dd-4c2a-8dfc-a8fdaded20b7@app.fastmail.com>
Message-ID: <CAJTGxZErSFzAieHntqQTiFYJX3n4OiPmgoBdCczdHw=9HWP6Ww@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks Andrew,
I guess Intel has done this because I saw the espi slave driver patch by
them, I am assuming they must have made changes to KCS to make use of eSPI
instead of LPC.

Thanks again for the info, I will keep looking for a solution.

Regards
-Vijay

On Sun, Jan 22, 2023 at 2:17 PM Andrew Jeffery <andrew@aj.id.au> wrote:

>
>
> On Sat, 21 Jan 2023, at 11:40, Vijay Khemka wrote:
> > Team,
> > I am planning to use eSPI interface instead of LPC on aspeed. I see some
> > patches by intel for espi slave driver but I need to integrate this with
> > KCS. Our current upstream version of KCS only supports LPC. Please point
> me
> > to any patches available to support KCS over eSPI.
>
> Aspeed were doing some work for eSPI support a while back, but beyond
> that I'm not aware of any patches to bring to your attention. Also, IBM
> isn't planning on exploiting eSPI from what I know, so I don't think
> we'll have much motivation to get the driver side of things worked out
> ourselves.
>
> Andrew
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230123/533d1811/attachment.htm>
