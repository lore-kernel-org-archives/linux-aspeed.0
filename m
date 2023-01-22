From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 23 Jan 2023 08:47:10 +1030
Subject: KCS over eSPI
In-Reply-To: <CAJTGxZH2VAn8-=LKuA76bGkrXtm1y99LW_-yDqh52UX7Kd4tZw@mail.gmail.com>
References: <CAJTGxZH2VAn8-=LKuA76bGkrXtm1y99LW_-yDqh52UX7Kd4tZw@mail.gmail.com>
Message-ID: <79c1441e-20dd-4c2a-8dfc-a8fdaded20b7@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 21 Jan 2023, at 11:40, Vijay Khemka wrote:
> Team,
> I am planning to use eSPI interface instead of LPC on aspeed. I see some
> patches by intel for espi slave driver but I need to integrate this with
> KCS. Our current upstream version of KCS only supports LPC. Please point me
> to any patches available to support KCS over eSPI.

Aspeed were doing some work for eSPI support a while back, but beyond 
that I'm not aware of any patches to bring to your attention. Also, IBM 
isn't planning on exploiting eSPI from what I know, so I don't think 
we'll have much motivation to get the driver side of things worked out 
ourselves.

Andrew
